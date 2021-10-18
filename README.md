-  Split Screen to view two applications at a time:
```
Super+Left arrow / Super+Right arrow
```
- Logging out in Ubuntu 18.04 GNOME
When clicking the settings in the upper right corner,
there is the lock icon that only locks the screen but
it does not logout.
To logout you should click your user name
on the list from the upper right dropdown settings,
Then click "Log Out"

When clicking on the app icon on launcher when it is in focus the default is preview,
we can change it to minimize by

gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

`org.gnome.shell.extensions.dash-to-dock` is called schema,
click-action is a key.

To get the list of schemas do `gsettings list-schemas`

And the list of keys for a schema do

```
gsettings list-keys org.gnome.shell.extensions.dash-to-dock
```

and to get the list of values for a key do:

```
gsettings range org.gnome.shell.extensions.dash-to-dock click-action
```

The launcher panel in the left is called Dock and it can be configured
from settings->Dock

I wanted to have easy access to german umlauts, the traditional
annoying way to do it is with the Compose key which is a nightmehr.
(The compose key always interfer with other keys, and to produce for
example Ü, I have to do 'composekey' then Shift+u then Shift+'
):

So to have nice umlauts:
sudo cp /usr/share/X11/xkb/symbols/us /usr/share/X11/xkb/symbols/us.bak

Then under "xkb_symbols "basic" {" (The fisrt), I did this:

```
dafna@curi:~/myconfigs$ diff -u  /usr/share/X11/xkb/symbols/us /usr/share/X11/xkb/symbols/us.bak
--- /usr/share/X11/xkb/symbols/us	2020-04-09 08:05:23.937962981 +0200
+++ /usr/share/X11/xkb/symbols/us.bak	2020-04-05 08:31:35.325289672 +0200
@@ -23,15 +23,15 @@
     key <AD04> {	[	  r,	R		]	};
     key <AD05> {	[	  t,	T		]	};
     key <AD06> {	[	  y,	Y		]	};
-    key <AD07> {	[	  u,	U, udiaeresis, Udiaeresis		]	};
+    key <AD07> {	[	  u,	U		]	};
     key <AD08> {	[	  i,	I		]	};
-    key <AD09> {	[	  o,	O, odiaeresis, Odiaeresis		]	};
+    key <AD09> {	[	  o,	O		]	};
     key <AD10> {	[	  p,	P		]	};
     key <AD11> {	[ bracketleft,	braceleft	]	};
     key <AD12> {	[ bracketright,	braceright	]	};
 
-    key <AC01> {	[	  a,	A, adiaeresis, Adiaeresis 		]	};
-    key <AC02> {	[	  s,	S, ssharp, U1E9E		]	};
+    key <AC01> {	[	  a,	A 		]	};
+    key <AC02> {	[	  s,	S		]	};
     key <AC03> {	[	  d,	D		]	};
     key <AC04> {	[	  f,	F		]	};
     key <AC05> {	[	  g,	G		]	};

```
I knew to change the `/usr/share/X11/xkb/symbols/us` because of the line `XKBLAYOUT=us,il` in `/etc/default/keyboard`
I hoped this will do, but unfortunetly it didn't.
I found out I have to open the Tweak app, go to `keyboard & Mouse -> Additional Layout Options -> Key to choose the third level -> check the 'Right Alt'

Also, in the app 'Settings -> Devices -> Keyboard' There is a list of keyboard shortcuts, I don't know if it has
any influance but I disable any shortcut that starts with 'Alt+..' , to do this I click the option and then click Backspace.

Now 'Right Alt+a' gives me ä, 'Shift+Right Alt+A' gives me Ä. The same for u and o. (same with ß!)


adding shortcut to google translate german -> english in chrome: right click on the address bar -> Edit search engines -> Add -> set the
shortcut (de) add the url (https://translate.google.com/#view=home&op=translate&sl=de&tl=en)


(Thanks to https://superuser.com/a/468548 )

Adding the date next to the time in the upper pannel:

```
gsettings set org.gnome.desktop.interface clock-show-date true
```

to add gtimelog to the startup applications I added the file ~/.config/autostart/gtimelog.desktop with the content:

```
[Desktop Entry]
Name=gtimelog
GenericName=Gtimelog
Comment=No comments
Exec=/usr/local/bin/gtimelog
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true
```

German Spellchecking
==================
listing available dictionaries in aspell:
```
aspell dump dicts
```
installing german dict:
```
sudo apt install aspell-de
```
commands:
---------
dump list of typos in a file:
```
cat german-text.txt | aspell -l de_DE list
```
dump list of typos in a file together with a list of possible correction to each typo:
```
cat german-text.txt | aspell -l de_DE list | aspell -l de_DE -a
```
Note that the simple `spell` command can't recognize umlauts. So to run english spell and then german spell do:
```
cat myfile.txt | aspell -l en_US -d en  list  | aspell -l de_DE  list | sort | uniq
```
Don't use `ispell`, it's not so good and not comfortable.
If you do want to use it , download a german dictionary from here: https://www.j3e.de/ispell/igerman98/dict/
then extract it with:
```
bzip2 -kd igerman98-20161207.tar.bz2
tar -xf igerman98-20161207.tar
```
follow the instruction in the file INSTALL.ispell in the extracted directory for how to compile and install

Installing RIOT irc
===================
From the site: https://element.io/get-started

```
sudo apt install -y wget apt-transport-https

