# Comandos Comunes de LDAP

Esta guía contiene una lista de comandos básicos y avanzados de LDAP, junto con ejemplos prácticos para gestionar y consultar el servidor LDAP.

## 1. Comandos Básicos

### Búsqueda en el Directorio
Consulta entradas en el directorio LDAP usando `ldapsearch`:
```bash
ldapsearch -x -LLL -H ldap:// -b "dc=empresa,dc=com"
```
- `-x`: Utiliza autenticación simple.
- `-LLL`: Formatea la salida sin encabezados innecesarios.
- `-H`: Especifica la URL del servidor LDAP.
- `-b`: Define la base de búsqueda.

Ejemplo:
```bash
ldapsearch -x -LLL -H ldap://ldap.empresa.com -b "dc=empresa,dc=com" "uid=jdoe"
```

### Añadir Entradas
Añade una nueva entrada al directorio usando `ldapadd`:
```bash
ldapadd -x -D "cn=admin,dc=empresa,dc=com" -W -f nueva_entrada.ldif
```
- `-D`: DN del usuario administrador.
- `-W`: Solicita la contraseña.
- `-f`: Archivo LDIF con la entrada a agregar.

Ejemplo de archivo LDIF:
```ldif
dn: uid=jdoe,ou=Usuarios,dc=empresa,dc=com
objectClass: inetOrgPerson
sn: Doe
givenName: John
uid: jdoe
mail: jdoe@empresa.com
userPassword: {SSHA}contraseña_encriptada
```

### Modificar Entradas
Usa `ldapmodify` para cambiar atributos existentes:
```bash
ldapmodify -x -D "cn=admin,dc=empresa,dc=com" -W -f modificar.ldif
```
Ejemplo de archivo LDIF:
```ldif
dn: uid=jdoe,ou=Usuarios,dc=empresa,dc=com
changetype: modify
replace: mail
mail: nuevo_correo@empresa.com
```

### Eliminar Entradas
Elimina una entrada del directorio con `ldapdelete`:
```bash
ldapdelete -x -D "cn=admin,dc=empresa,dc=com" -W "uid=jdoe,ou=Usuarios,dc=empresa,dc=com"
```

---

## 2. Comandos de Configuración

### Ver Configuración del Servidor
Consulta la configuración actual del servidor LDAP:
```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config
```

### Modificar Configuración del Servidor
Usa `ldapmodify` para cambiar configuraciones:
```bash
ldapmodify -Y EXTERNAL -H ldapi:/// <<EOF
dn: cn=config
changetype: modify
replace: olcLogLevel
olcLogLevel: stats
EOF
```

---

## 3. Comandos para Esquemas

### Listar Esquemas Disponibles
Consulta los esquemas cargados:
```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=schema,cn=config
```

### Agregar un Esquema
Cargar un esquema adicional:
```bash
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif
```

---

## 4. Comandos de Diagnóstico

### Probar la Conexión
Verifica si el servidor LDAP responde:
```bash
ldapsearch -x -H ldap://ldap.empresa.com -b "dc=empresa,dc=com" -s base
```

### Comprobar Índices
Consulta si los índices están activos:
```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b "olcDatabase={1}mdb,cn=config" olcDbIndex
```

---

Esta lista de comandos te ayudará a gestionar y diagnosticar tu servidor LDAP de manera efectiva. Para detalles adicionales, consulta la documentación oficial de OpenLDAP.
