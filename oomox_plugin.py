import os

from gi.repository import Gtk

from oomox_gui.export_common import OPTION_GTK2_HIDPI, CommonGtkThemeExportDialog
from oomox_gui.plugin_api import OomoxThemePlugin
from oomox_gui.i18n import translate


OPTION_GTK3_CURRENT_VERSION_ONLY = 'OPTION_GTK3_CURRENT_VERSION_ONLY'
OPTION_EXPORT_CINNAMON_THEME = 'OPTION_EXPORT_CINNAMON_THEME'
OPTION_DEFAULT_PATH = 'default_path'  # @TODO: move it to CommonGtkThemeExportDialog

PLUGIN_DIR = os.path.dirname(os.path.realpath(__file__))
GTK_THEME_DIR = PLUGIN_DIR


class OomoxThemeExportDialog(CommonGtkThemeExportDialog):
    timeout = 100
    config_name = 'gtk_theme_oomox'

    def do_export(self):
        export_path = os.path.expanduser(
            self.option_widgets[OPTION_DEFAULT_PATH].get_text()
        )
        new_destination_dir, theme_name = export_path.rsplit('/', 1)

        self.command = [
            "bash",
            os.path.join(GTK_THEME_DIR, "change_color.sh"),
            "--hidpi", str(self.export_config[OPTION_GTK2_HIDPI]),
            "--target-dir", new_destination_dir,
            "--output", theme_name,
            self.temp_theme_path,
        ]
        make_opts = []
        if self.export_config[OPTION_GTK3_CURRENT_VERSION_ONLY]:
            if Gtk.get_minor_version() >= 20:
                make_opts += ["gtk320"]
            else:
                make_opts += ["gtk3"]
        else:
            make_opts += ["gtk3", "gtk320"]
        if self.export_config[OPTION_EXPORT_CINNAMON_THEME]:
            make_opts += ["css_cinnamon"]
        if make_opts:
            self.command += [
                "--make-opts", " ".join(make_opts),
            ]
        super().do_export()

        self.export_config[OPTION_DEFAULT_PATH] = new_destination_dir
        self.export_config.save()

    def __init__(self, transient_for, colorscheme, theme_name, **kwargs):
        default_themes_path = os.path.join(os.environ['HOME'], '.themes')
        super().__init__(
            transient_for=transient_for,
            colorscheme=colorscheme,
            theme_name=theme_name,
            add_options={
                OPTION_GTK3_CURRENT_VERSION_ONLY: {
                    'default': False,
                    'display_name': translate(
                        "Generate theme only for the current _GTK+3 version\n"
                        "instead of both 3.18 and 3.20+"
                    ),
                },
                OPTION_EXPORT_CINNAMON_THEME: {
                    'default': False,
                    'display_name': translate("Generate theme for _Cinnamon"),
                },
                OPTION_DEFAULT_PATH: {
                    'default': default_themes_path,
                    'display_name': translate("Export _path: "),
                },
            },
            **kwargs
        )
        self.option_widgets[OPTION_DEFAULT_PATH].set_text(
            os.path.join(
                self.export_config[OPTION_DEFAULT_PATH],
                self.theme_name,
            )
        )


class Plugin(OomoxThemePlugin):

    name = 'oomox'
    display_name = 'Oomox'
    description = (
        'GTK+2, GTK+3, Qt5ct, Qt6ct\n'
        'Cinnamon, Metacity, Openbox, Unity, Xfwm'
    )
    about_text = 'The default theme, originally based on Numix GTK theme.'
    about_links = [
        {
            'name': 'Homepage',
            'url': 'https://github.com/themix-project/oomox-gtk-theme/',
        },
    ]

    export_dialog = OomoxThemeExportDialog
    gtk_preview_dir = os.path.join(PLUGIN_DIR, "gtk_preview_css/")

    enabled_keys_gtk = [
        'BG',
        'FG',
        'HDR_BG',
        'HDR_FG',
        'SEL_BG',
        'SEL_FG',
        'ACCENT_BG',
        'TXT_BG',
        'TXT_FG',
        'BTN_BG',
        'BTN_FG',
        'HDR_BTN_BG',
        'HDR_BTN_FG',
        'WM_BORDER_FOCUS',
        'WM_BORDER_UNFOCUS',
    ]

    enabled_keys_options = [
        'ROUNDNESS',
        'SPACING',
        'GRADIENT',
        'GTK3_GENERATE_DARK',
    ]

    theme_model_gtk = [
        {
            'key': 'CARET1_FG',
            'type': 'color',
            'fallback_key': 'TXT_FG',
            'display_name': translate('Textbox Caret'),
        },
        {
            'key': 'CARET2_FG',
            'type': 'color',
            'fallback_key': 'TXT_FG',
            'display_name': translate('BiDi Textbox Caret'),
        },
    ]

    theme_model_options = [
        {
            'key': 'CARET_SIZE',
            'type': 'float',
            'fallback_value': 0.04,  # GTK's default
            'display_name': translate('Textbox Caret Aspect Ratio'),
        },
        {
            'type': 'separator',
            'display_name': translate('GTK3 Theme Options'),
            'value_filter': {
                'THEME_STYLE': 'oomox',
            },
        },
        {
            'key': 'SPACING',
            'type': 'int',
            'fallback_value': 3,
            'display_name': translate('Spacing'),
        },
        {
            'key': 'OUTLINE_WIDTH',
            'type': 'int',
            'fallback_value': 1,
            'display_name': translate('Focused Outline Width'),
        },
        {
            'key': 'BTN_OUTLINE_WIDTH',
            'type': 'int',
            'fallback_value': 1,
            'display_name': translate('Focused Button Outline Width'),
        },
        {
            'key': 'BTN_OUTLINE_OFFSET',
            'type': 'int',
            'fallback_value': -3,
            'min_value': -20,
            'display_name': translate('Focused Button Outline Offset'),
        },
        {
            'key': 'GTK3_GENERATE_DARK',
            'type': 'bool',
            'fallback_value': True,
            'display_name': translate('Add Dark Variant'),
        },

        {
            'type': 'separator',
            'display_name': translate('Desktop Environments'),
            'value_filter': {
                'THEME_STYLE': 'oomox',
            },
        },
        {
            'key': 'CINNAMON_OPACITY',
            'type': 'float',
            'fallback_value': 1.0,
            'max_value': 1.0,
            'display_name': translate('Cinnamon: Opacity'),
        },
        {
            'key': 'UNITY_DEFAULT_LAUNCHER_STYLE',
            'type': 'bool',
            'fallback_value': False,
            'display_name': translate('Unity: Use Default Launcher Style'),
        },
    ]

    def preview_before_load_callback(self, preview_object, colorscheme):
        preview_object.WM_BORDER_WIDTH = 2
