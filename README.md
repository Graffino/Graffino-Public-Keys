# Graffino-Public-Keys

This repo is the source for the graffino `allowed_signers` file for commit signing across the organization.

## Add your key

1. Add your file to the `keys` folder in the `firstname.lastname.key.pub`.
2. Make sure the comment in your public key is in the `Firstname Lastname (firstname.lastname@graffino.com)` format.
3. Create a PR with your commit and wait for it to be approved.
4. Keys are updated every 30 minutes.

## Configure Git

1. Run `configure.sh` or just:

```bash
    PUBLIC_KEYS=$( cat "$BASE_PATH"/keys/*.pub )
    PUBLIC_KEY="${PUBLIC_KEYS[0]}"
    git config --global gpg.format ssh
    git config --global commit.gpgsign true
    git config --global tag.gpgsign true
    git config --global user.signingKey "$PUBLIC_KEY"
    git config --global gpg.ssh.allowedSignersFile "~/.config/git/allowed_signers"
``

## Update your GitHub account with a signing key

1. Copy your public key to the clipboard: `pbcopy < ~/.ssh/firstname.lastname.pub` (make sure the correct filename is here.)
1. Go to [Github Keys](https://github.com/settings/keys)
2. Select `New SSH Key`
3. Select `Key type` as `Signing Key`
4. Paste your public key
5. Press `Add SSH Key`.

Note: Do NOT delete any of the GPG keys stored there. These must remain there for all eternity or else the commits signed with them will become untrusted.

## Configure Tower

1. Go to Settings (`CMD + .`)
2. Select Git Config
3. Go to Global signing key and select your SSH key from the list
4. Go to Allowed signers file and select `~./config/git/allowed_signers` as input

Note: If you can't get to the allowed signers file press `CMD + SHIFT +G` when you are in the select window and enter the destination manually.
