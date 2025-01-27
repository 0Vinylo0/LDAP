#!/bin/bash

# Solicitar las variables configurables al usuario
echo "Por favor, introduce el dominio (por ejemplo, example.com):"
read -r DOMAIN
echo "Por favor, introduce el hostname (por ejemplo, ldap-server):"
read -r HOSTNAME

# Derivar BASE_DN del dominio
BASE_DN=$(echo "$DOMAIN" | sed 's/\./,dc=/g; s/^/dc=/')

# Actualización del sistema
echo "Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y

# Instalación de slapd y ldap-utils
echo "Instalando slapd y ldap-utils..."
sudo apt install slapd ldap-utils -y

# Configuración de slapd (interactiva)
echo "Reconfigurando slapd de manera interactiva..."
sudo dpkg-reconfigure slapd

# Verificar el estado de slapd
echo "Verificando que slapd esté corriendo..."
sudo systemctl status slapd | grep Active

# Realizar una búsqueda de prueba en LDAP
echo "Realizando prueba con ldapsearch..."
ldapsearch -x -LLL -H ldap:/// -b "$BASE_DN"

# Configurar el hostname
echo "Configurando el hostname..."
echo "$HOSTNAME" | sudo tee /etc/hostname
sudo sed -i "s/127.0.0.1.*/127.0.0.1   localhost $HOSTNAME/" /etc/hosts

# Reiniciar el servicio de hostname
echo "Reiniciando hostname..."
sudo systemctl restart systemd-logind

# Mostrar el hostname actual
echo "Hostname configurado como: $(hostname)"

# Finalización
echo "Instalación y configuración completadas. Verifica manualmente si es necesario realizar ajustes adicionales."