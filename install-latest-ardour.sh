#!/bin/sh

# Ref: https://interfacinglinux.com/2024/03/05/compiling-ardour-8-on-debian-12/

sudo apt install build-essential git libboost-all-dev gcc g++ pkg-config libasound2-dev libgtk2.0-dev libglibmm-2.4-dev libsndfile1-dev libarchive-dev liblo-dev libtag1-dev vamp-plugin-sdk librubberband-dev libfftw3-dev libaubio-dev libxml2-dev libsamplerate0-dev lv2-dev libserd-dev libsord-dev libsratom-dev liblilv-dev libgtkmm-2.4-dev libjack-jackd2-dev libogg-dev libcppunit-dev libudev-dev libwebsockets-dev libusb-dev libsuil-dev libdbus-1-dev xjadeo libusb-1.0-0-dev libreadline-dev  libarchive-dev liblo-dev libtag1-dev libvamp-sdk2v5 librubberband-dev libaubio-dev libpangomm-1.4-dev libserd-dev libsord-dev libsratom-dev liblilv-dev libgtkmm-2.4-dev libsuil-dev libcppunit-dev python3 liblrdf0-dev libraptor2-dev python-is-python3 && \

# Clone and compile ardour
git clone https://github.com/Ardour/ardour.git && \
cd ardour && \
git checkout 8.4 && \
./waf configure --cxx11 --optimize && \
./waf -j `nproc` && \


# Install ardour
sudo ./waf install && \

# Place the ardour installation in Applications Menu
sudo echo "[Desktop Entry]
Version=1.0
Name=Ardour8
GenericName=Ardour Digital Audio Workstation 8
Comment=Record, mix and master multi-track audio
GenericName[fr]=Station de travail audionumérique Ardour 8
Comment[fr]=Enregistrer, mixer et mastériser de l'audio multi-piste 
Keywords=audio;sound;jackd,DAW,multitrack,ladspa,lv2,midi
Exec=/usr/local/bin/ardour8 %f
Icon=ardour
Terminal=false
Type=Application
Categories=AudioVideo;X-AudioEditing;Audio;Recorder;
MimeType=application/x-ardour;
" > /usr/share/applications/ardour8.desktop && \

# Remove the cloned repository
cd .. && \
rm -rf ardour && \

echo "[*] Ardour 8 installed successfully !!"
