#!/bin/bash
#Description: Helper script to build the Cinnamox themes GTK elements.
function aubergine {
	THEMENAME="Cinnamox-Aubergine"; build_theme;
}
function goldspice {
	THEMENAME="Cinnamox-Gold-Spice"; build_theme;
}
function heather {
	THEMENAME="Cinnamox-Heather"; build_theme;
}
function kashmirblue {
	THEMENAME="Cinnamox-Kashmir-Blue"; build_theme;
}
function rhino {
	THEMENAME="Cinnamox-Rhino"; build_theme;
}
function rossocursa {
	THEMENAME="Cinnamox-Rosso-Cursa"; build_theme;
}
function willowgrove {
	THEMENAME="Cinnamox-Willow-Grove"; build_theme;
}
function zanah {
	THEMENAME="Cinnamox-Zanah"; build_theme;
}
function build_theme {
	WORKDIR="$PWD";
    BUILDDIR="$HOME/Workspace/Theming/cinnamox_builds/$THEMENAME";
    THEMEDIR="$HOME/.themes/$THEMENAME";
    /$PWD/change_color.sh -o "$THEMENAME" -m all -d false "$PWD/colors/$THEMENAME";
    cd "$THEMEDIR/gtk-3.0" && rm -r "$PWD/assets";
    cd "$THEMEDIR/gtk-3.20" && rm -r "$PWD/assets";
    rsync -a -u --exclude '*.png' --exclude 'openbox-3' --exclude 'unity' --exclude 'xfwm4' "$BUILDDIR"/ "$THEMEDIR";
    cd "$THEMEDIR/gtk-3.0";
    rm "$PWD/gtk-dark.css"; rm "$PWD/gtk.gresource"; rm "$PWD/gtk.gresource.xml"; rm "$PWD/dist/gtk-dark.css";
    rsync -a "$THEMEDIR/gtk-3.0/dist"/ "$THEMEDIR/gtk-3.0" && rm -r "$PWD/dist";
    cd "$THEMEDIR/gtk-3.20";
    rm "$PWD/gtk-dark.css"; rm "$PWD/gtk.gresource"; rm "$PWD/gtk.gresource.xml"; rm "$PWD/dist/gtk-dark.css";
    rsync -a "$THEMEDIR/gtk-3.20/dist"/ "$THEMEDIR/gtk-3.20" && rm -r "$PWD/dist";
    cd "$WORKDIR";
}

VARIANT=("Build all" "Aubergine" "Gold-Spice" "Heather" "Kashmir-Blue" "Rhino" "Rosso-Cursa" "Willow-Grove" "Zanah");
echo "";
echo "*** Cinnamox GTK & Metacity Theme Builder ***";
echo "";
echo "Pleases select a variant or select 1 to build all:";
echo "";
select CHOICE in "${VARIANT[@]}";
do
    case $CHOICE in 
    "Build all")
		aubergine; goldspice; heather; kashmirblue; rhino; rossocursa; willowgrove; zanah;; 
    "Aubergine")
		aubergine;;
    "Gold-Spice")
		goldspice;;
    "Heather")
		heather;;
    "Kashmir-Blue")
		kashmirblue;;
    "Rhino")
		rhino;;
    "Rosso-Cursa")
		rossocursa;;
    "Willow-Grove")
		willowgrove;;
    "Zanah")
		zanah;;  
    *) echo "Invalid option. Try another one."; continue;;
    esac
    break
done
echo "";
read -p "Press enter to exit the script.";
cd;
exit;
