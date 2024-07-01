sudo apt-get update
sudo apt-get install -y build-essential autoconf automake libtool pkg-config \
                     libssl-dev libcurl4-openssl-dev libxml2-dev zlib1g-dev \
                     python3-dev git cmake
git clone https://github.com/hybridgroup/gocv.git
cd ./gocv/
make install
