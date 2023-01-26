import os

from gi.repository import Gtk

from oomox_gui.export_common import CommonGtkThemeExportDialog
from oomox_gui.i18n import translate
from oomox_gui.plugin_api import OomoxThemePlugin

try:
    from oomox_gui.export_common import CommonGtkThemeExportDialogOptions
except ImportError:
    CommonGtkThemeExportDialogOptions = CommonGtkThemeExportDialog.OPTIONS.__class__


PLUGIN_DIR = os.path.dirname(os.path.realpath(__file__))
GTK_THEME_DIR = PLUGIN_DIR


class OomoxThemeExportDialogOptions(CommonGtkThemeExportDialogOptions):
    GTK3_CURRENT_VERSION_ONLY = "self.OPTIONS.GTK3_CURRENT_VERSION_ONLY"
    EXPORT_CINNAMON_THEME = "self.OPTIONS.EXPORT_CINNAMON_THEME"


class OomoxThemeExportDialog(CommonGtkThemeExportDialog):
    OPTIONS = OomoxThemeExportDialogOptions()
    timeout = 100
    config_name = "gtk_theme_oomox"

    def do_export(self):
        export_path = os.path.expanduser(
            self.option_widgets[self.OPTIONS.DEFAULT_PATH].get_text()
        )
        new_destination_dir, theme_name = export_path.rsplit("/", 1)

        self.command = [
            "bash",
            os.path.join(GTK_THEME_DIR, "change_color.sh"),
            "--hidpi", str(self.export_config[self.OPTIONS.GTK2_HIDPI]),
            "--target-dir", new_destination_dir,
            "--output", theme_name,
            self.temp_theme_path,
        ]
        make_opts = []
        if self.export_config[self.OPTIONS.GTK3_CURRENT_VERSION_ONLY]:
            if Gtk.get_minor_version() >= 20:
                make_opts += ["gtk320"]
            else:
                make_opts += ["gtk3"]
        else:
            make_opts += ["gtk3", "gtk320"]
        if self.export_config[self.OPTIONS.EXPORT_CINNAMON_THEME]:
            make_opts += ["css_cinnamon"]
        if make_opts:
            self.command += [
                "--make-opts", " ".join(make_opts),
            ]
        super().do_export()

    def __init__(self, transient_for, colorscheme, theme_name, **kwargs):
        super().__init__(
            transient_for=transient_for,
            colorscheme=colorscheme,
            theme_name=theme_name,
            add_options={
                self.OPTIONS.GTK3_CURRENT_VERSION_ONLY: {
                    "default": False,
                    "display_name": translate(
                        "Generate theme only for the current _GTK+3 version\n"
                        "instead of both 3.18 and 3.20+"
                    ),
                },
                self.OPTIONS.EXPORT_CINNAMON_THEME: {
                    "default": False,
                    "display_name": translate("Generate theme for _Cinnamon"),
                },
            },
            **kwargs
        )


class Plugin(OomoxThemePlugin):

    name = "oomox"
    display_name = "Oomox"
    description = (
        "GTK+2, GTK+3, Qt5ct, Qt6ct\n"
        "Cinnamon, Metacity, Openbox, Unity, Xfwm"
    )
    about_text = translate("The default theme, originally based on Numix GTK theme.")
    about_links = [
        {
            "name": translate("Homepage"),
            "url": "https://github.com/themix-project/oomox-gtk-theme/",
        },
    ]

    export_dialog = OomoxThemeExportDialog
    gtk_preview_dir = os.path.join(PLUGIN_DIR, "gtk_preview_css/")

    enabled_keys_gtk = [
        "BG",
        "FG",
        "HDR_BG",
        "HDR_FG",
        "SEL_BG",
        "SEL_FG",
        "ACCENT_BG",
        "TXT_BG",
        "TXT_FG",
        "BTN_BG",
        "BTN_FG",
        "HDR_BTN_BG",
        "HDR_BTN_FG",
        "WM_BORDER_FOCUS",
        "WM_BORDER_UNFOCUS",
    ]

    enabled_keys_options = [
        "ROUNDNESS",
        "SPACING",
        "GRADIENT",
        "GTK3_GENERATE_DARK",
    ]

    theme_model_gtk = [
        {
            "key": "CARET1_FG",
            "type": "color",
            "fallback_key": "TXT_FG",
            "display_name": translate("Textbox Caret"),
        },
        {
            "key": "CARET2_FG",
            "type": "color",
            "fallback_key": "TXT_FG",
            "display_name": translate("BiDi Textbox Caret"),
        },
    ]

    theme_model_options = [
        {
            "key": "CARET_SIZE",
            "type": "float",
            "fallback_value": 0.04,  # GTK's default
            "display_name": translate("Textbox Caret Aspect Ratio"),
        },
        {
            "type": "separator",
            "display_name": translate("GTK3 Theme Options"),
            "value_filter": {
                "THEME_STYLE": "oomox",
            },
        },
        {
            "key": "SPACING",
            "type": "int",
            "fallback_value": 3,
            "display_name": translate("Spacing"),
        },
        {
            "key": "OUTLINE_WIDTH",
            "type": "int",
            "fallback_value": 1,
            "display_name": translate("Focused Outline Width"),
        },
        {
            "key": "BTN_OUTLINE_WIDTH",
            "type": "int",
            "fallback_value": 1,
            "display_name": translate("Focused Button Outline Width"),
        },
        {
            "key": "BTN_OUTLINE_OFFSET",
            "type": "int",
            "fallback_value": -3,
            "min_value": -20,
            "display_name": translate("Focused Button Outline Offset"),
        },
        {
            "key": "GTK3_GENERATE_DARK",
            "type": "bool",
            "fallback_value": True,
            "display_name": translate("Add Dark Variant"),
        },

        {
            "type": "separator",
            "display_name": translate("Desktop Environments"),
            "value_filter": {
                "THEME_STYLE": "oomox",
            },
        },
        {
            "key": "CINNAMON_OPACITY",
            "type": "float",
            "fallback_value": 1.0,
            "max_value": 1.0,
            "display_name": translate("Cinnamon: Opacity"),
        },
        {
            "key": "UNITY_DEFAULT_LAUNCHER_STYLE",
            "type": "bool",
            "fallback_value": False,
            "display_name": translate("Unity: Use Default Launcher Style"),
        },
    ]

    def preview_before_load_callback(self, preview_object, colorscheme):  # noqa: ARG002
        preview_object.WM_BORDER_WIDTH = 2
