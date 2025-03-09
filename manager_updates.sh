#!/bin/bash

echo "Selecione uma opção:"
echo "1 - Desativar atualizações automáticas"
echo "2 - Ativar atualizações automáticas"
read -p "Digite o número da opção desejada: " escolha

if [ "$escolha" == "1" ]; then
    echo "Desativando atualizações automáticas..."

    sudo bash -c 'echo -e "APT::Periodic::Update-Package-Lists \"0\";\nAPT::Periodic::Unattended-Upgrade \"0\";" > /etc/apt/apt.conf.d/20auto-upgrades'
    sudo systemctl stop unattended-upgrades
    sudo systemctl disable unattended-upgrades
    sudo systemctl mask apt-daily.service apt-daily.timer apt-daily-upgrade.timer apt-daily-upgrade.service
    echo "Atualizações automáticas desativadas com sucesso!"

elif [ "$escolha" == "2" ]; then
    echo "Ativando atualizações automáticas..."

    sudo bash -c 'echo -e "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/20auto-upgrades'
    sudo systemctl unmask apt-daily.service apt-daily.timer apt-daily-upgrade.timer apt-daily-upgrade.service
    sudo systemctl enable unattended-upgrades
    sudo systemctl start unattended-upgrades
    echo "Atualizações automáticas ativadas com sucesso!"
else
    echo "Opção inválida. Execute o script novamente e escolha 1 ou 2."
fi
