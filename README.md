# LDAP

¡Bienvenido al repositorio de documentación de LDAP! Esta guía ofrece una introducción completa a LDAP, detallando su funcionalidad, casos de uso y proceso de instalación. Cada sección está organizada en archivos separados para facilitar la navegación.

## Tabla de Contenidos

<img src="/img/OpenLDAP.png" alt="GIF" width="200" height="150" align="right">

1. [`Introducción a LDAP`](/doc/introduccion.md)
2. [`Instalación de LDAP`](/doc/instalacion.md)
3. [`Conceptos Básicos de Configuración de LDAP`](/doc/configuracion.md)
4. [`Configuracion avanzada`](/doc/configuracion_avanzada.md)
5. [`Comandos Comunes de LDAP`](/doc/comandos.md)
6. [`Casos de Uso y Mejores Prácticas`](/doc/casos_de_uso.md)
7. [`Estructura del Árbol LDAP`](/doc/arbol_ldap.md)

---

## ¿Qué es LDAP?

LDAP (Protocolo Ligero de Acceso a Directorios, por sus siglas en inglés) es un protocolo abierto y neutral que se utiliza para acceder y gestionar servicios de información de directorios. Se usa comúnmente para:

- Autenticación y autorización centralizadas.
- Gestión de información de usuarios y recursos.
- Servicios de directorios como Active Directory, OpenLDAP, entre otros.

### Características Clave
- **Escalabilidad**: LDAP está diseñado para manejar una gran cantidad de entradas de manera eficiente.
- **Interoperabilidad**: Es compatible con múltiples plataformas y lenguajes de programación.
- **Estructura Jerárquica**: Organiza los datos en un formato de árbol, lo que facilita su navegación y gestión.

### ¿Cómo Funciona LDAP?
LDAP organiza los datos en una estructura de directorio. Cada entrada está identificada de manera única por un Nombre Distinguido (DN, por sus siglas en inglés) y los atributos describen los datos en detalle. LDAP utiliza un modelo cliente-servidor donde:

1. Los clientes envían solicitudes (por ejemplo, búsqueda, modificación) al servidor LDAP.
2. El servidor procesa estas solicitudes y responde en consecuencia.

---

### Próximos Pasos

Comienza leyendo la [`Introducción a LDAP`](/doc/introduccion.md) para entender sus conceptos fundamentales. Luego, procede a la [`Guía de Instalación`](/doc/instalacion.md) para configurar un servidor LDAP en tu sistema. También puedes explorar la [`Estructura del Árbol LDAP`](/doc/arbol_ldap.md) para comprender cómo se organiza y gestiona la información dentro de LDAP.

## Referencias
- [`OpenLDAP`](https://www.openldap.org/doc/)
