# Configuración Avanzada de LDAP

En esta sección exploraremos configuraciones avanzadas para LDAP, incluyendo el uso de TLS/SSL, esquemas personalizados, replicación y optimización del rendimiento. Estas configuraciones son ideales para entornos de producción o necesidades específicas de seguridad y escalabilidad.

## 1. Configurar TLS/SSL para LDAP

La comunicación segura es esencial en cualquier implementación de LDAP. TLS/SSL protege los datos transmitidos entre el cliente y el servidor.

### Generar Certificados TLS

1. **Crear una clave privada y un certificado autofirmado:**
   ```bash
   sudo mkdir /etc/ssl/ldap
   sudo openssl req -new -x509 -nodes -out /etc/ssl/ldap/ldap.pem -keyout /etc/ssl/ldap/ldap.key -days 365
   ```

2. **Asegurar los permisos de los archivos:**
   ```bash
   sudo chmod 600 /etc/ssl/ldap/ldap.key
   sudo chown openldap:openldap /etc/ssl/ldap/*
   ```

### Configurar OpenLDAP para Usar TLS

1. Edita la configuración TLS usando `ldapmodify`:
   ```bash
   ldapmodify -Y EXTERNAL -H ldapi:/// <<EOF
   dn: cn=config
   changetype: modify
   replace: olcTLSCertificateFile
   olcTLSCertificateFile: /etc/ssl/ldap/ldap.pem
   -
   replace: olcTLSCertificateKeyFile
   olcTLSCertificateKeyFile: /etc/ssl/ldap/ldap.key
   EOF
   ```

2. Reinicia el servicio LDAP para aplicar los cambios:
   ```bash
   sudo systemctl restart slapd
   ```

### Probar la Conexión Segura

Usa el comando `ldapsearch` para verificar la conexión mediante TLS:
   ```bash
   ldapsearch -H ldaps://ldap.empresa.com -b dc=empresa,dc=com -D "cn=admin,dc=empresa,dc=com" -W
   ```

---

## 2. Agregar Esquemas Personalizados

Los esquemas permiten extender las capacidades de LDAP añadiendo nuevos tipos de objetos y atributos.

### Ejemplo: Agregar el Esquema `inetorgperson`

1. Cargar el esquema usando `ldapadd`:
   ```bash
   ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif
   ```

2. Verificar que el esquema esté habilitado:
   ```bash
   ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=schema,cn=config
   ```

### Crear Esquemas Personalizados

Si necesitas un esquema específico, puedes crearlo manualmente como un archivo LDIF. Ejemplo:

```ldif
dn: cn=miEsquema,cn=schema,cn=config
objectClass: olcSchemaConfig
cn: miEsquema
olcAttributeTypes: ( 1.1.1 NAME 'miAtributo' DESC 'Atributo Personalizado' EQUALITY caseIgnoreMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
olcObjectClasses: ( 1.1.2 NAME 'miObjeto' DESC 'Objeto Personalizado' SUP top STRUCTURAL MUST ( miAtributo ) )
```

Cargarlo en el servidor:
```bash
ldapadd -Y EXTERNAL -H ldapi:/// -f esquema_personalizado.ldif
```

---

## 3. Configurar Replicación

La replicación asegura la disponibilidad y consistencia de los datos entre múltiples servidores LDAP.

### Configuración Maestro-Esclavo

1. **Configurar el Servidor Maestro:**
   Agregar las siguientes configuraciones al archivo `slapd.d` en el maestro:

   ```ldif
   dn: olcDatabase={1}mdb,cn=config
   changetype: modify
   add: olcSyncRepl
   olcSyncRepl: rid=001 provider=ldap://ldap-maestro.empresa.com bindmethod=simple binddn="cn=admin,dc=empresa,dc=com" credentials=contraseña searchbase="dc=empresa,dc=com" type=refreshAndPersist retry="60 +"
   ```

2. **Configurar el Servidor Esclavo:**
   Asegúrate de que el esclavo tenga la misma configuración de base de datos y habilita la sincronización.

3. **Probar la Replicación:**
   Modifica una entrada en el maestro y verifica que los cambios se reflejen en el esclavo.

---

## 4. Optimización del Rendimiento

- **Habilitar Caché:** Ajusta los parámetros de caché en la base de datos para mejorar la velocidad de consultas.
- **Índices de Atributos:** Define índices para atributos utilizados frecuentemente:
  ```ldif
  dn: olcDatabase={1}mdb,cn=config
  changetype: modify
  add: olcDbIndex
  olcDbIndex: mail eq
  olcDbIndex: uid eq
  ```

---

Con estas configuraciones avanzadas, tu servidor LDAP estará preparado para manejar entornos exigentes con altos estándares de seguridad y disponibilidad. Para más personalizaciones, consulta la documentación oficial de OpenLDAP o solicita ayuda adicional.
