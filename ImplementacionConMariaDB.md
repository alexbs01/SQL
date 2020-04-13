# Implantación de dos BD con MariaDB

## Índice

- [Base de datos número 1: Proxectos de investigación](#Proxectos-de-investigación)
- [Base de datos número 2: Naves espaciais](#Naves-espaciais)
- [Formas de ver la estructura de la BD](#Formas-de-ver-la-estructura-de-la-BD)

Tras las exlicaciones de DDL y DML poniendo un ejemplo de la creación de una base de datos en ElephantSQL, ahora toca la implementación de otras dos bases de datos en MariaSQL que ya enseñé como instalarlo de forma local a través de la línea de comandos en Ubuntu.  

Tras documentarme me di cuenta de que **en MariaSQL no existe lo que en ElephantSQL se denomina "dominio"**, por lo que en este SGBD tendremos que poner el dominio de los atributos constantemente sin poder usar una "variable". Y también a las sentencias válidas para la creación de la base de datos les puse una línea blanca para marcar que están bien hechas.  

## Proxectos de investigación

[Esquema de la base de datos](https://github.com/davidgchaves/first-steps-with-git-and-github-wirtz-asir1-and-dam1/tree/master/exercicios-ddl/1-proxectos-de-investigacion)  
Primero crearemos la base de datos con ```CREATE SCHEMA ProxectosInvestigacion;``` y posteriormente, entrar en la BD con ```USE ProxectosInvestigacion``` o en lugar de USE usar lo que se ve en la imagen **\u**. También hay que aclarar que para está base de datos decidí crear todas las tablas primero sin ninguna propagación de clave foránea, y después cuando estén todas las tablas ya creadas, crearé las interrelaciones alterando la tabla con **ALTER**.

![CreacionYUsoBD](./img/31/1.PNG)

Crearemos las tablas **ubicación** y **grupo**.  
![CreacionUbicacionYGrupo](./img/31/2.PNG)

Después **profesor**.  
![CreacionProfesor](./img/31/3.PNG)

Luego, corrigiendo un fallo que tuve crearemos **proxecto**.  
![CorreccionProxecto](./img/31/4.PNG)

A continuación **pariticipa** y **proxecto**.  
![CreacionParticipaYPrograma](./img/31/5.PNG)

Después, volviendo a tener otro error al escribir los valores, creamos la tabla **financia**.  
![CorreccionFinancia](./img/31/6.PNG)

Y a partir de aquí comenzaremos con las alteraciones de las tablas para crear las interrelaciones, comenzaremos con las tablas **ubicación**, y **grupo**.  
![AlteracionUbicacionYGrupo](./img/31/8.PNG)

Despueés alteramos **profesor** y **proxecto**.  
![AlteracionProfesorYProxecto](./img/31/9.PNG)

Luego **departamento**, **grupo** y **participa**.  
![AlteracionDepartamentoGrupoYParticipa](./img/31/10.PNG)

Volvemos alterar **participa**.  
![AlteracionParticipa](./img/31/11.PNG)

Y por último alteramos **financia** y ya tenemos la base de datos con la implementación terminada.  
![AlteracionFinancia](./img/31/12.PNG)  

## Naves espaciais

[Esquema de la base de datos](https://github.com/davidgchaves/first-steps-with-git-and-github-wirtz-asir1-and-dam1/tree/master/exercicios-ddl/2-naves-espaciais)  
Y para la creación de esta base de datos, lo haremos sin marcar ninguna CONSTRAINT y procurando siempre que sea posible hacer la interrelación entre tablas a la vez que creemos la tabla en cuestión.  

Aquí comenzaremos iniciando el programa, creando la base de datos, usandola con ```USE <nombreDeLaBD>;``` y creando la primera tabla con el nombre de **servizo**.  
![CreacionYUsoDeLaBD](./img/32/1.PNG)

A continuación crearemos **dependenia**.  
![CreacionDepenpendencia](./img/32/2.PNG)

Luego **cámara**.  
![CreacionCamara](./img/32/3.PNG)

Después crearemos **tripulación** y la alteraremos porque se me olvidó hacer una interrelación.  
![CreacionYAlteracionTripulacion](./img/32/4.PNG)

Corregiremos el fallo que tuve a la hora de escribir la tabla **planeta** y crearemos también la tabla **visita**.  
![CreacionPlanetaisita](./img/32/5.PNG)

Ahora craremos las tablas **habita** y **raza**.  
![CreacionHabitaRaza](./img/32/6.PNG)

Y por último, alteraremos la tabla raza porque se me olvidó asignarle una clave primaria, luego la interrelación con habita, que antes dio un error porque no tenía establecida la clave primaria de a tabla **raza**.  
![AlteracionRazaHabitaYCamara](./img/32/7.PNG)

# Formas de ver la estructura de la BD

Para ver que bases de datos tienes creadas hay que escribir ```SHOW DATABASES;``` y mostrarán todas las bases de datos que tenemos creadas. También aparecerán dos que contienen información sobre MariaSQL.  
![SHOW DATABASE](./img/EstructuraSimulandoGUI/1.PNG)

Para ver la tablas que hay dentro de una base de datos deberemos situarnos dentro de la bases de datos con ```USE <nombreDeLaBD>;``` y después escribir ```SHOW TABLES;``` para ver todas las tablas que hay escritas.  
![SHOW TABLES](./img/EstructuraSimulandoGUI/2.PNG)

Para ver las columnas y características de una tabla de la base de datos tendremo que escribir ```SHOW COLUMNS FROM <nombreDeLaTabla>```.  
![SHOW COLUMNS FROM](./img/EstructuraSimulandoGUI/3.PNG)

Y para ver como está formada una tabla a nivel de código tendremos que ejecutar la siguiente sentencia, ```SHOW CREATE TABLE <nombreDeLaTabla>;```.  
![SHOW CREATE TABLE](./img/EstructuraSimulandoGUI/4_ShowCreateTableProfesor.PNG)



























