#FROM oblique/archlinux-pacaur
FROM lihebi/hebi-arch

WORKDIR /opt/oomox-gtk-theme
VOLUME /opt/oomox-gtk-theme/test_results
ENTRYPOINT /bin/bash

# App dependensies:
USER root
RUN bash -c "pacman -Syu --noconfirm && pacman -S --needed --noconfirm bash grep sed bc glib2 gdk-pixbuf2 sassc gtk-engine-murrine gtk-engines"

# Test dependencies:
USER admin
RUN git clone https://aur.archlinux.org/awf-git /home/admin/awf && cd /home/admin/awf && makepkg --install --syncdeps --noconfirm
USER root
RUN pacman -S --needed --noconfirm ttf-roboto scrot xorg-server-xvfb libfaketime xdotool parallel

# Debug dependencies:
RUN pacman -S --needed --noconfirm fish

COPY . /opt/oomox-gtk-theme/
