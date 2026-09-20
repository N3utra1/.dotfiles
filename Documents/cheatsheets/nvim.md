# Neovim cheatsheet

Your setup: Neovim 0.12.5 + LazyVim 16.0.0, gruvbox light, snacks.nvim picker,
snacks.nvim explorer, blink.cmp completion, Claude Code integration.

## Survival

| Key | Action |
|---|---|
| `Esc` | Return to Normal mode. Press it when confused |
| `i` | Insert mode — start typing before the cursor |
| `a` | Insert mode — start typing after the cursor |
| `o` | Open a new line below and start typing |
| `v` | Visual mode — select text |
| `V` | Visual mode — select whole lines |
| `:` | Command mode — type a command, then Enter |
| `<C-s>` | Save file (works in insert mode too) |
| `:w` | Save |
| `:q` | Quit this window |
| `:wq` | Save and quit |
| `:q!` | Quit, discard changes |
| `<leader>qq` | Quit everything |
| `u` | Undo |
| `<C-r>` | Redo |
| `<leader>?` | Show every key available in this buffer |

## Moving around

| Key | Action |
|---|---|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` / `b` | Forward / back one word |
| `0` / `^` / `$` | Start of line / first non-blank / end of line |
| `gg` / `G` | Top / bottom of file |
| `{number}G` | Go to line number, e.g. `42G` |
| `<C-u>` / `<C-d>` | Half page up / down |
| `%` | Jump to matching bracket |
| `*` / `#` | Search forward/back for the word under the cursor |
| `/text` then Enter | Search forward for "text" |
| `?text` then Enter | Search backward |
| `n` / `N` | Next / previous search result |
| `<leader>ss` | Flash jump — type 2 chars, jump anywhere on screen |
| `S` | Flash Treesitter — select by code structure |
| `<C-o>` / `<C-i>` | Jump back / forward through your jump history |
| `<leader>sj` | Pick from the jump list |

## Editing

| Key | Action |
|---|---|
| `x` | Delete character under cursor |
| `dd` | Delete (cut) current line |
| `yy` | Yank (copy) current line |
| `p` / `P` | Paste after / before cursor |
| `dw` / `cw` | Delete / change to end of word |
| `d$` / `c$` | Delete / change to end of line |
| `ciw` | Change the whole word under the cursor |
| `ci"` | Change everything inside the quotes |
| `ci(` | Change everything inside the parens |
| `.` | Repeat your last change |
| `>>` / `<<` | Indent / unindent line |
| `<A-j>` / `<A-k>` | Move the current line down / up — also works in insert and visual mode |
| `gcc` | Toggle comment on this line |
| `gc` (in visual) | Toggle comment on selection |
| `gco` / `gcO` | Add a comment line below / above |
| `<leader>sr` | Search and replace across files (grug-far) |
| `]<leader>` / `[<leader>` | Add a blank line below / above |
| `<leader>su` | Undo tree |

## Finding things — the picker

The picker is **snacks.nvim**, not telescope. Telescope is not installed.

| Key | Action |
|---|---|
| `<leader><leader>` | **Find files** — the one you'll use most |
| `<leader>ff` | Find files (project root) |
| `<leader>fF` | Find files (current directory) |
| `<leader>fg` | Find files tracked by git |
| `<leader>fh` / `<leader>f~` | Find files under `$HOME` *(your own binding)* |
| `<leader>fr` / `<leader>fR` | Recently opened files (root / cwd) |
| `<leader>fc` | Find a file in your nvim config |
| `<leader>fn` | New file |
| `<leader>fp` | Projects |
| `<leader>ft` / `<leader>fT` | Floating terminal (root / cwd) |
| `<leader>/` | **Grep** — search file contents |
| `<leader>sg` / `<leader>sG` | Grep (root / cwd) |
| `<leader>sw` / `<leader>sW` | Grep the word under cursor, or the visual selection |
| `<leader>sb` | Search within the current file |
| `<leader>sB` | Grep across all open buffers |
| `<leader>sR` | Resume your last search |
| `<leader>sk` | Search all keymaps — good for learning |
| `<leader>sh` | Search help pages |
| `<leader>sC` | Search all commands |
| `<leader>sc` | Command history |
| `<leader>s/` | Search history |
| `<leader>s"` | Show registers (clipboard slots) |
| `<leader>sm` | Marks |
| `<leader>sa` | Autocmds |
| `<leader>si` | Icons |
| `<leader>sH` | Highlight groups |
| `<leader>sM` | Man pages |
| `<leader>sp` | Search plugin specs |

