<?xml version="1.0"?>
<openbox_config xmlns="http://openbox.org/3.4/rc" xmlns:xi="http://www.w3.org/2001/XInclude">
  <resistance>
    <strength>10</strength>
    <screen_edge_strength>20</screen_edge_strength>
  </resistance>
  <focus>
    <focusNew>yes</focusNew>
    <!-- always try to focus new windows when they appear. other rules do
       apply -->
    <followMouse>no</followMouse>
    <!-- move focus to a window when you move the mouse into it -->
    <focusLast>yes</focusLast>
    <!-- focus the last used window when changing desktops, instead of the one
       under the mouse pointer. when followMouse is enabled -->
    <underMouse>no</underMouse>
    <!-- move focus under the mouse, even when the mouse is not moving -->
    <focusDelay>200</focusDelay>
    <!-- when followMouse is enabled, the mouse must be inside the window for
       this many milliseconds (1000 = 1 sec) before moving focus to it -->
    <raiseOnFocus>no</raiseOnFocus>
    <!-- when followMouse is enabled, and a window is given focus by moving the
       mouse into it, also raise the window -->
  </focus>
  <placement>
    <policy>Smart</policy>
    <!-- 'Smart' or 'UnderMouse' -->
    <center>yes</center>
    <!-- whether to place windows in the center of the free area found or
       the top left corner -->
    <monitor>Active</monitor>
    <!-- with Smart placement on a multi-monitor system, try to place new windows
         on: 'Any' - any monitor, 'Mouse' - where the mouse is, 'Active' - where
         the active window is, 'Primary' - only on the primary monitor -->
    <primaryMonitor>1</primaryMonitor>
    <!-- The monitor where Openbox should place popup dialogs such as the
         focus cycling popup, or the desktop switch popup.  It can be an index
         from 1, specifying a particular monitor.  Or it can be one of the
         following: 'Mouse' - where the mouse is, or
                    'Active' - where the active window is -->
  </placement>
  <theme>
    <name>oomox-${THEME_NAME}</name>
    <titleLayout>CILD</titleLayout>
    <!--
      avaible characters are NDSLIMC, each can occur at most once.
      N: window icon
      L: window label (AKA title).
      I: iconify
      M: maximize
      C: close
      S: shade (roll up/down)
      D: omnipresent (on all desktops).
  -->
    <keepBorder>yes</keepBorder>
    <animateIconify>no</animateIconify>
    <font place="ActiveWindow">
      <name>Sans</name>
      <size>${FONT_SIZE}</size>
      <!-- font size in points -->
      <weight>Bold</weight>
      <!-- 'bold' or 'normal' -->
      <slant>Normal</slant>
      <!-- 'italic' or 'normal' -->
    </font>
    <font place="InactiveWindow">
      <name>Sans</name>
      <size>10</size>
      <!-- font size in points -->
      <weight>Bold</weight>
      <!-- 'bold' or 'normal' -->
      <slant>Normal</slant>
      <!-- 'italic' or 'normal' -->
    </font>
    <font place="MenuHeader">
      <name>Sans</name>
      <size>10</size>
      <!-- font size in points -->
      <weight>Bold</weight>
      <!-- 'bold' or 'normal' -->
      <slant>Normal</slant>
      <!-- 'italic' or 'normal' -->
    </font>
    <font place="MenuItem">
      <name>Sans</name>
      <size>10</size>
      <!-- font size in points -->
      <weight>Normal</weight>
      <!-- 'bold' or 'normal' -->
      <slant>Normal</slant>
      <!-- 'italic' or 'normal' -->
    </font>
    <font place="ActiveOnScreenDisplay">
      <name>Sans</name>
      <size>12</size>
      <!-- font size in points -->
      <weight>Normal</weight>
      <!-- 'bold' or 'normal' -->
      <slant>Normal</slant>
      <!-- 'italic' or 'normal' -->
    </font>
    <font place="InactiveOnScreenDisplay">
      <name>Sans</name>
      <size>12</size>
      <!-- font size in points -->
      <weight>Normal</weight>
      <!-- 'bold' or 'normal' -->
      <slant>Normal</slant>
      <!-- 'italic' or 'normal' -->
    </font>
  </theme>
  <desktops>
    <!-- this stuff is only used at startup, pagers allow you to change them
       during a session

       these are default values to use when other ones are not already set
       by other applications, or saved in your session

       use obconf if you want to change these without having to log out
       and back in -->
    <number>4</number>
    <firstdesk>1</firstdesk>
    <names>
      <name>&#x2801;</name>
      <name>&#x2809;</name>
      <name>&#x2819;</name>
      <name>&#x281B;</name>
    </names>
    <popupTime>875</popupTime>
    <!-- The number of milliseconds to show the popup for when switching
         desktops.  Set this to 0 to disable the popup. -->
  </desktops>
  <resize>
    <drawContents>yes</drawContents>
    <popupShow>Nonpixel</popupShow>
    <!-- 'Always', 'Never', or 'Nonpixel' (xterms and such) -->
    <popupPosition>Center</popupPosition>
    <!-- 'Center' or 'Top' -->
    <popupFixedPosition>
      <!-- these are used if popupPosition is set to 'Fixed' -->
      <x>10</x>
      <!-- positive number for distance from left edge, negative number for
           distance from right edge, or 'Center' -->
      <y>10</y>
      <!-- positive number for distance from top edge, negative number for
           distance from bottom edge, or 'Center' -->
    </popupFixedPosition>
  </resize>
  <!-- You can reserve a portion of your screen where windows will not cover when
       they are maximized, or when they are initially placed.
       Many programs reserve space automatically, but you can use this in other
       cases. -->
  <margins>
    <top>1</top>
    <bottom>0</bottom>
    <left>0</left>
    <right>0</right>
  </margins>
  <dock>
    <position>TopLeft</position>
    <!-- (Top|Bottom)(Left|Right|)|Top|Bottom|Left|Right|Floating -->
    <floatingX>0</floatingX>
    <floatingY>0</floatingY>
    <noStrut>no</noStrut>
    <stacking>Above</stacking>
    <!-- 'Above', 'Normal', or 'Below' -->
    <direction>Vertical</direction>
    <!-- 'Vertical' or 'Horizontal' -->
    <autoHide>no</autoHide>
    <hideDelay>300</hideDelay>
    <!-- in milliseconds (1000 = 1 second) -->
    <showDelay>300</showDelay>
    <!-- in milliseconds (1000 = 1 second) -->
    <moveButton>Middle</moveButton>
    <!-- 'Left', 'Middle', 'Right' -->
  </dock>
  <keyboard>
    <chainQuitKey>C-g</chainQuitKey>
    <keybind key="W-comma">
      <action name="DesktopLeft"/>
    </keybind>
    <keybind key="W-period">
      <action name="DesktopRight"/>
    </keybind>
    <keybind key="C-A-Up">
      <action name="GoToDesktop"/>
    </keybind>
    <keybind key="C-A-Down">
      <action name="GoToDesktop"/>
    </keybind>
    <keybind key="S-A-Left">
      <action name="SendToDesktop"/>
    </keybind>
    <keybind key="S-A-Right">
      <action name="SendToDesktop"/>
    </keybind>
    <keybind key="S-A-Up">
      <action name="SendToDesktop"/>
    </keybind>
    <keybind key="S-A-Down">
      <action name="SendToDesktop"/>
    </keybind>
    <keybind key="W-F1">
      <action name="GoToDesktop"/>
    </keybind>
    <keybind key="W-Escape">
      <action name="DesktopLast"/>
    </keybind>
    <keybind key="W-F2">
      <action name="GoToDesktop"/>
    </keybind>
    <keybind key="W-F3">
      <action name="GoToDesktop"/>
    </keybind>
    <keybind key="W-F4">
      <action name="GoToDesktop"/>
    </keybind>
    <keybind key="W-d">
      <action name="ToggleShowDesktop"/>
    </keybind>
    <keybind key="A-F4">
      <action name="Close"/>
    </keybind>
    <keybind key="A-Escape">
      <action name="Lower"/>
      <action name="FocusToBottom"/>
      <action name="Unfocus"/>
    </keybind>
    <keybind key="A-space">
      <action name="ShowMenu">
        <menu>client-menu</menu>
      </action>
    </keybind>
    <keybind key="Print">
      <action name="Execute">
        <command>xfce4-screenshooter</command>
      </action>
    </keybind>
    <keybind key="A-Tab">
      <action name="NextWindow"/>
    </keybind>
    <keybind key="A-S-Tab">
      <action name="PreviousWindow"/>
    </keybind>
    <keybind key="C-A-Tab">
      <action name="NextWindow">
        <panels>yes</panels>
        <desktop>yes</desktop>
      </action>
    </keybind>
    <keybind key="W-S-Right">
      <action name="DirectionalCycleWindows"/>
    </keybind>
    <keybind key="W-S-Left">
      <action name="DirectionalCycleWindows"/>
    </keybind>
    <keybind key="W-S-Up">
      <action name="DirectionalCycleWindows"/>
    </keybind>
    <keybind key="W-S-Down">
      <action name="DirectionalCycleWindows"/>
    </keybind>
    <keybind key="A-F2">
      <action name="Execute">
        <command>gmrun</command>
        <startupnotify>
          <enabled>yes</enabled>
          <name>Run Program</name>
        </startupnotify>
      </action>
    </keybind>
    <keybind key="W-space">
      <action name="Execute">
        <command>~/.config/dmenu/dmenu-recent.sh</command>
        <startupnotify>
          <enabled>yes</enabled>
          <name>dmenu-bind</name>
        </startupnotify>
      </action>
    </keybind>
    <keybind key="W-f">
      <action name="Execute">
        <command>stuurman</command>
        <startupnotify>
          <enabled>yes</enabled>
          <name>pcmanfm</name>
        </startupnotify>
      </action>
    </keybind>
    <keybind key="W-t">
      <action name="Execute">
        <command>terminator --geometry=840x450</command>
        <startupnotify>
          <enabled>yes</enabled>
          <name>Terminal</name>
        </startupnotify>
      </action>
    </keybind>
    <keybind key="W-l">
      <action name="Execute">
        <command>cb-lock</command>
        <startupnotify>
          <enabled>yes</enabled>
          <name>Lock screen</name>
        </startupnotify>
      </action>
    </keybind>
    <keybind key="W-e">
      <action name="Execute">
        <command>geany</command>
        <startupnotify>
          <enabled>yes</enabled>
          <name>Editor</name>
        </startupnotify>
      </action>
    </keybind>
    <keybind key="W-x">
      <action name="Execute">
        <command>cb-exit</command>
        <startupnotify>
          <enabled>yes</enabled>
          <name>Logout</name>
        </startupnotify>
      </action>
    </keybind>
    <keybind key="W-Tab">
      <action name="ShowMenu">
        <menu>client-list-combined-menu</menu>
      </action>
    </keybind>
    <keybind key="A-C-q">
      <action name="ShowMenu">
        <menu>root-menu</menu>
      </action>
    </keybind>
    <keybind key="W-Right">
      <action name="GrowToEdgeEast"/>
    </keybind>
    <keybind key="W-Left">
      <action name="GrowToEdgeWest"/>
    </keybind>
    <keybind key="W-Down">
      <action name="GrowToEdgeSouth"/>
    </keybind>
    <keybind key="W-Up">
      <action name="GrowToEdgeNorth"/>
    </keybind>
    <keybind key="W-A-Left">
      <action name="Execute">
        <command>cb-aerosnap --left</command>
      </action>
    </keybind>
    <keybind key="W-A-Right">
      <action name="Execute">
        <command>cb-aerosnap --right</command>
      </action>
    </keybind>
  </keyboard>
  <mouse>
    <dragThreshold>8</dragThreshold>
    <!-- number of pixels the mouse must move before a drag begins -->
    <doubleClickTime>300</doubleClickTime>
    <!-- in milliseconds (1000 = 1 second) -->
    <screenEdgeWarpTime>400</screenEdgeWarpTime>
    <!-- Time before changing desktops when the pointer touches the edge of the
       screen while moving a window, in milliseconds (1000 = 1 second).
       Set this to 0 to disable warping -->
    <screenEdgeWarpMouse>false</screenEdgeWarpMouse>
    <!-- Set this to TRUE to move the mouse pointer across the desktop when
       switching due to hitting the edge of the screen -->
    <context name="Frame">
      <!--<mousebind button="A-Left" action="Press">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind button="A-Left" action="Click">
        <action name="Unshade"/>
      </mousebind>-->
      <mousebind action="Drag" button="W-Left">
        <action name="Move"/>
      </mousebind>
      <mousebind action="Press" button="W-Right">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Drag" button="W-Right">
        <action name="Resize"/>
      </mousebind>
      <mousebind action="Press" button="W-Middle">
        <action name="Lower"/>
        <action name="FocusToBottom"/>
        <action name="Unfocus"/>
      </mousebind>
      <mousebind action="Click" button="W-Up">
        <action name="GoToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="W-Down">
        <action name="GoToDesktop">
          <to>next</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="C-A-Up">
        <action name="GoToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="C-A-Down">
        <action name="GoToDesktop">
          <to>next</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="A-S-Up">
        <action name="SendToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="A-S-Down">
        <action name="SendToDesktop">
          <to>next</to>
        </action>
      </mousebind>
    </context>
    <context name="Titlebar">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Drag" button="Left">
        <action name="Move"/>
      </mousebind>
      <mousebind action="DoubleClick" button="Left">
        <action name="ToggleMaximize"/>
      </mousebind>
      <mousebind action="Press" button="Middle">
        <action name="Lower"/>
        <action name="FocusToBottom"/>
        <action name="Unfocus"/>
      </mousebind>
      <mousebind action="Click" button="Up">
        <action name="if">
          <shaded>no</shaded>
          <then>
            <action name="Shade"/>
            <action name="FocusToBottom"/>
            <action name="Unfocus"/>
            <action name="Lower"/>
          </then>
        </action>
      </mousebind>
      <mousebind action="Click" button="Down">
        <action name="if">
          <shaded>yes</shaded>
          <then>
            <action name="Unshade"/>
            <action name="Raise"/>
          </then>
        </action>
      </mousebind>
      <mousebind action="Press" button="Right">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="ShowMenu">
          <menu>client-menu</menu>
        </action>
      </mousebind>
    </context>
    <context name="Titlebar Top Right Bottom Left TLCorner TRCorner BRCorner BLCorner">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Press" button="Middle">
        <action name="Lower"/>
        <action name="FocusToBottom"/>
        <action name="Unfocus"/>
      </mousebind>
      <mousebind action="Press" button="Right">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="ShowMenu">
          <menu>client-menu</menu>
        </action>
      </mousebind>
    </context>
    <context name="Top">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Drag" button="Left">
        <action name="Resize">
          <edge>top</edge>
        </action>
      </mousebind>
    </context>
    <context name="Left">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Drag" button="Left">
        <action name="Resize">
          <edge>left</edge>
        </action>
      </mousebind>
    </context>
    <context name="Right">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Drag" button="Left">
        <action name="Resize">
          <edge>right</edge>
        </action>
      </mousebind>
    </context>
    <context name="Bottom">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Drag" button="Left">
        <action name="Resize">
          <edge>bottom</edge>
        </action>
      </mousebind>
      <mousebind action="Press" button="Middle">
        <action name="Lower"/>
        <action name="FocusToBottom"/>
        <action name="Unfocus"/>
      </mousebind>
      <mousebind action="Press" button="Right">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="ShowMenu">
          <menu>client-menu</menu>
        </action>
      </mousebind>
    </context>
    <context name="TRCorner BRCorner TLCorner BLCorner">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Drag" button="Left">
        <action name="Resize"/>
      </mousebind>
    </context>
    <context name="Client">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Press" button="Middle">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Press" button="Right">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
    </context>
    <context name="Icon">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
        <action name="ShowMenu">
          <menu>client-menu</menu>
        </action>
      </mousebind>
      <mousebind action="Press" button="Right">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="ShowMenu">
          <menu>client-menu</menu>
        </action>
      </mousebind>
    </context>
    <context name="AllDesktops">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Click" button="Right">
        <action name="ToggleAlwaysOnTop"/>
      </mousebind>
      <mousebind action="Click" button="Left">
        <action name="ToggleOmnipresent"/>
      </mousebind>
    </context>
    <context name="Shade">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Click" button="Left">
        <action name="ToggleShade"/>
      </mousebind>
    </context>
    <context name="Iconify">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
      <mousebind action="Click" button="Left">
        <action name="Iconify"/>
      </mousebind>
    </context>
    <context name="Maximize">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Press" button="Middle">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Press" button="Right">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Click" button="Left">
        <action name="ToggleMaximize"/>
      </mousebind>
      <mousebind action="Click" button="Middle">
        <action name="ToggleMaximize">
          <direction>vertical</direction>
        </action>
      </mousebind>
      <mousebind action="Click" button="Right">
        <action name="ToggleMaximize">
          <direction>horizontal</direction>
        </action>
      </mousebind>
    </context>
    <context name="Close">
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
        <action name="Unshade"/>
      </mousebind>
      <mousebind action="Click" button="Left">
        <action name="Close"/>
      </mousebind>
    </context>
    <context name="Desktop">
      <mousebind action="Click" button="Up">
        <action name="GoToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="Down">
        <action name="GoToDesktop">
          <to>next</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="A-Up">
        <action name="GoToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="A-Down">
        <action name="GoToDesktop">
          <to>next</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="C-A-Up">
        <action name="GoToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="C-A-Down">
        <action name="GoToDesktop">
          <to>next</to>
        </action>
      </mousebind>
      <mousebind action="Press" button="Left">
        <action name="Focus"/>
        <action name="Raise"/>
      </mousebind>
    </context>
    <context name="Root">
      <!-- Menus -->
      <mousebind action="Press" button="Middle">
        <action name="ShowMenu">
          <menu>client-list-combined-menu</menu>
        </action>
      </mousebind>
      <mousebind action="Press" button="Right">
        <action name="ShowMenu">
          <menu>root-menu</menu>
        </action>
      </mousebind>
    </context>
    <context name="MoveResize">
      <mousebind action="Click" button="Up">
        <action name="GoToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="Down">
        <action name="GoToDesktop">
          <to>next</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="A-Up">
        <action name="GoToDesktop">
          <to>previous</to>
        </action>
      </mousebind>
      <mousebind action="Click" button="A-Down">
        <action name="GoToDesktop">
          <to>next</to>
        </action>
      </mousebind>
    </context>
  </mouse>
  <menu>
    <!-- You can specify more than one menu file in here and they are all loaded,
       just don't make menu ids clash or, well, it'll be kind of pointless -->
    <!-- default menu file (or custom one in $HOME/.config/openbox/) -->
    <!-- system menu files on Debian systems
    <file>/var/lib/openbox/debian-menu.xml</file>
    <file>debian-menu.xml</file> -->
    <file>menu.xml</file>
    <hideDelay>200</hideDelay>
    <!-- if a press-release lasts longer than this setting (in milliseconds), the
       menu is hidden again -->
    <middle>no</middle>
    <!-- center submenus vertically about the parent entry -->
    <submenuShowDelay>100</submenuShowDelay>
    <!-- time to delay before showing a submenu after hovering over the parent
       entry.
       if this is a negative value, then the delay is infinite and the
       submenu will not be shown until it is clicked on -->
    <submenuHideDelay>400</submenuHideDelay>
    <!-- time to delay before hiding a submenu when selecting another
       entry in parent menu
       if this is a negative value, then the delay is infinite and the
       submenu will not be hidden until a different submenu is opened -->
    <applicationIcons>yes</applicationIcons>
    <!-- controls if icons appear in the client-list-(combined-)menu -->
    <manageDesktops>yes</manageDesktops>
    <!-- show the manage desktops section in the client-list-(combined-)menu -->
  </menu>
  <applications>
    <!--
  # this is an example with comments through out. use these to make your
  # own rules, but without the comments of course.
  # you may use one or more of the name/class/role/title/type rules to specify
  # windows to match

  <application name="the window's _OB_APP_NAME property (see obxprop)"
              class="the window's _OB_APP_CLASS property (see obxprop)"
               role="the window's _OB_APP_ROLE property (see obxprop)"
              title="the window's _OB_APP_TITLE property (see obxprop)"
               type="the window's _OB_APP_TYPE property (see obxprob)..
                      (if unspecified, then it is 'dialog' for child windows)">
  # you may set only one of name/class/role/title/type, or you may use more
  # than one together to restrict your matches.

  # the name, class, role, and title use simple wildcard matching such as those
  # used by a shell. you can use * to match any characters and ? to match
  # any single character.

  # the type is one of: normal, dialog, splash, utility, menu, toolbar, dock,
  #    or desktop

  # when multiple rules match a window, they will all be applied, in the
  # order that they appear in this list


    # each rule element can be left out or set to 'default' to specify to not
    # change that attribute of the window

    <decor>yes</decor>
    # enable or disable window decorations

    <shade>no</shade>
    # make the window shaded when it appears, or not

    <position force="no">
      # the position is only used if both an x and y coordinate are provided
      # (and not set to 'default')
      # when force is "yes", then the window will be placed here even if it
      # says you want it placed elsewhere.  this is to override buggy
      # applications who refuse to behave
      <x>center</x>
      # a number like 50, or 'center' to center on screen. use a negative number
      # to start from the right (or bottom for <y>), ie -50 is 50 pixels from the
      # right edge (or bottom).
      <y>200</y>
      <monitor>1</monitor>
      # specifies the monitor in a xinerama setup.
      # 1 is the first head, or 'mouse' for wherever the mouse is
    </position>

    <focus>yes</focus>
    # if the window should try be given focus when it appears. if this is set
    # to yes it doesn't guarantee the window will be given focus. some
    # restrictions may apply, but Openbox will try to

    <desktop>1</desktop>
    # 1 is the first desktop, 'all' for all desktops

    <layer>normal</layer>
    # 'above', 'normal', or 'below'

    <iconic>no</iconic>
    # make the window iconified when it appears, or not

    <skip_pager>no</skip_pager>
    # asks to not be shown in pagers

    <skip_taskbar>no</skip_taskbar>
    # asks to not be shown in taskbars. window cycling actions will also
    # skip past such windows

    <fullscreen>yes</fullscreen>
    # make the window in fullscreen mode when it appears

    <maximized>true</maximized>
    # 'Horizontal', 'Vertical' or boolean (yes/no)
  </application>

  # end of the example
