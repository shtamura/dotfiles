# dotfiles

## Installation

### macOS

```bash
if [ ! -e /etc/.zshenv ]; then
    echo 'export ZDOTDIR=$HOME' >> /etc/.zshenv
fi

make osx
```

### debian

```bash
apt update && apt install make

make debian
```
