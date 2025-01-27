# Configuración Básica de LDAP

Una vez instalado el servidor LDAP, es necesario configurarlo para adaptarlo a las necesidades específicas de tu organización. En esta sección, aprenderás a realizar configuraciones básicas, como agregar entradas iniciales, definir unidades organizativas y gestionar esquemas.

## 1. Agregar Entradas Iniciales

El primer paso es crear la estructura básica del árbol de directorios. Esto incluye dominios, unidades organizativas y usuarios.

### Crear un Archivo LDIF

Un archivo LDIF (LDAP Data Interchange Format) contiene las definiciones de las entradas que deseas agregar al directorio. A continuación, un ejemplo:

```ldif
dn: dc=empresa,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: MiEmpresa
dc: empresa

# Unidad Organizativa para Usuarios
dn: ou=Usuarios,dc=empresa,dc=com
objectClass: top
objectClass: organizationalUnit
ou: Usuarios

# Unidad Organizativa para Grupos
dn: ou=Grupos,dc=empresa,dc=com
objectClass: top
objectClass: organizationalUnit
ou: Grupos
```

### Cargar el Archivo LDIF

Utiliza el comando `ldapadd` para cargar el archivo LDIF en el servidor LDAP:

```bash
ldapadd -x -D "cn=admin,dc=empresa,dc=com" -W -f archivo.ldif
```

- `-x`: Usa autenticación simple.
- `-D`: Especifica el DN del usuario administrador.
- `-W`: Solicita la contraseña del administrador.
- `-f`: Indica el archivo LDIF a cargar.

## 2. Agregar Usuarios y Grupos

### Ejemplo de Usuario

El siguiente ejemplo muestra cómo agregar un usuario al directorio:

```ldif
dn: uid=jdoe,ou=Usuarios,dc=empresa,dc=com
objectClass: inetOrgPerson
sn: Doe
givenName: John
uid: jdoe
mail: jdoe@empresa.com
userPassword: {SSHA}contraseña_encriptada
```

Cargarlo en el servidor LDAP:

```bash
ldapadd -x -D "cn=admin,dc=empresa,dc=com" -W -f usuario.ldif
```

### Ejemplo de Grupo

Un grupo puede definirse de la siguiente manera:

```ldif
dn: cn=Admins,ou=Grupos,dc=empresa,dc=com
objectClass: top
objectClass: posixGroup
gidNumber: 5000
memberUid: jdoe
```

Cargar el archivo:

```bash
ldapadd -x -D "cn=admin,dc=empresa,dc=com" -W -f grupo.ldif
```

## 3. Modificar Entradas Existentes

Para modificar entradas en el directorio, utiliza el comando `ldapmodify`. Por ejemplo, para cambiar el correo electrónico de un usuario:

```ldif
dn: uid=jdoe,ou=Usuarios,dc=empresa,dc=com
changetype: modify
replace: mail
mail: nuevo_correo@empresa.com
```

Cargar el archivo:

```bash
ldapmodify -x -D "cn=admin,dc=empresa,dc=com" -W -f modificar.ldif
```

## 4. Borrar Entradas

Para eliminar una entrada, utiliza el comando `ldapdelete`:

```bash
ldapdelete -x -D "cn=admin,dc=empresa,dc=com" -W "uid=jdoe,ou=Usuarios,dc=empresa,dc=com"
```

## 5. Verificar la Estructura del Directorio

Usa `ldapsearch` para verificar la estructura del directorio y asegurarte de que las entradas se han agregado correctamente:

```bash
ldapsearch -x -LLL -H ldap:/// -b dc=empresa,dc=com
```

## Próximos Pasos

Con esta configuración básica, tu servidor LDAP ya está listo para manejar usuarios y grupos. Para configuraciones más avanzadas, como la autenticación TLS/SSL o la replicación, consulta la sección de [Configuración Avanzada de LDAP](./configuracion_avanzada.md).
