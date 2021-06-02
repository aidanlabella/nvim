mkdir -p ~/dev
sudo cp ../bin/jdtls-setup /usr/local/bin
git clone https://github.com/eclipse/eclipse.jdt.ls.git ~/dev
cd ~/dev/eclipse.jdt.ls
./mvnw clean verify