sudo wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ default main" | sudo tee /etc/apt/sources.list.d/riot-im.list

sudo apt update

sudo apt install element-desktop
```

Sieve filters
=============
```
sieve-connect --noclearauth -s mail.collabora.co.uk -u dafna
> h
> list
"kernel-mailing-lists.filter"
"spam.filter"
"my-filters.filter" ACTIVE
> download my-filters.filter my-filters.filter
> quit
```
here are the filters for some of my mailing lists:
```
# vger.kernel.org mailing lists
if header :matches "List-Id" "*<*.vger.kernel.org>" {
  fileinto :create "kernel.${2}";
}

# infradead mailing lists
if header :matches "List-Id" "*<*.lists.infradead.org>" {
	fileinto :create "kernel.${2}";
}

# dri-devel
if header :matches "List-Id" "*<dri-devel.lists.freedesktop.org>" {
  fileinto :create "kernel.dri-devel";
}

# libcamera-devel
if header :matches "List-Id" "*<libcamera-devel.lists.libcamera.org>" {
  fileinto :create "libcamera";
}

# alsa mailing lists
if header :matches "List-Id" "*<alsa-devel.alsa-project.org>" {
	fileinto :create "kernel.alsa";
}

# cros dev mailing lists
if header :matches "List-Id" "*<chromium-os-dev.chromium.org>" {
	fileinto :create "cros-dev";
}
```
After updating the sieve filters in the server, I should enable the new created
folder in thunderbird:
(Edit->Preferences->Advanced->Config Editor) and set the key mail.server.default.check_all_folders_for_new to TRUE.

One more thing to NOTE, the new folders are automatically created by the sieve filter,
but thunderbird does not automatically subscribes me to those folders. This is kind of stupid actually
but when noting that no emails are received from a mailing list, I should right click my account and choose
subscribe, there there is a list of the new created folders and I should subscribe to them.

when uploading a script it will show me if I have syntax errors.

To get the full email with headers in thunderbird: ctrl+u
To mark selected messages as read: m

```
sieve-connect --noclearauth -s mail.collabora.co.uk -u <your collabora user name>
```

VIM
===
* First, there is the `rg` command (ripgrep) that should be nicer and faster than `git grep`
* I use ctags with vim
In .vim/plugin/ctags.vim, I set the statusline to '%<%F...blabla' instead of '%<%f...blabla' to get the full path of the file and not
just the name. NOTE that the statusline is set in two places.

to use 'git grep' for `:grep` I do:
```
set grepprg=git\ grep -n\ $*
```
then `:copen` and `:ccl` open and close the quickfix buffer

The better use for git grep is:

```
" from https://stackoverflow.com/questions/2415237/techniques-in-git-grep-and-vim#2415366
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)
```
Then `:G <search-text>` is the `git grep` cmd




My current `.vimrc`:
```
let g:ctags_statusline=1
let generate_tags=1
let g:ctags_title=1
set autochdir
set csre
set tags=tags;
set noswapfile
set title
"set relativenumber
"set number
" '+' is the clipboard register - this is a shortcut to paste from clipboard
"and move the cursoe to after the pasted text
"nnoremap cv "+gP
"nnoremap cb "*gP
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /^\t* \+\|\s\+$/
set hlsearch
"see http://vim.wikia.com/wiki/Insert_a_single_character
"nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
"nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>

"nnoremap C :exec "normal a".\/\/."\e"<CR>


autocmd FileType c,cpp :set sw=8 cindent smarttab
autocmd FileType sh setlocal ts=4 sw=4 sts=0
autocmd FileType python setlocal ts=4 sw=4 sts=0 expandtab
"bands jj to <ESC>, see https://vi.stackexchange.com/a/301/20051
inoremap jj <ESC>
"this auto ident when pasting
"nnoremap p p=`]
"nnoremap P P=`]
"set autoindent
"set cindent

nnoremap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
"set clipboard=unnamedplus
syntax on


set showtabline=2 " always show tabs

" from https://stackoverflow.com/a/33765365/1019140
set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      let s .= '%#Title#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
    let n = substitute(n, ', $', '', '')
    " add modified label
    if m > 0
      let s .= '+'
      " let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  " right-aligned close button
  " if tabpagenr('$') > 1
  "   let s .= '%=%#TabLineFill#%999Xclose'
  " endif
  return s
endfunction
```


BYOBU
=====
to change taggles between split regions similar to vim (but with Ctrl)
in the file ~/.byobu/keybindings.tmux:
```
bind-key -n C-l display-panes \; select-pane -R
bind-key -n C-h display-panes \; select-pane -L
bind-key -n C-k display-panes \; select-pane -U
bind-key -n C-j display-panes \; select-pane -D
```
UPDATE: in the meanwhile I changed to `terminator` , it is also possible
to set the keybinding there.
