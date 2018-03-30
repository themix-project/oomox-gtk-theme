#!/usr/bin/env bash

set -ue
SRC_PATH=$(readlink -f $(dirname $0))

darker () {
	"${SRC_PATH}/scripts/darker.sh" $@
}
mix () {
	"${SRC_PATH}/scripts/mix.sh" $@
}


print_usage() {
	echo "Usage: $0 PATH_TO_PRESET"
	echo "	[--output OUTPUT_THEME_NAME] [--hidpi (True|False)]"
	echo "	[--make-opts (all|gtk3|gtk320)] [--path-list 'PATH PATH...']"
	echo
	echo "Options:"
	echo "	PATH_TO_PRESET				path to Oomox theme file"
	echo "	-o NAME, --output NAME			output theme name"
	echo "	-t DESTINATION_PATH, --target-dir DESTINATION_PATH"
	echo "						where the theme will be built"
	echo "	-d (true|false), --hidpi (true|false)	generate GTK+2 assets with 2x scaling"
	echo "	-m (all|gtk3|gtk320), --make-opts (all|gtk3|gtk320)"
	echo "						which variant of GTK+3 theme to build"
	echo "	-p 'PATH PATH...', --path-list 'PATH PATH'"
	echo "						custom paths to theme files"
	echo
	echo "Examples:"
	echo "       $0 -o my-theme-name ../colors/retro/twg"
	echo "       $0 -o my-theme-name --hidpi True ../colors/retro/clearlooks"
	echo "       $0 -o my-theme-name -t ~/my_themes ../colors/retro/clearlooks"
	echo "       $0 -p \"./gtk-2.0 ./gtk-3.0 ./gtk-3.20 ./Makefile\" ../colors/gnome-colors/shiki-noble"
	echo "       $0 -p \"./gtk-2.0 ./gtk-3.0 ./gtk-3.20 ./Makefile\" -m gtk320 ../colors/monovedek/monovedek"
	exit 1
}


while [[ $# > 0 ]]
do
	case ${1} in
		-p|--path-list)
			CUSTOM_PATHLIST="${2}"
			shift
		;;
		-o|--output)
			OUTPUT_THEME_NAME="${2}"
			shift
		;;
		-t|--target-dir)
			DEST_PATH_ROOT="${2}"
			shift
		;;
		-m|--make-opts)
			MAKE_OPTS="${2}"
			shift
		;;
		-d|--hidpi)
			OPTION_GTK2_HIDPI="${2}"
			shift
		;;
		*)
			if [[ "${1}" == -* ]] || [[ ${THEME-} ]]; then
				echo "unknown option ${1}"
				print_usage
				exit 2
			fi
			THEME="${1}"
		;;
	esac
	shift
done

if [[ -z "${THEME:-}" ]] ; then
	print_usage
fi

PATHLIST=(
	'./src/openbox-3'
	'./src/assets'
	'./src/gtk-2.0'
	'./src/gtk-3.0'
	'./src/gtk-3.20'
	'./src/xfwm4'
	'./src/metacity-1'
	'./src/unity'
	'Makefile'
	'./src/index.theme'
	'./src/qt5ct_palette.conf'
	'./src/cinnamon'
)
if [ ! -z "${CUSTOM_PATHLIST:-}" ] ; then
	IFS=', ' read -r -a PATHLIST <<< "${CUSTOM_PATHLIST:-}"
fi
SVG_PREVIEWS=(
	'./gtk-3.0/thumbnail.svg'
	'./gtk-3.20/thumbnail.svg'
	'./metacity-1/thumbnail.svg'
)

MAKE_GTK3=0
EXPORT_QT5CT=0
for FILEPATH in "${PATHLIST[@]}"; do
	if [[ ${FILEPATH} == *Makefile* ]] ;then
		MAKE_GTK3=1
	elif [[ ${FILEPATH} == *qt5ct* ]] ;then
		EXPORT_QT5CT=1
	fi
done
MAKE_OPTS="${MAKE_OPTS-all}"

