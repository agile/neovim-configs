# My neovim configs


This is basically my ~/.config/nvim directory.

I'm running the nightly build of [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
([ppa](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable)) or `brew install --head neovim`.

I also tend to run nvim from a GUI, currently that tends to be [neovide](https://github.com/neovide/neovide),
but [there are many different UI's available](https://github.com/neovim/neovim/wiki/Related-projects#gui).


Most of this was at least initially done while going through chris@machine's series of videos on:
[Neovim from Scratch](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)


### Notes and Nits I'm still working out

#### Completion

Sometimes completion is getting triggered in insert mode when I don't really
want it to and knives come out when I hit enter at the same time the completion
pops up and get some correction I didn't ask for.

I think it's mostly/always coming from the buffer, so I've added a
`keyword_length` clause to keep it from being triggered on words fewer than N (5)
chars to see if that helps, or may just disable buffer suggestions.

#### Colorscheme

I'd been using the [brookstream](https://www.vim.org/scripts/script.php?script_id=619) colorscheme
for many years, but trying to use something more up to date with all the new
stuff that's happened in the last 20years.

Currently flipping between:
* [tokyonight](https://github.com/folke/tokyonight.nvim) with `night` style.
* [catpuccin](https://github.com/catppuccin/nvim)

### Pyenv, Pyright, amiright...?

Issues with pyright vs pyenv are basically that pyright does not automagically
know when I'm in a project using a venv so it's unable to resolve imports, etc.

My attempts [to dynamically configure pyright](https://github.com/agile/neovim-configs/commit/c18fd6f22ff6a6bf5f7c8cad3127869fc0b5247d)
were unsuccessful.

Update: creating a `pyrightconifg.json` (via https://github.com/alefpereira/pyenv-pyright)
appears to fix it so I'm thinking to add a `pyenv pyright` statement to python
project's `.envrc` so that direnv always ensures it's up to date when I enter
the project dir and add an ignore for the json config.

### Copy/Paste issues

Copy/Paste is still a mixed bag, and I think part of this is simply a different
experience on macos vs linux since I'm doing this lua setup from a mac now, but
for some reason it's not working in neovide? but does in kitty (terminal)? Oh,
also sometimes pasting in neovide translates newlines into ye ol dos/win carriage
returns (; what the heck?)
  - https://github.com/neovide/neovide/discussions/1220
    this definitely helps, there's still some weirdness

-- heh, neovide does this odd thing when I copy/paste through https://github.com/debauchee/barrier from a linux machine
-- where it seems to add dos-style carriage returns, NOT SURE WHY..
-- fileformat is always unix.. https://github.com/neovide/neovide/blob/a28d72a284882d713fbc291ce9fe164e608e5b0f/src/bridge/handler.rs#L39-L57
-- so I'm not sure how this is happening https://github.com/neovide/neovide/blob/a28d72a284882d713fbc291ce9fe164e608e5b0f/src/bridge/clipboard.rs#L11-L16
-- this was my attempt to hack a work-around :P it's pretty gross and dysfunctional
-- vim.keymap.set("n", "<D-v>", [[:let @*="<c-r><c-r>*"<c-f><s-V>:s//\r/g<cr><cr>"*p]])

## TODO

  In no particular order, maybe, these are some of the next things I intend to do..

* I went through chris@machine's Neovim from Scratch series: https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ
  seems a number of things should be updated..
  - keymaps should now use vim.keymaps vs vim.api.nvim_set_keymap
  -  Refactor https://github.com/williamboman/nvim-lsp-installer
      To use these instead, to manage LSP services:
        https://github.com/williamboman/mason.nvim
        https://github.com/williamboman/mason-lspconfig.nvim
* DAP integration: https://www.youtube.com/watch?v=0moS8UHupGc
* Inline test integration: https://www.youtube.com/watch?v=cf72gMBrsI0
* Telescope-ish Zettlekasten https://github.com/renerocksai/telekasten.nvim
* Create a minimal suite of viml configs I can use when/where nvim is not available.
* Integrations for more languages
* Host based overrides
* PIN THE PLUGINS :P, it's like a timebomb right now as every time I touch plugins.lua, packer's going
  to sync up and apply the latest updates and some of these things are likely to have breaking changes
  I would much rather handle the upgrades manually or decide which things I'd be fine with riding
  on the edge.
* Telescope extensions
  * https://github.com/pwntester/octo.nvim - edit/review GH issues/prs from nvim
  * https://github.com/softinio/scaladex.nvim - import/open packages from scaladex scala package index
  * https://github.com/nvim-telescope/telescope-github.nvim - GH integration with Telescope
  * https://github.com/crispgm/telescope-heading.nvim - Jump around headings in docs
  * https://github.com/LinArcX/telescope-env.nvim - Telescope ext for env vars
  * https://github.com/ANGkeith/telescope-terraform-doc.nvim - Telescope ext to browse terraform docs
* https://github.com/anuvyklack/windows.nvim - auto-resize windows
* https://github.com/dccsillag/magma-nvim - jupyter
* https://github.com/magidc/aerial.nvim - Code outline navigator


* https://github.com/magidc/nvim-config - This guy's config looks awesome, lots to draw from here.
* https://github.com/ThePrimeagen/vim-be-good
