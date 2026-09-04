# dotfiles

Personal configuration backup for a Niri + Noctalia desktop on Arch Linux.

## Structure

| Folder / File       | Symlinked to                                                  | Notes |
|----------------------|-----------------------------------------------------------------|-------|
| `niri/`              | `~/.config/niri`                                                | Compositor config (`config.kdl`) |
| `noctalia/`           | `~/.config/noctalia` **or** `~/.config/quickshell/noctalia-shell` | Depends on Noctalia version — v5 uses `~/.config/noctalia` (TOML), v4 (Quickshell-based) uses the quickshell path. Check which one applies before restoring. |
| `alacritty/`          | `~/.config/alacritty`                                            | Terminal config |
| `fastfetch/`          | `~/.config/fastfetch`                                            | System info fetch tool |
| `hyfetch.json`        | `~/.config/hyfetch.json`                                         | Single file, not a folder — lives directly in `~/.config` |

## Restoring on a new machine

1. Install the required packages (niri, noctalia, alacritty, fastfetch, hyfetch).
2. Clone this repo:
   ```
   git clone git@github.com:con8r/dotfiles.git ~/dotfiles
   ```
3. Symlink each config into place:
   ```
   ln -s ~/dotfiles/niri ~/.config/niri
   ln -s ~/dotfiles/noctalia ~/.config/noctalia
   ln -s ~/dotfiles/alacritty ~/.config/alacritty
   ln -s ~/dotfiles/fastfetch ~/.config/fastfetch
   ln -s ~/dotfiles/hyfetch.json ~/.config/hyfetch.json
   ```
4. Check machine-specific values before relying on the config — output/monitor names and resolutions in the niri config's `output` block are hardware-specific and will need adjusting.
5. Reload Niri or log back in.

## Updating the backup

Since configs are symlinked, editing the live config edits the repo directly. Just commit and push when you want to save changes:

```
cd ~/dotfiles
git add -A
git commit -m "update configs"
git push
```

## Auth

This repo is pushed over SSH. If cloning/pushing fails with an auth error, make sure your SSH key is added to your GitHub account and the remote uses the `git@github.com:...` form, not `https://`.
