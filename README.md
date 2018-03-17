oomox-gtk-theme
=====

Oomox-gtk-theme is a fork of Numix-gtk-theme.
It is used in oomox app: https://github.com/actionless/oomox

### Theme examples

![Screenshot Light](https://raw.githubusercontent.com/actionless/oomox-gtk-theme/master/screenshots/theme-clearlooks_hidpi-gtk3-page1.png "Screenshot Light")
![Screenshot Medium](https://raw.githubusercontent.com/actionless/oomox-gtk-theme/master/screenshots/theme-lavender_hidpi-gtk3-page1.png "Screenshot Medium")
![Screenshot Dark](https://raw.githubusercontent.com/actionless/oomox-gtk-theme/master/screenshots/theme-monovedek_lcars_hidpi-gtk3-page1.png "Screenshot Dark")


#### Prerequisites

You need to have those dependencies:
 - `glib-compile-schemas`
 - `gdk-pixbuf-pixdata`
 - `sassc>=3.4`
 - `gtk3>=3.18`
 
For GTK2 you need murrine engine which can be not installed by default.

##### Arch Linux

```
sudo pacman -S --needed bash grep sed bc glib2 gdk-pixbuf2 sassc gtk-engine-murrine gtk-engines librsvg
```

##### Ubuntu

```
sudo apt install libgdk-pixbuf2.0-dev libxml2-utils gtk2-engines-murrine librsvg2-bin
```

And install `sassc>=3.4`: https://askubuntu.com/questions/849057/how-to-install-libsass-on-ubuntu-16-04



#### How to generate the theme using CLI:

##### bash:
```bash
git clone https://github.com/actionless/oomox-gtk-theme.git
cd oomox-gtk-theme
./change_color.sh -o my-test-theme <(echo -e "BG=888a85\nBTN_BG=85509b\nBTN_FG=0e0021\nFG=0e0021\nGRADIENT=0.0\nHDR_BTN_BG=85509b\nHDR_BTN_FG=0e0021\nMENU_BG=0e0021\nMENU_FG=888a85\nROUNDNESS=4\nSEL_BG=dc5e86\nSEL_FG=000000\nSPACING=3\nTXT_BG=c0bbbb\nTXT_FG=000000\nWM_BORDER_FOCUS=9edc60\nWM_BORDER_UNFOCUS=0e0021\n")
```

##### fish:
```fish
git clone https://github.com/actionless/oomox-gtk-theme.git
cd oomox-gtk-theme
./change_color.sh -o my-test-theme (echo -e "BG=888a85\nBTN_BG=85509b\nBTN_FG=0e0021\nFG=0e0021\nGRADIENT=0.0\nHDR_BTN_BG=85509b\nHDR_BTN_FG=0e0021\nMENU_BG=0e0021\nMENU_FG=888a85\nROUNDNESS=4\nSEL_BG=dc5e86\nSEL_FG=000000\nSPACING=3\nTXT_BG=c0bbbb\nTXT_FG=000000\nWM_BORDER_FOCUS=9edc60\nWM_BORDER_UNFOCUS=0e0021\n" | psub)
```


next select `my-test-theme` in your appearance config tool (for example, _lxappearance_)



### Using with tiling WMs:

To resolve borders/shadow problem in tiling window managers create/append to 
`~/.config/gtk-3.0/gtk.css`:

```css
.window-frame, .window-frame:backdrop {
  box-shadow: 0 0 0 black;
  border-style: none;
  margin: 0;
  border-radius: 0;
}
.titlebar {
  border-radius: 0;
}
window decoration {
  margin: 0;
  border: 0;
}

```

### Hacking


#### Running tests locally:

```sh
cd ./docker_scripts/

# build container:
./build_docker_image.sh

# start container:
./start_docker_container.sh

# run tests:
./run_docker_tests.sh
```

Alternatively, to avoid rebuilding the container after each small theme change, you can start already built container and mount the current working directory inside that container:

```sh
# start container:
./docker_scripts/dev_docker_container.sh
```

#### Generate new screenshots:

```sh
# assuming container is already started:
./docker_scripts/run_docker_tests.sh -e GENERATE_ASSETS=1
```

#### Generate screenshots only for specific theme variant:

```sh
./docker_scripts/run_docker_tests.sh -e GENERATE_ASSETS=1 -e SKIP_GTK2=1 -e TEST_THEMES=clearlooks -e TESTSUITE_HIDPI=1
```