### Keys *inside* the picker

The picker has two windows: an **input** box (where you type) and the **list**.
Most keys work from insert mode, so you rarely have to leave the prompt.

| Key | Action |
|---|---|
| `<C-j>` / `<C-k>` | Move down / up the list without leaving the prompt |
| `<C-n>` / `<C-p>` | Same, alternative |
| `Enter` | Open |
| `<C-s>` / `<C-v>` / `<C-t>` | Open in horizontal split / vertical split / new tab |
| `<S-Enter>` | Pick which window to open into |
| `Tab` / `<S-Tab>` | Multi-select this entry and move down / up |
| `<C-a>` | Select all |
| `<C-q>` | Send results to the quickfix list |
| `<A-h>` | Toggle hidden files |
| `<A-i>` | Toggle gitignored files |
| `<A-p>` | Toggle the preview pane |
| `<A-m>` | Maximise the picker |
| `<A-f>` | Toggle follow |
| `<A-w>` | Cycle between input and list |
| `<C-g>` | Toggle live mode (re-runs the finder instead of filtering) |
| `<C-b>` / `<C-f>` | Scroll the preview up / down |
| `<C-u>` / `<C-d>` | Scroll the list up / down |
| `<C-Up>` / `<C-Down>` | Previous / next search from history |
| `<C-r><C-w>` | Insert the word under the cursor into the prompt |
| `<C-r>%` | Insert the current filename |
| `/` | Jump between input and list (normal mode) |
| `?` | **Show every key for the picker you're in** |
| `Esc` | Prompt → normal mode. Again → close |

`<C-q>` is the power move: grep, `<C-q>`, then
`:cdo s/old/new/g | update` renames across every match in the project.

## The file explorer

`<leader>e` opens it. It is a snacks picker in tree mode, so the picker keys
above also apply — plus these, which only work when the **list** is focused,
not the input box.

| Key | Action |
|---|---|
| `<leader>e` | Toggle explorer (project root) |
| `<leader>E` | Explorer (current directory) |
| `<leader>f/` | Explorer rooted at `/` *(your own binding)* |
| `l` / `Enter` | Open file, or expand directory |
| `h` | Collapse directory |
| `Z` | Collapse everything |
| `<BS>` | Move the tree root up one directory |
| `.` | Make the directory under the cursor the new root |
| `<C-c>` | `tcd` — set Neovim's working directory to that directory |
| `a` | **Add.** End the name with `/` to make a directory. Nested paths work: `foo/bar/baz.ts` creates the dirs too |
| `d` | **Delete.** Goes to the system trash via `gio`, so it is recoverable from `~/.local/share/Trash` |
| `r` | Rename |
| `c` | Copy |
| `m` | Move |
| `y` | Yank path (also works on a visual selection) |
| `p` | Paste what you yanked |
| `o` | Open with the system application |
| `u` | Refresh the tree |
| `H` | Toggle hidden files |
| `I` | Toggle gitignored files |
| `P` | Toggle the preview pane (off by default) |
| `<leader>/` | **Grep inside the directory under the cursor** |
| `<C-t>` | Open a terminal in that directory |
| `]g` / `[g` | Next / previous git-changed file |
| `]d` / `[d` | Next / previous diagnostic |
| `]w` / `[w` | Next / previous warning |
| `]e` / `[e` | Next / previous error |
| `Tab` | Multi-select — then `d`, `m` or `c` acts on the whole selection |

