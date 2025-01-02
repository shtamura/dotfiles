# dotfiles

## Installation

### macOS

#### prepare

```bash
if [ ! -e /etc/.zshenv ]; then
    echo 'export ZDOTDIR=$HOME' >> /etc/.zshenv
```

#### install

```bash
make osx
```

### Linux

```bash
make linux
```
