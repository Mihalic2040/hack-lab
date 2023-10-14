FROM debian:latest

RUN apt-get update && apt-get upgrade


#INSTALL ENV BINS
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install python3-pip sudo git xfce4 faenza-icon-theme bash zsh python3 tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer xfce4-terminal curl wget -y


RUN apt-get install xterm
RUN apt-get install dbus-x11 -y

#SETUP NOVNC
RUN pip install numpy --break-system-packages
RUN git clone https://github.com/novnc/NoVNC /opt/NoVNC
RUN git clone https://github.com/novnc/websockify /opt/NoVNC/utils/websockify

# CREATE USER
RUN adduser --home /home/main --shell /bin/zsh main
RUN echo 'main:main' | chpasswd
#SUDO RULE
RUN echo 'main ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#SWITCH TO USER
USER main
WORKDIR /home/main

RUN touch ~/.zshrc

#START VNC

RUN touch /home/main/.Xauthority
RUN chown main:main /home/main/.Xauthority


# Create VNC startup script and .vnc directory
RUN mkdir -p /home/main/.vnc
RUN echo "#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nstartxfce4" > /home/main/.vnc/xstartup
RUN sudo chmod +x /home/main/.vnc/xstartup
# Set VNC password for the 'main' user
RUN echo 'main' | vncpasswd -f > /home/main/.vnc/passwd
RUN chmod 600 /home/main/.vnc/passwd 


#SETUP
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
COPY ./config/wallpaper/default.jpg /default.jpg
COPY setup.sh /setup.sh
RUN /setup.sh

#ENTRY
COPY entry.sh /entry.sh

EXPOSE 6080

CMD ["/bin/bash", "/entry.sh"]
