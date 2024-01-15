#!bin/zsh

PUBLIC_KEYS=$( cat "$BASE_PATH"/keys/*.pub )
PUBLIC_KEY="${PUBLIC_KEYS[0]}"
git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global user.signingKey "$PUBLIC_KEY"
git config --global gpg.ssh.allowedSignersFile "~/.config/git/allowed_signers"