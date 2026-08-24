# AD-Blue Dotfiles
My configs. Use `stow` to symlink the ones you want to use:
```bash
> stow tmux // creates a symlink in ~/.config/tmux
```

The above assumes that you've cloned this repo into your `~` dir. If you want to clone it elsewhere, then use `stow`'s `-t` flag to target the specific path.
```bash
> stow -t ~ tmux
```

Note that if you already have a `~/.config/tmux` dir or `~/.config/nvim` dir, you'll likely get a conflict when running these commands.
You'll either need to move those directories or change their name.
