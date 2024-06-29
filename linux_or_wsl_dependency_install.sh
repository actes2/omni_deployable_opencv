# ----- Linux Usage -----
# So long as you have apt, you're pretty much good to go. I haven't tested this on anything other than ubuntu
# Realistically, you can probably get this to work with any package manager as I'm too lazy to hunt down libgtk2.0-0's dependencies.
#
# ----- WSL usage -----
# This bash-script treats your WSL (Windows Subsystem for Linux) instance the same way as a docker container, and
# installs the dependencies locally to your current profile. It then creates a new link to our depencencies via: ldconfig -L
#
# TL;DR - This will unpack the opencv dependencies for whatever linux instance you're leveraging

echo "Installing rsync if it doesn't already exist"
apt-get update
apt-get install rsync -y
apt-get install libgtk2.0-0 -y

rsync -avh ./dependencies/usr/ /usr/
   
echo '/usr/lib/' > /etc/ld.so.conf.d/opencv.conf
ldconfig -v