**Deleting files:** only the explorer can do it. The file picker
(`<leader>ff`) has no delete action. Put the cursor on the file in the
explorer list and press `d`; mark several with `Tab` first to delete a batch.
Both prompt for confirmation, and open buffers for deleted files are closed.

**Searching in the explorer:** press `/` to move from the list into the input
box, then type. Matching directories expand automatically. `<C-j>` and `<C-k>`
move the selection while you stay in the prompt, so the fast path is
type → `<C-j>` → `Enter`. `<C-g>` switches between filtering the already-loaded
tree and re-running the finder over everything below the root.

> The explorer's search **requires `fd`** — `snacks/picker/source/explorer.lua`
> hardcodes `opts.cmd = "fd"` with no fallback to `rg` or `find`. Without it
> browsing works but typing in the search box silently returns nothing. See
> "Things specific to your machine" below.

## Files and buffers

A **buffer** is a file loaded in memory. A **window** is a viewport onto one.

| Key | Action |
|---|---|
| `<leader>,` / `<leader>fb` | Switch buffer from a list |
| `<leader>fB` | All buffers, including unlisted |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `[b` / `]b` | Previous / next buffer |
| `[B` / `]B` | Move this buffer left / right in the bufferline |
| `<leader>bb` | Toggle between the last two buffers |
| `<leader>bd` | Close current buffer |
| `<leader>bD` | Close buffer and its window |
| `<leader>bo` | Close all other buffers |
| `<leader>bi` | Close buffers with no window |
| `<leader>bl` / `<leader>br` | Close buffers to the left / right |
| `<leader>bp` | Pin this buffer |
| `<leader>bP` | Close all buffers except pinned ones |
| `<leader>bj` | Pick a buffer by its bufferline letter |

## Windows and tabs

| Key | Action |
|---|---|
| `<leader>-` | Split window horizontally |
| `<leader>\|` | Split window vertically |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Move to window left/down/up/right |
| `<C-Up>` / `<C-Down>` | Make window taller / shorter |
| `<C-Left>` / `<C-Right>` | Make window narrower / wider |
| `<leader>wd` | Close this window |
| `<leader>uZ` | Zoom this window to fill the screen |
| `<leader>uz` | Zen mode |
| `<leader><tab><tab>` | New tab |
| `<leader><tab>]` / `[` | Next / previous tab |
| `<leader><tab>d` | Close tab |

## Code intelligence (LSP)

These are buffer-local: they only exist once a language server has attached to
the file. Check with `<leader>cl`.

| Key | Action |
|---|---|
| `K` | Show documentation for the thing under the cursor |
| `gd` | Go to definition |
| `gr` | Find all references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `gD` | Go to declaration |
| `gK` | Show function signature (`<C-k>` in insert mode) |
| `gai` / `gao` | Incoming / outgoing calls |
| `]]` / `[[` | Next / previous reference to the symbol under the cursor |
| `<leader>ca` | Code action — offers fixes and refactors |
| `<leader>cA` | Source action (whole-file refactors, organise imports) |
| `<leader>cr` | Rename symbol everywhere |
| `<leader>cR` | Rename the file and update imports |
| `<leader>cc` / `<leader>cC` | Run / refresh codelens |
| `<leader>cf` | Format the file |
| `<leader>cF` | Format injected languages (e.g. SQL inside a string) |
| `<leader>cl` | LSP info — which servers are attached |
| `<leader>cm` | Mason — install/manage language servers |
| `<leader>cs` | Symbol outline for this file (Trouble) |
| `<leader>ss` | LSP document symbols *(shadows Flash here — see note below)* |
| `<leader>sS` | LSP workspace symbols |

While typing, blink.cmp shows a completion popup. It uses the "enter" preset:

