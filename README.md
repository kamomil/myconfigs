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
