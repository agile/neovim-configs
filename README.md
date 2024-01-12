My neovim configs
=================

* Currently using Neovim >= 0.9.4 and generally Neovide >= ~0.12.1~ HEAD

### Notes and Nits I'm still working out


#### Colorscheme

* [lushy-blues](https://github.com/agile/lushy-blues), my attempt to update the
  [brookstream](https://www.vim.org/scripts/script.php?script_id=619) colorscheme
  I've been using forever to bring it up to date with all the stuff that's happened
  in the alst 20+ years.

#### Pyenv, Pyright, amiright...?

Issues with pyright vs pyenv are basically that pyright does not automagically
know when I'm in a project using a venv so it's unable to resolve imports, etc.

* Using [pyenv-pyright](https://github.com/alefpereira/pyenv-pyright) to generate
  a `pyrightconifg.json` config has mostly worked to resovle this issue.

#### Copy/Paste issues

Copy/Paste is still a mixed bag, and I think part of this is simply a different
experience on macos vs linux since I'm doing this lua setup from a mac now, but
for some reason it's not working in neovide? but does in kitty (terminal)? Oh,
also sometimes pasting in neovide translates newlines into ye ol dos/win carriage
returns (; what the heck?)
  - https://github.com/neovide/neovide/discussions/1220
    this definitely helps, there's still some weirdness

heh, neovide does this odd thing when I copy/paste through [barrier](https://github.com/debauchee/barrier)
from a linux machine where it seems to add dos-style carriage returns, NOT SURE WHY.. fileformat is always unix.. so I'm not sure how this is happening
* https://github.com/neovide/neovide/blob/a28d72a284882d713fbc291ce9fe164e608e5b0f/src/bridge/handler.rs#L39-L57
* https://github.com/neovide/neovide/blob/a28d72a284882d713fbc291ce9fe164e608e5b0f/src/bridge/clipboard.rs#L11-L16

## TODO

### FIXMES

* not getting syntax hightlighted diffs when committing
* nix lsp not installing on mac, need to look into that or  make it conditional?
* Try and improve the terragrunt experience..
  https://github.com/hashicorp/vscode-terraform/issues/239#issuecomment-1139572794
  https://github.com/search?q=repo%3Ahashivim%2Fvim-terraform+terragrunt&type=pullrequests

### MAYBES

In no particular order, these are some of the other next things I maybe definitely intend to maybe do..

* Inline test integration: https://www.youtube.com/watch?v=cf72gMBrsI0
* Telescope-ish Zettlekasten https://github.com/renerocksai/telekasten.nvim
* Create a minimal suite of viml configs I can use when/where nvim is not available.
* Telescope extensions
  * https://github.com/pwntester/octo.nvim - edit/review GH issues/prs from nvim
  * https://github.com/softinio/scaladex.nvim - import/open packages from scaladex scala package index
  * https://github.com/nvim-telescope/telescope-github.nvim - GH integration with Telescope
  * https://github.com/crispgm/telescope-heading.nvim - Jump around headings in docs
  * https://github.com/LinArcX/telescope-env.nvim - Telescope ext for env vars
  * https://github.com/ANGkeith/telescope-terraform-doc.nvim - Telescope ext to browse terraform docs
* https://github.com/anuvyklack/windows.nvim - auto-resize windows
* https://github.com/napisani/nvim-github-codesearch
* Some SQL love..
  * https://github.com/tpope/vim-dadbod
    * https://github.com/kristijanhusak/vim-dadbod-ui
    * https://github.com/kristijanhusak/vim-dadbod-completion
  * https://github.com/jorgerojas26/lazysql
  * https://github.com/joe-re/sql-language-server
  * https://github.com/kndndrj/nvim-dbee
* Some Jupyterness..?
  * https://github.com/benlubas/molten-nvim
  * https://github.com/dccsillag/magma-nvim - jupyter
* Flip-flopper to switch between development/production/etc files in terragrunt repos
  or similar repos that use sensible directory/naming conventionss like test vs code
  being in mirrored paths.. which lends toward being able to predicat the expected relative
  location for related files that can be created/and-or switched between.
  Use to have something like this a long time ago and miss it dearly.
* Markdown previews, https://github.com/iamcco/markdown-preview.nvim is the one I've used most
* https://github.com/jbyuki/venn.nvim
