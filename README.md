# nvmrc_use

**Author:** Chris Chapman

## Synopsis

A zsh plugin/shell-file that causes `nvm use` to be called whenever the current
or parent directory has a `.nvmrc` file with a string telling _nvm_ a desired
node version to use. This also call `nvm use default` when leaving to a
directory that does not have an `.nvmrc` file should affect it.

Inspired by [NVM deeper-shell-integration](https://github.com/nvm-sh/nvm#deeper-shell-integration)

## How to set up

### Manually install

Make sure this file is sourced by your `zshrc` or appropriate file.
It MUST be placed after nvm initialization!

### Other notes

```zsh
autoload -Uz nvmrc_use
```

#### For example

```shell
# download all files
cd /path/to/dir
git clone https://github.com/seattlechris/nvm_use.git
```

And add the following lines to your .zshrc:

```zsh
fpath=(/path/to/dir/nvm_use(N-/) $fpath)

autoload -Uz nvm_use
```

### Installing using Antigen

If you use [Antigen](https://github.com/zsh-users/antigen), add the following line to your .zshrc:

```zsh
antigen bundle seattlechris/nvm_use
```

### Using Oh-my-zsh

If you use [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh):

1. Clone this repository into your custom plugins directory:
    `git clone https://github.com/seattlechris/nvm_use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/nvm_use`

2. Activate the plugin in `~/.zshrc`:
    `plugins=( [plugins...] nvm_use)`

3. Source `~/.zshrc`  to take changes into account:
    `source ~/.zshrc`

### Installing using Zgen

If you use [zgen](https://github.com/tarjoilija/zgen), add the following to your `.zshrc`

```zsh
zgen load seattlechris/nvm_use
```

to your `.zshrc` with your other `zgen load` commands.

## Usage

With the plug-in installed, and you have nvm installed, it should take effect as you enter and exit a directory with a `.nvmrc` file, or a sub-directory of such a directory.

## Options

-h display help and exit
