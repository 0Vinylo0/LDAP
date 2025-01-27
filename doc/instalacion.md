# Instalación de LDAP

En esta sección aprenderás a instalar y configurar un servidor LDAP desde cero utilizando OpenLDAP, una de las implementaciones más populares y ampliamente utilizadas. Este tutorial está diseñado para sistemas basados en Linux.

## Requisitos Previos

Antes de comenzar, asegúrate de tener lo siguiente:

- Un servidor Linux (Ubuntu/Debian, CentOS/RHEL u otra distribución).
- Acceso a una cuenta de usuario con privilegios de superusuario (root).
- Conexión a Internet para descargar paquetes.

## Instalación en Ubuntu/Debian

1. **Actualizar el Sistema**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Instalar OpenLDAP y Utilidades Asociadas**
   ```bash
   sudo apt install slapd ldap-utils -y
   ```

3. **Configurar OpenLDAP**
   Durante la instalación, se te pedirá configurar una contraseña de administrador para el directorio LDAP. Si no aparece el asistente, puedes ejecutarlo manualmente:
   ```bash
   sudo dpkg-reconfigure slapd
   ```
   Sigue las instrucciones y proporciona los datos necesarios:
   - **Omitir configuración de base de datos inicial**: No.
   - **Nombre del dominio**: Ejemplo: `empresa.com`.
   - **Organización**: Ejemplo: `MiEmpresa`.
   - **Contraseña del administrador**: Establece una contraseña segura.

4. **Verificar el Estado del Servicio**
   Asegúrate de que el servicio LDAP esté activo:
   ```bash
   sudo systemctl status slapd
   ```

5. **Probar la Conexión**
   Usa el comando `ldapsearch` para realizar una consulta básica:
   ```bash
   ldapsearch -x -LLL -H ldap:/// -b dc=empresa,dc=com
   ```
   Esto debería devolver información básica del directorio.

## Instalación en CentOS/RHEL

1. **Actualizar el Sistema**
   ```bash
   sudo yum update -y
   ```

2. **Instalar OpenLDAP y Herramientas Relacionadas**
   ```bash
   sudo yum install openldap openldap-servers openldap-clients -y
   ```

3. **Iniciar y Habilitar el Servicio**
   ```bash
   sudo systemctl start slapd
   sudo systemctl enable slapd
   ```

4. **Configurar OpenLDAP**
   Genera una contraseña para el administrador LDAP:
   ```bash
   slappasswd
   ```
   Copia la contraseña generada y configúrala en el archivo `/etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif`.

5. **Abrir el Puerto LDAP en el Firewall**
   ```bash
   sudo firewall-cmd --add-service=ldap --permanent
   sudo firewall-cmd --reload
   ```

6. **Probar la Conexión**
   Realiza una búsqueda simple para comprobar que el servidor está operativo:
   ```bash
   ldapsearch -x -LLL -H ldap:/// -b dc=empresa,dc=com
   ```

## Configuración Adicional

Para configuraciones más avanzadas como TLS/SSL, esquemas personalizados o replicación, consulta la sección de [Configuración Avanzada de LDAP](./configuracion_avanzada.md).

## Resolución de Problemas

- **El servicio LDAP no se inicia**: Verifica los registros del sistema en `/var/log/syslog` o `/var/log/messages`.
- **Fallo en la conexión**: Asegúrate de que el puerto 389 (LDAP) o 636 (LDAPS) esté abierto y accesible.
- **Problemas de autenticación**: Confirma que las credenciales del administrador son correctas.

Con esta guía, deberías tener un servidor LDAP funcional listo para configuraciones más avanzadas.
