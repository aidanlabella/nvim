mkdir -p ~/dev/eclipse.jdt.ls
sudo cp ../bin/jdtls-setup /usr/local/bin
git clone https://github.com/eclipse/eclipse.jdt.ls.git ~/dev/eclipse.jdt.ls
cd ~/dev/eclipse.jdt.ls
./mvnw clean verify
