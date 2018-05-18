#!/bin/bash
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get install -y nano htop git && sudo apt-get install -y software-properties-common && sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev && sudo apt-get install -y libboost-all-dev && sudo apt-get install -y libevent-dev && sudo apt-get install -y libminiupnpc-dev && sudo apt-get install -y autoconf && sudo apt-get install -y automake unzip && sudo add-apt-repository  -y  ppa:bitcoin/bitcoin && sudo apt-get update && sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

echo "################################################"
echo "#   Welcome to PAC Masternode's server setup   #"		
echo "################################################"
echo "" 
read -p 'Please provide the external IP: ' ipaddr
read -p 'Please provide masternode genkey: ' mnkey

while [[ $ipaddr = '' ]] || [[ $ipaddr = ' ' ]]; do
	read -p 'You did not provided an external IP, please provide one: ' ipaddr
	sleep 2
done

while [[ $mnkey = '' ]] || [[ $mnkey = ' ' ]]; do
	read -p 'You did not provided masternode genkey, please provide one: ' mnkey
	sleep 2
done

git clone https://github.com/coinsapu/Sparks
cd Sparks
chmod 500 Sparksnewd
chmod 500 Sparks-cli
chmod 500 Sparks-tx
strip Sparks-tx
strip Sparks-cli
strip Sparksnewd
mv Sparksnewd Sparks-cli Sparks-tx ~/
cd

rm -r Sparks

echo "Creating .Sparks dir"
mkdir -p ~/.Sparks
cd ~/.Sparks
touch Sparks.conf

fi

echo "rpcuser=randomusername" >> Sparks.conf
echo "rpcpassword=randompass" >> Sparks.conf
echo "rpcallowip=127.0.0.1" >> Sparks.conf
echo "rpcport=8818" >> Sparks.conf
echo "printtodebuglog=0" >> Sparks.conf
echo "listen=1" >> Sparks.conf
echo "server=1" >> Sparks.conf
echo "daemon=1" >> Sparks.conf
echo "logtimestamps=1" >> Sparks.conf
echo "maxconnections=256" >> Sparks.conf
echo "masternode=1" >> Sparks.conf
echo "externalip=$ipaddr" >> Sparks.conf
echo "masternodeprivkey=$mnkey" >> Sparks.conf

echo "###############################"
echo "#      Running the wallet     #"		
echo "###############################"
echo ""
cd ~/

./Sparksnewd
sleep 60

cd ~/
./paccoin-cli getinfo