-->
    <application name="terminator">
      <!--<decor>no</decor>-->
      <position force="no">
        <x>-0</x>
        <y>-0</y>
      </position>
    </application>
    <application name="skype" role="">
      <decor>no</decor>
      <position force="yes">
        <x>-0</x>
        <y>-0</y>
      </position>
    </application>
    <application name="xpad">
      <layer>below</layer>
      <desktop>all</desktop>
      <decor>no</decor>
      <skip_pager>yes</skip_pager>
      <skip_taskbar>yes</skip_taskbar>
    </application>
    <application name="gmessage">
      <decor>no</decor>
      <shade>no</shade>
      <skip_pager>yes</skip_pager>
      <skip_taskbar>yes</skip_taskbar>
      <fullscreen>no</fullscreen>
      <maximized>no</maximized>
    </application>
    <application class="Gimp" name="gimp" role="gimp-toolbox" type="utility">
      <maximized>vertical</maximized>
    </application>
    <application class="Gimp" name="gimp" role="gimp-dock" type="utility">
      <maximized>vertical</maximized>
    </application>
    <application class="Gimp" name="gimp" role="gimp-image-window" type="normal">
      <position force="no">
        <x>center</x>
        <y>center</y>
      </position>
    </application>
    <application class="Gimp" name="gimp-2.8" role="gimp-toolbox" type="utility">
      <maximized>vertical</maximized>
    </application>
    <application class="Gimp" name="gimp-2.8" role="gimp-dock" type="utility">
      <maximized>vertical</maximized>
    </application>
    <application class="Gimp" name="gimp-2.8" role="gimp-image-window" type="normal">
      <position force="no">
        <x>center</x>
        <y>center</y>
      </position>
    </application>
  </applications>
  <application name="oblogout">
    <position force="yes">
      <x>right</x>
      <y>0</y>
    </position>
    <size>
      <width>1440</width>
      <height>900</height>
    </size>
  </application>
</openbox_config>
