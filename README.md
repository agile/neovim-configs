# neovim-configs

## PreRequisites

This is basically my ~/.config/nvim directory

I'm running the nightly build of [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
([ppa](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable))

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
# https://scalameta.org/metals/docs/editors/vim.html#installing-vim

# default=0.5.2
current="0.5.2+9-f28c35ac-SNAPSHOT"
default="${version:-"${current}"}"

scala=2.12
version="${version:-$default}"
repo="sonatype:releases"
if [[ "${version}" == *SNAPSHOT* ]]; then
  repo="sonatype:snapshots"
fi

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

## Language Servers

For an LSP client, I'm using [coc.nvim](https://github.com/neoclide/coc.nvim)

I will likely add others but metals is what drew my interest into LSP/vim to
see what it was like.

### Scala

For Scala, I'm using [metals](https://scalameta.org/metals/docs/editors/vim.html)