| Key | Action |
|---|---|
| `Enter` | Accept the highlighted completion |
| `<C-y>` | Accept (alternative, doesn't insert a newline if nothing is selected) |
| `<C-n>` / `<C-p>` | Next / previous suggestion |
| `<C-space>` | Open the menu manually |
| `<C-e>` | Dismiss the popup |
| `<Tab>` / `<S-Tab>` | Jump between snippet placeholders |

## Problems and diagnostics

| Key | Action |
|---|---|
| `<leader>xx` | Show all errors/warnings (Trouble panel) |
| `<leader>xX` | Errors in this buffer only |
| `<leader>xL` / `<leader>xQ` | Location list / quickfix list in Trouble |
| `<leader>xt` / `<leader>xT` | TODO comments (this buffer / everywhere) |
| `]d` / `[d` | Next / previous problem |
| `]D` / `[D` | Last / first problem in the buffer |
| `]e` / `[e` | Next / previous **error** |
| `]w` / `[w` | Next / previous **warning** |
| `<leader>cd` | Show the problem on this line |
| `<leader>sd` / `<leader>sD` | Search diagnostics (all / this buffer) |
| `<leader>st` / `<leader>sT` | List TODO / all FIXME-style comments |
| `]t` / `[t` | Next / previous TODO comment |
| `<leader>sq` / `<leader>sl` | Quickfix list / location list |
| `]q` / `[q` | Next / previous quickfix item |

## Git

`<leader>gg` opens **GitUi**, not lazygit. It is installed through Mason at
`~/.local/share/nvim/mason/bin/gitui`.

| Key | Action |
|---|---|
| `<leader>gg` / `<leader>gG` | GitUi TUI (project root / cwd) |
| `<leader>gs` | Git status picker |
| `<leader>gd` | Diff of unstaged hunks |
| `<leader>gD` | Diff against `origin` |
| `<leader>gS` | Git stashes |
| `<leader>gi` / `<leader>gI` | GitHub issues (open / all) — needs `gh` |
| `<leader>gp` / `<leader>gP` | GitHub PRs (open / all) — needs `gh` |

Hunk-level work lives under `<leader>gh`, and is buffer-local to files
gitsigns has attached to:

| Key | Action |
|---|---|
| `]h` / `[h` | Next / previous changed hunk |
| `]H` / `[H` | Last / first hunk |
| `<leader>ghs` / `<leader>ghr` | Stage / reset the hunk (works on a visual selection) |
| `<leader>ghS` / `<leader>ghR` | Stage / reset the whole buffer |
| `<leader>ghu` | Undo the last stage |
| `<leader>ghp` | Preview the hunk inline |
| `<leader>ghb` / `<leader>ghB` | Blame this line / the whole buffer |
| `<leader>ghd` / `<leader>ghD` | Diff this file against index / against `~` |
| `ih` | Text object for a hunk — `dih`, `vih` and so on |

## Claude Code

| Key | Action |
|---|---|
| `<leader>ac` | Toggle Claude Code panel |
| `<leader>af` | Focus the Claude panel |
| `<leader>az` | **Full screen** — move Claude into the main window, or back to the sidebar *(your own binding)* |
| `<leader>ar` | Resume a previous session |
| `<leader>aC` | Continue the last session |
| `<leader>ab` | Send the current file to Claude as context |
| `<leader>as` | Send the selected text to Claude (visual mode), or the entry under the cursor in the picker/explorer |
| `<leader>am` | Pick which Claude model to use *(your own binding)* |
| `<leader>aa` | **Accept** a diff Claude proposes |
| `<leader>ad` | **Deny** a diff Claude proposes |

Also available as commands: `:ClaudeCode`, `:ClaudeCodeStatus`, `:ClaudeCodeStop`,
and 12 more — type `:ClaudeCode` and press `<Tab>` to see them.

**Never use `:ClaudeCodeClose`.** It wipes the terminal buffer and kills the
running Claude process, because snacks treats that buffer as its scratch buffer.
`:ClaudeCode` (the toggle) only hides the window and leaves the session alive;
`:ClaudeCodeFocus` rebuilds the split around the surviving buffer.

## Terminal buffers

Claude runs in a snacks terminal, so these apply to it as well as to
`<leader>ft` and `<C-/>`.

| Key | Action |
|---|---|
| `<C-/>` | Toggle a floating terminal (`<C-_>` too — some terminals send that instead) |
| `<leader>ft` / `<leader>fT` | Terminal at the project root / cwd |
| `i` or `a` | Enter Terminal-mode — keys now go to the program, not Neovim |
| `<Esc><Esc>` | **Leave Terminal-mode.** Double-tap within 200ms; a single `<Esc>` is passed through to the program |
| `<C-\><C-n>` | Leave Terminal-mode — the built-in way, works in any terminal buffer |
| `q` | Hide the terminal (Normal mode, snacks terminals only) |
| `gf` | Open the file under the cursor, hiding the terminal |

Once out of Terminal-mode you are in **Terminal-normal mode**: an ordinary,
scrollable, searchable buffer that happens to be frozen while the program keeps
running. Yank from it, `/`-search it, then press `i` to get back to typing.

The double-`<Esc>` is the one worth learning — it saves reaching for
`<C-\><C-n>` every time you want to scroll back through Claude's output.

## Appearance toggles

| Key | Action |
|---|---|
| `<leader>uw` | Toggle line wrapping |
| `<leader>ul` / `<leader>uL` | Toggle line numbers / relative numbers |
| `<leader>us` | Toggle spellcheck |
| `<leader>ud` | Toggle diagnostics on/off |
| `<leader>ub` | Toggle dark/light background |
| `<leader>uC` | Pick a different colorscheme |
| `<leader>uh` | Toggle inlay hints |
| `<leader>uf` / `<leader>uF` | Toggle format-on-save (global / this buffer) |
| `<leader>ug` | Toggle indent guides |
| `<leader>uc` | Toggle conceal |
| `<leader>uT` | Toggle treesitter highlighting |
| `<leader>uD` | Toggle dimming of inactive code |
| `<leader>ua` / `<leader>uS` | Toggle animations / smooth scrolling |
| `<leader>up` | Toggle auto-pairs |
| `<leader>uA` | Toggle the bufferline |
| `<leader>ur` | Redraw the screen, clear search highlight, refresh diffs |
| `<leader>ui` / `<leader>uI` | Inspect the highlight under the cursor / the treesitter tree |

`<leader>ur` is worth remembering — it is the first thing to try when the
screen looks corrupted.

## Sessions, notifications, admin

| Key | Action |
|---|---|
| `<leader>qs` | Restore the session for this directory |
| `<leader>ql` | Restore the last session |
| `<leader>qS` | Pick a session |
| `<leader>qd` | Don't save the current session |
| `<leader>n` | Notification history |
| `<leader>snh` / `<leader>sna` | Noice history / all messages |
| `<leader>snl` | Last Noice message |
| `<leader>und` / `<leader>un` | Dismiss all notifications |
| `<leader>l` | Open the Lazy plugin manager |
| `<leader>ft` | Floating terminal (`<C-/>` also works; `<C-/>` again to hide) |
| `<leader>.` | Scratch buffer — a throwaway notepad |
| `<leader>S` | Pick from your scratch buffers |

---

# Things you should know

## 1. Modes are the whole idea

Most editors are always in "insert" mode. Neovim is not. It starts in **Normal
mode**, where letter keys are *commands*, not text. `d` deletes, `y` copies,
`p` pastes. This is why `hjkl` moves the cursor.

- **Normal** — the home base. Navigate and run commands.
- **Insert** — actually typing text. Enter with `i`, `a`, or `o`. Leave with `Esc`.
- **Visual** — selecting text. Enter with `v`, `V`, or `<C-v>`. Leave with `Esc`.
- **Command** — enter with `:`, type a command, press Enter.
- **Terminal** — inside a `:terminal` buffer, keys go to the program. Enter with
  `i`. Leave with `<C-\><C-n>`, which puts you in *Terminal-normal* mode: a
  frozen, scrollable view of the same buffer.

The bottom-left of the screen tells you which mode you're in. **When lost, press
`Esc` twice.** You are then in Normal mode, guaranteed.

## 2. Commands compose like a sentence

Neovim's power is that operators and motions combine. `d` (delete) + `w` (word)
= `dw`. Learn one new operator and it works with every motion you already know:

- Operators: `d` delete, `c` change, `y` yank/copy, `>` indent
- Motions: `w` word, `$` end of line, `}` paragraph, `G` end of file
- Text objects: `iw` inner word, `i"` inside quotes, `ap` a paragraph, `ih` a git hunk

So `ci(` = "change inside parentheses", `dap` = "delete a paragraph", `y$` =
"copy to end of line". You don't memorise combinations — you memorise the pieces.

## 3. Discovery beats memorisation

You do not need this file. Press **Space and wait one second** — which-key pops
up showing every next key and what it does. Keep pressing to drill down.

- `<leader>?` — every keybinding active in the current buffer
- `<leader>sk` — searchable list of all keymaps
- `?` inside any picker or the explorer — every key for that picker
- `:help <topic>` — the real manual, e.g. `:help ciw`. `<C-o>` goes back.
- `:checkhealth` — diagnoses what's broken or missing in your setup
- `:verbose nmap <key>` — shows what a key is bound to *and which file did it*

## 4. Your config

Lives in `~/.config/nvim`, which is a **git submodule** of your `~/.dotfiles`
repo — so commits there go to the dotfiles module, not a standalone repo.

| Path | Purpose |
|---|---|
| `lua/config/options.lua` | Settings (`vim.opt.*`) |
| `lua/config/keymaps.lua` | Your own key bindings |
| `lua/config/autocmds.lua` | Things that fire on events |
| `lua/plugins/*.lua` | Plugin specs — one file per concern |
| `lazyvim.json` | Which LazyVim "extras" are on |
| `lazy-lock.json` | Exact plugin versions. Commit this |

**Rule that bit you already:** LazyVim extras (`lazyvim.plugins.extras.*`)
belong in `lazyvim.json`, never as `{ import = ... }` inside `lua/plugins/`.
Files under `lua/plugins/` load last, so an extra imported there misses the
load-order priority LazyVim assigns it, and plugins that decorate each other
break. Use `:LazyExtras` to browse and toggle them — it edits `lazyvim.json`
for you.

Which picker and explorer you get is decided by `install_version` in
`lazyvim.json`. Yours is `8`, which means **snacks for both**. Installs on
version 7 or lower default to telescope and neo-tree instead — that is why
most LazyVim advice on the internet does not match your keys.

## 5. Plugins load lazily

Most plugins are not loaded at startup — they load the first time you press
their key or run their command. That's why startup is fast, and why
`:ClaudeCode` needs the plugin to declare `cmd` stubs to work from a cold start.

- `:Lazy` — dashboard. `U` updates, `S` syncs, `x` cleans, `?` for help
- `:Lazy update` — update everything. **Do this when the machine is idle**; on
  this box it is slow and I/O-heavy
- `:Mason` — install language servers, formatters, linters

## 6. Things specific to *your* machine

- **The explorer's search needs `fd`, and a missing `fd` fails silently.**
  `snacks/picker/source/explorer.lua` hardcodes `opts.cmd = "fd"` with no
  fallback to `rg` or `find`, and passes `notify = false`, so typing in the
  explorer's search box returns nothing and says nothing. Browsing the tree is
  unaffected — that uses libuv, not `fd`. `<leader>ff` is unaffected too,
  because the file picker names no command and falls back to `rg`.

  It is installed and working: `fd-find` 9.0.0 from apt, with `~/.local/bin/fd`
  symlinked to `/usr/bin/fdfind`. Ubuntu ships the binary as `fdfind` because
  of a name clash with `fdclone`; snacks accepts either name, but other tools
  expect `fd`.

  **A missing finder is cached for the whole Neovim session.** In
  `snacks/picker/source/files.lua`, `local commands` is file-private and gets
  `available = false` written onto it the first time a lookup fails, and
  nothing re-checks it. So installing a finder while Neovim is running changes
  nothing until you restart — which is exactly what happened when `fd` was
  installed here. To clear it without restarting:

  ```vim
  :lua package.loaded["snacks.picker.source.files"] = nil
  ```

  `explorer.lua` re-requires that module on every search, so the next one picks
  up a fresh table. If search still comes back empty, check `:echo
  executable('fd')` — a `0` means Neovim's inherited `$PATH` has no
  `~/.local/bin`, which is a launch-environment problem, not a cache one.
  Neovim inherits `$PATH` once, at launch.

- **`sudo nvim` runs the wrong Neovim.** Your working 0.12.5 is at
  `~/.local/bin/nvim`; the system still has 0.9.5 at `/usr/bin/nvim`, and
  LazyVim refuses to start on it (it hangs waiting for a keypress). Use
  `sudo -E env "PATH=$PATH" nvim`, or just edit as yourself.

- **`<leader>gg` is GitUi, not lazygit.** `lazygit` is not installed and nothing
  is bound to it. The `util.gitui` extra installs GitUi through Mason and takes
  `<leader>gg` and `<leader>gG`.

- **Telescope is not installed at all.** Nothing in `lazy-lock.json` references
  it. When docs or blog posts mention `:Telescope`, translate to
  `Snacks.picker.*` or the `<leader>f`/`<leader>s` keys above.

- **Your cursor is always centred, and it breaks terminal buffers.**
  `scrolloff = 999` in `options.lua` forces the cursor to the middle of the
  window. Terminal-*mode* overrides it to 0 (`:help terminal`), but
  Terminal-*normal* mode does not — so entering a terminal buffer from normal
  mode, as `[b` and `]b` do, scrolls the view off the tail of the buffer and
  leaves stale scrollback rendered below the live screen. `claudecode.lua`
  works around this by forcing window-local `scrolloff=0` on terminal buffers
  and restoring `-1` on the way out. Set the global to `8` if you would rather
  the screen stayed still.

- **`s` is not Flash jump for you.** `keymaps.lua` deletes that binding, and
  `flash.lua` moves it to `<leader>ss`. Plain `s` falls back to its built-in
  meaning: substitute one character. Note `S` is *still* Flash Treesitter — you
  only removed the lowercase one.

- **`<leader>ss` is two different things depending on the file.** Flash binds it
  globally, but the snacks picker extra binds it buffer-locally to LSP document
  symbols whenever a server with `documentSymbol` attaches. Buffer-local wins,
  so in a TypeScript or Lua file you get the symbol picker, and in a plain text
  file you get Flash. Check which you have with `:verbose nmap <leader>ss`. Move
  the Flash binding in `flash.lua` if the collision annoys you.

- **`<leader>fg` is git-files, not grep.** You previously had it bound to live
  grep via telescope. Grep is now `<leader>/` or `<leader>sg`.

- **`<C-p>` is no longer bound.** Use `<leader><leader>` to find files.

## 7. Getting unstuck

| Situation | Fix |
|---|---|
| Keys do nothing / weird | Press `Esc` a few times |
| Screen looks corrupted or double-drawn | `<leader>ur`, or `<C-l>` |
| Stuck in a popup or panel | `q`, or `Esc` then `q` |
| Stuck in a terminal buffer | `<C-\><C-n>` gets you to Normal mode |
| `E37: No write since last change` | `:w` to save, or `:q!` to discard |
| Accidentally recording a macro (`recording @q` shows) | Press `q` |
| Hit `<C-z>` and nvim vanished | Type `fg` in the shell to bring it back |
| Swap file warning on open | Usually a crashed session — pick `(R)ecover`, then `(D)elete` the swap |
| A key does something unexpected | `:verbose nmap <key>` names the file that bound it |
| Everything is broken after a plugin update | `:Lazy restore` resets plugins to `lazy-lock.json` |
| Truly stuck | `:qa!` quits everything, discarding all changes |
