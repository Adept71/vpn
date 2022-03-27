#!/bin/bash

echo -e '\e[40m\e[91m'
echo -e '  ____                  _                    '
echo -e ' / ___|_ __ _   _ _ __ | |_ ___  _ __        '
echo -e '| |   |  __| | | |  _ \| __/ _ \|  _ \       '
echo -e '| |___| |  | |_| | |_) | || (_) | | | |      '
echo -e ' \____|_|   \__  |  __/ \__\___/|_| |_|      '
echo -e '            |___/|_|                         '
echo -e '\e[0m'

sleep 2

echo -e '\n\e[42mChecking profiles quantity\e[0m\n' && sleep 2

function checkLast { 
  cat /etc/wireguard/wg0.conf | tail -1 | grep -oP '(?<='10.0.0.').*' | grep -o '^[^/]*'
}

function checkNTLast {
  echo $(cat /etc/wireguard/wg0.conf | tail -1 | grep -oP '(?<='10.0.').*' | grep -o '^[^'.checkLast']*')
}

function checkNNTLast {
  cat /etc/wireguard/wg0.conf | tail -1 | grep -oP '(?<='10.').*' | grep -o '^[^'.checkNTLast']*'
}

checkLast="$(checkLast)"
checkNTLast="$(checkNTLast)"
checkNNTLast="$(checkNNTLast)"
  
if (( $checkLast <= 244 )); then
echo -e '\n\e[42mGenerating keys for confings\e[0m\n' && sleep 2
for ACC_NUM in $( eval echo {$(($checkLast+1))..$(($checkLast+11))})
do

wg genkey | tee /etc/wireguard/$ACC_NUM'_last_private' | wg pubkey | tee /etc/wireguard/$ACC_NUM'_last_public'
sudo tee -a /etc/wireguard/wg0.conf > /dev/null <<EOF

[Peer]
PublicKey = $(cat /etc/wireguard/$ACC_NUM'_last_public')
AllowedIPs = 10.0.0.$ACC_NUM/32
EOF

systemctl restart wg-quick@wg0.service && sleep 2
done

        echo -e '\n\e[42m==================================================\e[0m\n'
        echo -e '\n\e[42mSAVE ALL DATA BELOW\e[0m\n' && sleep 2
        echo -e '\n\e[42m==================================================\e[0m\n'

for ACC_NUM in $( eval echo {$(($checkLast+1))..$(($checkLast+11))})
do

echo "
[Interface]
PrivateKey = $(cat /etc/wireguard/$ACC_NUM'_last_private')
Address = 10.0.0.$ACC_NUM/32
DNS = 8.8.8.8

[Peer]
PublicKey = $(cat /etc/wireguard/publickey)
Endpoint = $(wget -qO- eth0.me):51820
AllowedIPs = 0.0.0.0/0  
PersistentKeepalive = 20" 
echo -e "\n\e[42m###################################\e[0m\n"           
done

      echo -e '\n\e[42m==================================================\e[0m\n'
      echo -e '\n\e[42mSAVE ALL DATA ABOVE\e[0m\n' && sleep 2
      echo -e '\n\e[42m==================================================\e[0m\n'




elif (( $checkNTLast <= 244 )); then
echo -e '\n\e[42mGenerating keys for confings\e[0m\n' && sleep 2
for ACC_NUM in $( eval echo {$(($checkNTLast+1))..$(($checkNTLast+11))})
do

wg genkey | tee /etc/wireguard/$ACC_NUM'_ntlast_private' | wg pubkey | tee /etc/wireguard/$ACC_NUM'_ntlast_public'
sudo tee -a /etc/wireguard/wg0.conf > /dev/null <<EOF

[Peer]
PublicKey = $(cat /etc/wireguard/$ACC_NUM'_ntlast_public')
AllowedIPs = 10.0.$ACC_NUM.$checkLast/32
EOF

systemctl restart wg-quick@wg0.service && sleep 2
done

        echo -e '\n\e[42m==================================================\e[0m\n'
        echo -e '\n\e[42mSAVE ALL DATA BELOW\e[0m\n' && sleep 2
        echo -e '\n\e[42m==================================================\e[0m\n'

for ACC_NUM in $( eval echo {$(($checkNTLast+1))..$(($checkNTLast+11))})
do

echo "
[Interface]
PrivateKey = $(cat /etc/wireguard/$ACC_NUM'_ntlast_private')
Address = 10.0.$ACC_NUM.$checkLast/32
DNS = 8.8.8.8

[Peer]
PublicKey = $(cat /etc/wireguard/publickey)
Endpoint = $(wget -qO- eth0.me):51820
AllowedIPs = 0.0.0.0/0  
PersistentKeepalive = 20" 
echo -e "\n\e[42m###################################\e[0m\n"           
done

      echo -e '\n\e[42m==================================================\e[0m\n'
      echo -e '\n\e[42mSAVE ALL DATA ABOVE\e[0m\n' && sleep 2
      echo -e '\n\e[42m==================================================\e[0m\n'
    
elif (( $checkNNTLast <= 244 )); then
echo -e '\n\e[42mGenerating keys for confings\e[0m\n' && sleep 2
for ACC_NUM in $( eval echo {$(($checkNNTLast+1))..$(($checkNNTLast+11))})
do

wg genkey | tee /etc/wireguard/$ACC_NUM'_nntlast_private' | wg pubkey | tee /etc/wireguard/$ACC_NUM'_nntlast_public'
sudo tee -a /etc/wireguard/wg0.conf > /dev/null <<EOF

[Peer]
PublicKey = $(cat /etc/wireguard/$ACC_NUM'_nntlast_public')
AllowedIPs = 10.$ACC_NUM.$checkNTLast.$checkLast/32
EOF

systemctl restart wg-quick@wg0.service && sleep 2
done

        echo -e '\n\e[42m==================================================\e[0m\n'
        echo -e '\n\e[42mSAVE ALL DATA BELOW\e[0m\n' && sleep 2
        echo -e '\n\e[42m==================================================\e[0m\n'

for ACC_NUM in $( eval echo {$(($checkNNTLast+1))..$(($checkNNTLast+11))})
do

echo "
[Interface]
PrivateKey = $(cat /etc/wireguard/$ACC_NUM'_nntlast_private')
Address = 10.$ACC_NUM.$checkNTLast.$checkLast/32
DNS = 8.8.8.8

[Peer]
PublicKey = $(cat /etc/wireguard/publickey)
Endpoint = $(wget -qO- eth0.me):51820
AllowedIPs = 0.0.0.0/0  
PersistentKeepalive = 20" 
echo -e "\n\e[42m###################################\e[0m\n"           
done

      echo -e '\n\e[42m==================================================\e[0m\n'
      echo -e '\n\e[42mSAVE ALL DATA ABOVE\e[0m\n' && sleep 2
      echo -e '\n\e[42m==================================================\e[0m\n'
  
else
  echo -e '\n\e[41m\e[30mNo more configs can be generated\e[0m\n' && sleep 2
fi



