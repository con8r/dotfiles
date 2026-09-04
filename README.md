# dotfiles

Personal configuration backup for a Niri + Noctalia desktop on Arch Linux.

## Structure

| Folder / File       | Symlinked to                                                  | Notes |
|----------------------|-----------------------------------------------------------------|-------|
| `niri/`              | `~/.config/niri`                                                | Compositor config (`config.kdl`) |
| `noctalia/`           | `~/.config/noctalia`                                             | Noctalia v5 settings (`settings.json`) |
| `alacritty/`          | `~/.config/alacritty`                                            | Terminal config + theme |
| `fastfetch/`          | `~/.config/fastfetch`                                            | System info tool, custom ASCII logo + theme |
| `hyfetch.json`        | `~/.config/hyfetch.json`                                         | Single file, lives directly in `~/.config` |
| `install.sh`          | —                                                                 | Installs every dependency below in one go |

## Dependencies

Compiled from every binary referenced across `niri/config.kdl`, `alacritty/alacritty.toml`, `fastfetch/config.jsonc`, and `hyfetch.json`. Run `./install.sh` to install all of these in one go (official repo packages via `pacman`, AUR packages via `paru`/`yay` if available).

**Core**
- `niri` — compositor
- `noctalia-shell` (AUR — check current package name, e.g. `noctalia-shell-git`) — bar/shell, launched via `spawn-at-startup "noctalia"`
- `alacritty` — terminal (`Mod+T`)

**Fonts**
- `ttf-jetbrains-mono-nerd` — used in `alacritty.toml`

**System / session**
- `polkit-gnome` — spawned as `/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1`
  - Note: this package was dropped from most distro repos at some point — verify it's still installable, or swap to `polkit-kde-agent` if not.
- `swaylock` — screen lock (`Super+Alt+L`)
- `orca` — screen reader toggle (`Super+Alt+S`)
- `pipewire` + `wireplumber` — volume/mic keys via `wpctl`
- `playerctl` — media keys
- `brightnessctl` — brightness keys

**Wallpaper**
- `linux-wallpaperengine` (AUR) — spawned at startup targeting output `DP-4`

**Apps bound in `binds {}`**
- `zen-browser` (AUR or Flatpak) — `Mod+B`
- `flatpak` + Spotify Flatpak (`com.spotify.Client`) — `Mod+Y`
- `discord` — `Mod+D`
- `nautilus` — `Mod+E`

**Fetch tools**
- `fastfetch` — used as the hyfetch backend and directly
- `hyfetch` (AUR or `pip install hyfetch`)

**Possibly leftover**
- `waybar` — still has a `spawn-at-startup "waybar"` line in `config.kdl` even though Noctalia provides the bar. Confirm whether this is intentional (e.g. fallback bar) or a leftover from before switching to Noctalia. Not installed by `install.sh`.

## Restoring on a new machine

1. Clone this repo:
   ```
   git clone git@github.com:con8r/dotfiles.git ~/dotfiles
   ```
2. Install dependencies:
   ```
   cd ~/dotfiles
   chmod +x install.sh
   ./install.sh
   ```
3. Symlink each config into place:
   ```
   ln -s ~/dotfiles/niri ~/.config/niri
   ln -s ~/dotfiles/noctalia ~/.config/noctalia
   ln -s ~/dotfiles/alacritty ~/.config/alacritty
   ln -s ~/dotfiles/fastfetch ~/.config/fastfetch
   ln -s ~/dotfiles/hyfetch.json ~/.config/hyfetch.json
   ```
4. Check machine-specific values before relying on the config:
   - `output "DP-4" { mode "2560x1440@240.002" }` and the commented `eDP-1` block are hardware-specific.
   - The `linux-wallpaperengine` spawn line hardcodes both an output name (`DP-4`) and a wallpaper path under `/home/con8r/...` — update both for a new machine/user.
   - `hyfetch.json` also hardcodes `/home/con8r/.config/fastfetch/con8rfetch.txt` as the ASCII path.
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
