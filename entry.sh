#!/bin/bash




#RUN INIT FROM work
sudo chmod 777 /home/main/Desktop/work

# Check if init.sh script exists in the specified directory
directory="/home/main/Desktop/work"
init_script="$directory/init.sh"
text_to_add="#This is init script!
#This code will be run evry container boot.
#You can use it for configuration or etc...


# Set the default wallpaper using xfconf-query
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVNC-0/workspace0/last-image -s /home/main/Desktop/work/config/wallpaper.jpg

"

# Check if init.sh script exists in the specified directory
if [ -f "$init_script" ]; then
    # If the script exists, make it executable and run it
    chmod +x "$init_script"
    "$init_script"
    echo "init.sh script executed successfully."
else
    # If the script does not exist, create it and add text
    echo "#!/bin/bash" > "$init_script"
    echo "$text_to_add" >> "$init_script"
    chmod +x "$init_script"
    mkdir $directory/config
    cp /default.jpg $directory/config/wallpaper.jpg
    echo "init.sh script created and executed successfully."
fi

#ADD auto start to script

mkdir -p ~/.config/autostart
cat <<EOF > "/home/main/.config/autostart/MyScript.desktop"
[Desktop Entry]
Type=Application
Terminal=true
Name=My Script
Exec=/home/main/Desktop/work/init.sh
Icon=/path/to/icon.png
Categories=Utility;
EOF


#RUN VNC
/usr/bin/vncserver :99 -localhost no -geometry 3840x2160
/opt/NoVNC/utils/novnc_proxy --vnc 127.0.0.1:5999 
