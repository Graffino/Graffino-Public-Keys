#!bin/zsh
USER=$(stat -f "%Su" /dev/console)

#!/bin/zsh

# Define the array with public key files
PUBLIC_KEYS=( "/Users/$USER/.ssh/"*.pub )

# Check if the array is not empty
if (( ${#PUBLIC_KEYS[@]} > 0 )); then
    echo "Available SSH Public Keys:"
    for i in "${!PUBLIC_KEYS[@]}"; do
        echo "[$((i+1))] ${PUBLIC_KEYS[i]}"
    done
    
    # Ask the user to choose a key
    echo "Choose a key by number (1-${#PUBLIC_KEYS[@]}): "
    read KEY_NUMBER
    
    # Check if the input is a valid number
    if [[ "$KEY_NUMBER" =~ ^[0-9]+$ ]] && (( KEY_NUMBER >= 1 && KEY_NUMBER <= ${#PUBLIC_KEYS[@]} )); then
        PUBLIC_KEY="${PUBLIC_KEYS[$((KEY_NUMBER-1))]}"
    else
        echo "Invalid selection. Exiting."
        exit 1
    fi
    
    git config --global gpg.format ssh
    git config --global commit.gpgsign true
    git config --global tag.gpgsign true
    git config --global user.signingKey "$PUBLIC_KEY"
    git config --global gpg.ssh.allowedSignersFile "~/.config/git/allowed_signers"
    
    echo "Selected key configured:" $(git config --global user.signingKey)
else
    echo "No public key files found."
fi