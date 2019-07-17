# neovim-configs

## PreRequisites

This is basically my ~/.config/nvim directory

I'm running the nightly build of [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
([ppa](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable)), the main reason is that neovim
before 4.x does not have support for floating windows.

Plain neovim is nice, but [there are many different UI's available](https://github.com/neovim/neovim/wiki/Related-projects#gui)
The GUI I'm currently using is [neovim-gtk](https://github.com/daa84/neovim-gtk)

## Setup

I remember doing quite a few things and I know most of the things were from
following various instructions for setting up plugins and/or metals but here are
some of the things I do remember:

### metals

The [instructions](https://scalameta.org/metals/docs/editors/vim.html#generating-metals-binary)
for setting up metals gives a similar command line to this for grabbing the jar,
but I already have [coursier](https://github.com/coursier/coursier), like to
keep it in `~/bin` and frequently update to the latest SNAPSHOT so I use this
script instead:

```sh
#!/bin/bash
# Update courier and metals, the scala language server
# https://scalameta.org/metals/docs/editors/vim.html#installing-vim

current="0.7.0"
current="0.7.0+45-2d3960b4-SNAPSHOT"
default="${version:-"${current}"}"

echo "grabbing latest version of coursier"
curl -sSLo ~/bin/coursier https://git.io/coursier && chmod 755 ~/bin/coursier

scala=2.12
version="${version:-$default}"
repo="sonatype:releases"
if [[ "${version}" == *SNAPSHOT* ]]; then
  repo="sonatype:snapshots"
fi

echo "updating metals to version ${current}"

coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=coc.nvim \
  "org.scalameta:metals_${scala}:${version}" \
  -r bintray:scalacenter/releases \
  -r "${repo}" \
  -o ~/bin/metals-vim -f
```

### pyenv

Followed some tips from this posting, to install the neovim plugin for both
[python 2.x and 3.x](https://sk1u.com/blog/2018/04/16/pyenv-neovim)

```sh
pyenv virtualenv 2.7.16 neovim2
pyenv virtualenv 3.6.8 neovim3

pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path

pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path
```

### things I'm forgetting

TODO

it's been a lifetime since I've really done anything in js, but I still use [nvm](https://github.com/nvm-sh/nvm) to manage node..
I think most of what I didn't explcitly write about in here are covered going through the coc docs: https://github.com/neoclide/coc.nvim#table-of-contents


## Language Servers

For an LSP client, I'm using [coc.nvim](https://github.com/neoclide/coc.nvim)

I will likely add others but metals is what drew my interest into LSP/vim to
see what it was like.

### Scala

For Scala, I'm using [metals](https://scalameta.org/metals/docs/editors/vim.html)
