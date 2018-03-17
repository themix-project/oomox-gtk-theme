FROM base/archlinux

WORKDIR /opt/oomox-gtk-theme
VOLUME /opt/oomox-gtk-theme/test_results
ENTRYPOINT /bin/bash

RUN echo "Update arch deps - 1"
# App dependensies:
RUN pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm bash grep sed bc glib2 gdk-pixbuf2 sassc gtk-engine-murrine gtk-engines gtk3 make

# Test dependencies:
RUN pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm git base-devel && \
    useradd -m user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sudo -u user bash -c "\
        git clone https://aur.archlinux.org/awf-git /home/user/awf && \
        cd /home/user/awf && \
        makepkg --install --syncdeps --noconfirm"
RUN pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm ttf-roboto scrot xorg-server-xvfb libfaketime xdotool parallel gnome-themes-standard adwaita-icon-theme openbox xorg-xrdb xorg-xsetroot imagemagick

# Debug dependencies:
#RUN pacman -S --needed --noconfirm fish

COPY . /opt/oomox-gtk-theme/

# workaround for bug in GTK 3.22.28:
RUN pacman -U --noconfirm https://archive.archlinux.org/packages/g/gtk3/gtk3-3.22.26-1-x86_64.pkg.tar.xz