OPTION_GTK2_HIDPI=$(echo ${OPTION_GTK2_HIDPI-False} | tr '[:upper:]' '[:lower:]')


if [[ ${THEME} == */* ]] || [[ ${THEME} == *.* ]] ; then
	source "$THEME"
	THEME=$(basename ${THEME})
else
	if [[ -f "$SRC_PATH/../colors/$THEME" ]] ; then
		source "$SRC_PATH/../colors/$THEME"
	else
		echo "Theme '${THEME}' not found"
		exit 1
	fi
fi
if [[ $(date +"%m%d") = "0401" ]] && [[ -z "${no_jokes:-}" ]] ; then
	echo -e "\n\nError patching uxtheme.dll\n\n"
	ACCENT_BG=30a55c BG=ECE9D8 BTN_BG=f8f8f8 BTN_FG=000000
	BTN_OUTLINE_OFFSET=-3 BTN_OUTLINE_WIDTH=1 FG=000000 GRADIENT=0.08
	GTK3_GENERATE_DARK=False HDR_BTN_BG=f8f8f8 HDR_BTN_FG=000000 MENU_BG=ECE9D8
	MENU_FG=000000 OUTLINE_WIDTH=1 ROUNDNESS=3 SEL_BG=3169C6 SEL_FG=FFFFFF
	SPACING=3 TXT_BG=FFFFFF TXT_FG=000000 WM_BORDER_FOCUS=3169C6 WM_BORDER_UNFOCUS=ECE9D8
fi

ACCENT_BG=${ACCENT_BG-$SEL_BG}
HDR_BTN_BG=${HDR_BTN_BG-$BTN_BG}
HDR_BTN_FG=${HDR_BTN_FG-$BTN_FG}
WM_BORDER_FOCUS=${WM_BORDER_FOCUS-$SEL_BG}
WM_BORDER_UNFOCUS=${WM_BORDER_UNFOCUS-$MENU_BG}

GTK3_GENERATE_DARK=$(echo ${GTK3_GENERATE_DARK-True} | tr '[:upper:]' '[:lower:]')
UNITY_DEFAULT_LAUNCHER_STYLE=$(echo ${UNITY_DEFAULT_LAUNCHER_STYLE-False} | tr '[:upper:]' '[:lower:]')

SPACING=${SPACING-3}
GRADIENT=${GRADIENT-0}
ROUNDNESS=${ROUNDNESS-2}
CINNAMON_OPACITY=${CINNAMON_OPACITY-1}
ROUNDNESS_GTK2_HIDPI=$(( ${ROUNDNESS} * 2 ))

if [ $(echo "$GRADIENT < 2" | bc) ]; then
	GTK2_GRAD=$(echo "scale=2; $GRADIENT/2" | bc)
else
    GTK2_GRAD=1
fi
GTK2_GRAD_1=$(echo "1+$GTK2_GRAD" | bc)
GTK2_GRAD_2=$(echo "1-$GTK2_GRAD" | bc)
if expr "$GTK2_GRAD_1" : '-\?[0-9]\+$' >/dev/null; then
  GTK2_GRAD_TOP="$GTK2_GRAD_1".0
  GTK2_GRAD_BOTTOM="$GTK2_GRAD_2".0
else
  GTK2_GRAD_TOP=$GTK2_GRAD_1
  GTK2_GRAD_BOTTOM=$GTK2_GRAD_2
fi

OUTLINE_WIDTH=${OUTLINE_WIDTH-1}
BTN_OUTLINE_WIDTH=${BTN_OUTLINE_WIDTH-1}
BTN_OUTLINE_OFFSET=${BTN_OUTLINE_OFFSET--3}

INACTIVE_FG=$(mix ${FG} ${BG} 0.75)
INACTIVE_MENU_FG=$(mix ${MENU_FG} ${MENU_BG} 0.75)
INACTIVE_TXT_FG=$(mix ${TXT_FG} ${TXT_BG} 0.75)

light_folder_base_fallback="$(darker ${SEL_BG} -10)"
medium_base_fallback="$(darker ${SEL_BG} 37)"
dark_stroke_fallback="$(darker ${SEL_BG} 50)"

ICONS_LIGHT_FOLDER="${ICONS_LIGHT_FOLDER-$light_folder_base_fallback}"
ICONS_LIGHT="${ICONS_LIGHT-$SEL_BG}"
ICONS_MEDIUM="${ICONS_MEDIUM-$medium_base_fallback}"
ICONS_DARK="${ICONS_DARK-$dark_stroke_fallback}"

CARET1_FG="${CARET1_FG-$TXT_FG}"
CARET2_FG="${CARET2_FG-$TXT_FG}"
CARET_SIZE="${CARET_SIZE-0.04}"

TERMINAL_BACKGROUND=${TERMINAL_BACKGROUND:-$SEL_FG}
TERMINAL_COLOR4=${TERMINAL_COLOR4:-3f51b5}
TERMINAL_COLOR9=${TERMINAL_COLOR9:-f44336}
TERMINAL_COLOR10=${TERMINAL_COLOR10:-4caf50}
TERMINAL_COLOR11=${TERMINAL_COLOR11:-ef6c00}
TERMINAL_COLOR12=${TERMINAL_COLOR12:-03a9f4}

OUTPUT_THEME_NAME="${OUTPUT_THEME_NAME-oomox-$THEME}"

DEST_PATH_ROOT="${DEST_PATH_ROOT-$HOME/.themes}"
DEST_PATH="$DEST_PATH_ROOT/${OUTPUT_THEME_NAME/\//-}"

test "$SRC_PATH" = "$DEST_PATH" && echo "can't do that" && exit 1


rm -r "$DEST_PATH" || true
mkdir -p "$DEST_PATH"
echo -e "\nBuilding theme at $DEST_PATH\n"
cp -r "$SRC_PATH/src/index.theme" "$DEST_PATH"
for FILEPATH in "${PATHLIST[@]}"; do
	cp -r "$SRC_PATH/$FILEPATH" "$DEST_PATH"
done


cd "$DEST_PATH"
for FILEPATH in "${PATHLIST[@]}"; do
	find $(echo "${FILEPATH}" | sed -e 's/src\///g' ) -type f -exec sed -i'' \
		-e 's/%BG%/'"$BG"'/g' \
		-e 's/%FG%/'"$FG"'/g' \
		-e 's/%SEL_BG%/'"$SEL_BG"'/g' \
		-e 's/%SEL_FG%/'"$SEL_FG"'/g' \
		-e 's/%ACCENT_BG%/'"$ACCENT_BG"'/g' \
		-e 's/%TXT_BG%/'"$TXT_BG"'/g' \
		-e 's/%TXT_FG%/'"$TXT_FG"'/g' \
		-e 's/%MENU_BG%/'"$MENU_BG"'/g' \
		-e 's/%MENU_FG%/'"$MENU_FG"'/g' \
		-e 's/%BTN_BG%/'"$BTN_BG"'/g' \
		-e 's/%BTN_FG%/'"$BTN_FG"'/g' \
		-e 's/%HDR_BTN_BG%/'"$HDR_BTN_BG"'/g' \
		-e 's/%HDR_BTN_FG%/'"$HDR_BTN_FG"'/g' \
		-e 's/%WM_BORDER_FOCUS%/'"$WM_BORDER_FOCUS"'/g' \
		-e 's/%WM_BORDER_UNFOCUS%/'"$WM_BORDER_UNFOCUS"'/g' \
		-e 's/%ROUNDNESS%/'"$ROUNDNESS"'/g' \
		-e 's/%ROUNDNESS_GTK2_HIDPI%/'"$ROUNDNESS_GTK2_HIDPI"'/g' \
		-e 's/%OUTLINE_WIDTH%/'"$OUTLINE_WIDTH"'/g' \
		-e 's/%BTN_OUTLINE_WIDTH%/'"$BTN_OUTLINE_WIDTH"'/g' \
		-e 's/%BTN_OUTLINE_OFFSET%/'"$BTN_OUTLINE_OFFSET"'/g' \
		-e 's/%SPACING%/'"$SPACING"'/g' \
		-e 's/%GRADIENT%/'"$GRADIENT"'/g' \
		-e 's/%GTK2_GRAD_TOP%/'"$GTK2_GRAD_TOP"'/g' \
		-e 's/%GTK2_GRAD_BOTTOM%/'"$GTK2_GRAD_BOTTOM"'/g' \
		-e 's/%CINNAMON_OPACITY%/'"$CINNAMON_OPACITY"'/g' \
		-e 's/%INACTIVE_FG%/'"$INACTIVE_FG"'/g' \
		-e 's/%INACTIVE_TXT_FG%/'"$INACTIVE_TXT_FG"'/g' \
		-e 's/%INACTIVE_MENU_FG%/'"$INACTIVE_MENU_FG"'/g' \
		-e 's/%ICONS_DARK%/'"$ICONS_DARK"'/g' \
		-e 's/%ICONS_MEDIUM%/'"$ICONS_MEDIUM"'/g' \
		-e 's/%ICONS_LIGHT%/'"$ICONS_LIGHT"'/g' \
		-e 's/%ICONS_LIGHT_FOLDER%/'"$ICONS_LIGHT_FOLDER"'/g' \
		-e 's/%OUTPUT_THEME_NAME%/'"$OUTPUT_THEME_NAME"'/g' \
		-e 's/%CARET1_FG%/'"$CARET1_FG"'/g' \
		-e 's/%CARET2_FG%/'"$CARET2_FG"'/g' \
		-e 's/%CARET_SIZE%/'"$CARET_SIZE"'/g' \
		-e 's/%TERMINAL_BACKGROUND%/'"$TERMINAL_BACKGROUND"'/g' \
		-e 's/%TERMINAL_COLOR4%/'"$TERMINAL_COLOR4"'/g' \
		-e 's/%TERMINAL_COLOR9%/'"$TERMINAL_COLOR9"'/g' \
		-e 's/%TERMINAL_COLOR10%/'"$TERMINAL_COLOR10"'/g' \
		-e 's/%TERMINAL_COLOR11%/'"$TERMINAL_COLOR11"'/g' \
		-e 's/%TERMINAL_COLOR12%/'"$TERMINAL_COLOR12"'/g' \
		{} \; ;
done

if [[ ${GTK3_GENERATE_DARK} != "true" ]] ; then
	if [[ -f ./gtk-3.0/scss/gtk-dark.scss ]] ; then
		rm ./gtk-3.0/scss/gtk-dark.scss
	fi
	if [[ -f ./gtk-3.20/scss/gtk-dark.scss ]] ; then
		rm ./gtk-3.20/scss/gtk-dark.scss
	fi
fi
if [[ ${OPTION_GTK2_HIDPI} == "true" ]] ; then
	mv ./gtk-2.0/gtkrc.hidpi ./gtk-2.0/gtkrc
fi
if [[ ${EXPORT_QT5CT} = 1 ]] ; then
	config_home=${XDG_CONFIG_HOME:-}
	if [[ -z "${config_home}" ]] ; then
		config_home="${HOME}/.config"
	fi
	qt5ct_colors_dir="${config_home}/qt5ct/colors/"
	test -d ${qt5ct_colors_dir} || mkdir -p ${qt5ct_colors_dir}
	mv ./qt5ct_palette.conf "${qt5ct_colors_dir}/${OUTPUT_THEME_NAME}.conf"
fi
if [[ ${UNITY_DEFAULT_LAUNCHER_STYLE} == "true" ]] ; then
	rm ./unity/launcher*.svg
fi

if [[ ${MAKE_GTK3} = 1 ]]; then
	make ${MAKE_OPTS}
fi

rm -r ./Makefile gtk-3.*/scss || true

for FILEPATH in "${SVG_PREVIEWS[@]}"; do
	rsvg-convert --format=png -o $(sed -e 's/svg$/png/' <<< "${FILEPATH}") "${FILEPATH}"
	rm "${FILEPATH}"
done

exit 0
