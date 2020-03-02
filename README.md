# Apuntes de SQL de Bases de Datos

## Índice

- [Sublenguajes de SQL](#sublenguajes-de-sql)
- [Cosas a tener en cuenta](#cosas-a-tener-en-cuenta)
- [Consultas con DQL](#consultas-con-dql)
	- [Estructura básica de una sentencia SQL DQL](#estructura-básica-de-una-sentencia-sql-dql)
	- [Ejemplo práctico 1 (SELECT, FROM, WHERE)](#ejemplo-práctico-1)
	- [Ejemplo práctico 2 (IN)](#ejemplo-práctico-2)
	- [Ejemplo práctico 3 (AS, BETWEEN, ORDER BY)](#ejemplo-práctico-3)
	- [Ejemplos prácticos 4 (LIKE, *%*, *_*)](#ejemplos-prácticos-4)
	- [Ejemplo práctico 5 (REPLACE)](#ejemplo-práctico-5)
	- [Ejemplo práctico 6 (ROUND)](#ejemplo-práctico-6)
	- [Ejemplo práctico 7 (LENGTH)](#ejemplo-práctico-7)
	- [Ejemplo práctico 8(LEFT, RIGHT)](#ejemplo8-práctico-)
	- [Ejemplo práctico 9 (CONCAT)](#ejemplo-práctico-9)
	- [Ejemplos prácticos 10 (SUM, COUNT, MAX, MIN, AVG, GROUP BY, HAVING)](#ejemplos-prácticos-10)
	- [Ejemplo práctico 11 (JOIN, INNER JOIN)](#ejemplo-práctico-11)
	- [Ejemplo práctico 12(LEFT JOIN, RIGHT JOIN)](#Ejemplo-práctico-12)
- [El sublenguaje DDL](#el-sublenguaje-ddl)
	- [Estructura básica de una setencia DDL con CREATE](#estructura-básica-de-una-sentencia-ddl-con-create)
## Sublenguajes de SQL
En SQL existen seis sublenguajes que que se usan para hacer diferentes cosas, como crear bases de datos, tablas, consultas, modificarlas, hacer transactiones... Los nombres de cada uno son estos y también las setencias más importantes de cada uno.  

- DDL (Data Definition Language) --> CREATE, ALTER, DROP  
- DML (Data Manipulatin Lianguage) --> INSERT, UPDATE, DELETE  
- DCL (Data Control Language) --> GRANT, REVOKE, (AUDIT, COMMENT)  
- TCL (Transaction Control Language) --> COMMIT, ROLLBACK, (SAVEPOINT)  
- DQL (Data Query Language) --> SELECT
- SCL (Sesion Control Language) --> ALTER SESION

## Cosas a tener en cuenta

1. Los strings **siempre** van entre comillas simples.
2. Por conveinio las clausulas como SELECT, FROM, WHERE... **Van en mayúsculas**.
3. **Siempre se pone punto y coma al final.**
4. Los comentarios de una línea se hacen con -- y lo comentado irá después de los dos guiones.
5. Los comentarios multilínea se hacen con /* */ poniendo el código comentado entre los asteríscos.

# Consultas con DQL
## Estructura básica de una sentencia SQL DQL
```sql
SELECT objectName[, objectName2] 
FROM tableName 
[WHERE condition [AND || OR condition2]]
[GROUP BY objectName[, objectName_2]]
[HAVING condition3 [AND || OR contidition4]]
[ORDER BY objectName ASC || DESC];
```

## Ejemplo práctico 1

Selecciona la población de la tabla "world" donde el nombre del país es Alemania.

```sql
SELECT population
FROM world
WHERE name = 'Germany';
```

**SELECT**: Se usa para seleccionar que datos se deben mostrar en pantalla.  
**FROM**: Se usa para indicar en que tabla o tablas estan los atributos que escogimos con SELECT.  
**WHERE**: Se usa como filtro, en el caso de arriba descarta todos los países menos Alemania.  

## Ejemplo práctico 2

Selecciona el nombre y la población de la tabla "world" donde el nombre es o Suecia o Noruega o Dinamarca.

```sql
SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');
```

**IN**: Se usa en sustitución de OR. En vez de poner:  
 "name = 'Sweden' OR name = 'Norway' OR name = 'Denmark'"  
 se pone "IN ('Sweden', 'Norway', 'Denmark')" para abreviar.  

## Ejemplo práctico 3

Cambia "name" por nombre y selecciona el área de la tabla world. Donde el área está entre 200000 y 300000, y ordénalos por orden ascendente.  

```sql
SELECT name AS nombre, area
FROM world
WHERE area BETWEEN 200000 AND 300000
ORDER BY area ASC;
```

**x AS y**: Sirve para renombrar. Escoges un atributo *x*, y el nombre *y* que pongas después del "AS" sustituirá al nombre real.  
**BETWEEN x AND y**: Se usa para filtrar entre un valor "x" y un valor "y", además se incluyen los valores de los extremos.  
**ORDER BY**: Sirve para ordenar los datos mostrados de forma ascendente "ASC" o de forma descendente "DESC".  

## Ejemplos prácticos 4 

Selecciona todos los países de la tabla "world" donde el nombre de los países empieza por la letra "P".  

```sql
SELECT name 
FROM world
WHERE name LIKE 'P%';
```
-----

Selecciona todos los países de la tabla "world" donde el nombre de los países empiecen por "G" y además tengan cinco letras.  

```sql
SELECT name
FROM world
WHERE name LIKE 'G____';
```

**WHERE x LIKE 'y'**: Es una forma de buscar un patrón en el atributo indicado, para esto hay que tener en cuenta dos caracteres especiales.  
   1. **%**: Sustituye una cantidad de valores de entre 0 y n, siendo n un valor sin límite.  
   2. **_**(Guión bajo): Sustituye tantos carácteres como guiones bajos haya.  

También si quieres buscar un valor que tiene un carácter a mayores, como por ejemplo, 25%, habrá que poner "\" justo antes del porcentaje para escapar el símbolo, por lo que finalmente la consulta quedará de esta forma: WHERE number LIKE '25\%'.  

-----

El porcentaje y el guión bajo en SQL puestos después de un LIKE son expresiones regulares o RegEx (Regular Expresions) que sirven para ayudar a filtrar. Por ese motivo, para buscar patrones es necesaria la utilización del LIKE, ya que el símbolo de *=* sirve para buscar cadenas de texto fijas.  

```sql
SELECT name
FROM world
WHERE name = 'P%'
   OR name LIKE 'P%';
```
En la consulta de arriba se mostrarían todos los países que comienzan por "P", pero no por la primera línea del WHERE sino por la segunda, puesto que no existe ningún país que se llame "P%". Esta es la diferencia entre una cadena de texto exacta y una expresión regular.  

## Ejemplo práctico 5

Selecciona el nombre de la capital que tienen en el nombre "DF" y sustitúyelo para que ponga "Distrito Federal".  
 ```sql
SELECT capital
  REPLACE (capital, 'DF', 'Distrito Federal')
FROM world
WHERE name LIKE '%_DF';
```

**REPLACE (x, 'y', 'z')**: Sirve para reemlazar los carácteres "y" por los "z" en el atributo "z".  
En la sentencia de arriba en vez de aparecer "México DF" aparecería "México Distrito Federal".  

## Ejemplo práctico 6

Selecciona el nombre de los paises de África y la pobleción en millones con tres decomales de redondeo.  

```sql
SELECT name, ROUND (population/1000000,3)
FROM world
WHERE continent = 'Africa';
```

**ROUND (x/n,d)**: Selecionas el atributo "x" y redondeas el número "n" con "d" decimales.  

## Ejemplo práctico 7

Selecciona todas las capitales de Europa y Asia, y ordénalas de mayor a menor según el número de letras.  

```sql
SELECT capital, LENGTH(capital9
FROM world
WHERE continent = 'Europe' OR continent = 'Asia';
```

**LENGTH(x)**: Devuelve el número de letras que tiene la palabra del atibuto "x".  

## Ejemplo práctico 8

Seleciona todos los países con una población superior a 200000000 *(200 millones)* y asígnales una abreviatura que será el resultado de las tres primeras letras del nombre del país.  

```sql
SELECT name, LEFT(name, 3)
FROM world
WHERE population >= 200000000;
```

**LEFT(x, n)**: Se usa para recoger los primeros "n" carácteres del atributo "x".  
**RIGHT(x, n)**: Tiene la misma función que LEFT pero comenzando por la derecha.  

## Ejemplo práctico 9

Muestra el nombre y la población de todos los países de Europa en releción a Alemania, poniéndolos como porcentaje.  

```sql
SELECT name, CONCAT(ROUND(100*population/
                                         SELECT population
                                         FROM world
                                         WHERE name = 'Germany',
                    0),
             '%')
FROM world
WHERE continent = 'Europe;
```

**CONCAT(x, y)**: Se usa para concatenar los valores "x" e "y".  
En el ejemplo de arriba se concatena el número resultante de la población de los países con un símbolo de porcentaje para indicar que son porcentajes respecto a la población de Alemania. Además, para seleccionar que el país es Alemania, hubo que hacer una *subconsulta*, ya que no había forma de poner el nombre de dicho país de forma directa.  

## Ejemplos prácticos 10

Busca la cantidad total personas en la Tierra.  
```sql
SELECT SUM(population)
FROM world;
```

**SUM(x)**: Devuelve la suma de todos los valores de la columna "x".  

-----

Cuenta todos los países de Europa.  

```sql
SELECT COUNT(name)
FROM world
WHERE continent = 'Europe';
```
**COUNT(x)**: Cuenta el número de tuplas que hay.  

-----

Busca la población del país con más habitantes.

```sql
SELECT MAX(population)
FROM world;
```

**MAX(x)**: Devuelve el valor máximo de la columna "x".  

-----

Busca el país con menor producto interior bruto en Europa.  

```sql
SELECT MIN(GDP)
FROM world
WHERE continent = 'Europe';
```

**MIN(x)**: Devuelve el menor valor de la columna.  

-----

Busca el valor del producto interior bruto de todos los países del mundo.  

```sql
SELECT AVG(GDP)
FROM world;
```

**AVG(x)**: Devuelve el valor medio de la columna "x".  

-----

Muestra la cantidad de países que hay en cada continente.  

```sql
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;
```

**GROUP BY x**: Agrupa las tuplas para evitar errores con SUM, COUNT, AVG, MAX... Este error aparece debido a que con *continent* le estamos pidiendo una tupla por cada continente, mientras que con *COUNT(name)* le estamos pidiendo que cuente todos los nombres de la tabla, por lo que la base de datos al querer mostrar una tupla por cada continente y otra por cada país, hay un error y no funciona.  

-----

Muestra los continentes con una población superior a 500000000 *(500 millones)*.  

```sql
SELECT continent, SUM(population)
FROM world
GROUP BY continent
HAVING SUM(population) > 500000000;
```

**HAVING**: Tiene un uso similar a *WHERE* pero se aplica a un conjunto realizado con *GROUP BY*.  

## Ejemplo práctio 11

Si por ejemplo tenemos las tablas:  

goal (teamid , matchid, player, gtime)  
                                          
game (id, mdate, stadium, team1, team2)  

> (id == matchid)  

Con estas dos tablas se nos pide encotrar todos los goles que marcaron los jugadores de la selección alemana, mostrando el jugador, el identificador del equipo, el estadio y en que día fue.  

```sql
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game JOIN goal ON (game.id = goal.matchid)
WHERE goal.teamid = 'GER';
```

Hasta ahora todos las consultas que hice eran en una única tabla, pero hay consultas que requieren la utlización de más tablas para esto se usa JOIN.  

**JOIN**: Su función es la de juntar dos o más tablas en una para hacer consultas más complejas. Se suele usar en conjunto con la palabra *ON* para hacer un filtro al unirlas, ya que al usar JOIN todos los valores de una tabla se unen con todos y cada uno de los valores de la otra tabla.  
Si tuvieramos una tabla con cien nombres y otra con cien apellidos, cada nombre se juntaría con cada apellido por lo que habria 100*100=10000 tuplas. Por este motivo se usa *ON*
junto con la clave ajena y la clave primaria.  

-----

También hay una forma de evitar poner el *ON*, y es poniendo:  

```sql
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game JOIN goal
WHERE goal.teamid = 'GER'
      AND (game.id = goal.matchid);
```
-----

La consulta:  

```sql
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game INNER JOIN goal ON (game.id = goal.matchid)
WHERE goal.teamid = 'GER';
```

## Ejemplo práctico 12

Es exactamente igual a las anteriores consultas de este apartado, *INNER JOIN* y *JOIN* son completamente sinónimos, funcionan de la misma forma. Ambos suprimen las tuplas con valores nulos, esto quiere decir que si hay una tupla con un valor nulo, hará que no aparezca, esto se podrá resolver más adelante con otro tipo de joins.  


Con el caso anterior imaginemos que la base de datos tiene campos sin valor o dicho con el nombre que le correspode, los nulos.  

Muestra todos los goles que marcaron los jugadores de la selección alemana sabiendo que hay valores nulos.  

```sql
SELECT player, teamid, stadium, mdate
FROM game LEFT JOIN goal ON (id=matchid)
WHERE teamid = 'GER';
```

```sql
SELECT player, teamid, stadium, mdate
FROM game RIGHT JOIN goal ON (id=matchid)
WHERE teamid = 'GER';
```

En la primera consulta, se mostrarían todos los valores de la tabla (sean nulos o no) *game* puesto que es la tabla de la izquierda. En el segundo caso se mostrarían todos los valores de la tabla de la derecha ya que la tabla *goal* está a la derecha.  
Si pusieramos las tablas al revés, primero *goal* y después *game*, para hacer exactamente la misma consulta, tendríamos que cambiar **LEFT** por **RIGHT** y viceversa, el motivo de esto es que el que una tabla esté a la izquierda o a la derecha depende de en que orden se pongan las tablas para hacer el **JOIN**. La primera tabla será la que está más a la izquierda,y las siguientes estarán cada una más a la derecha que la anterior  

**LEFT JOIN y RIGHT JOIN**: Ambos joins tienen la misma función que el **JOIN** o el **INNER JOIN**, se diferecian en que **LEFT** y **RIGHT** muestran los nulos de la tabla a la que se están referenciando.  

# El sublenguaje DDL
El sublenguaje de SQL que sirve para crear, borrar y modificar tablas de bases de datos recibe el nombre de DDL, *Data Definition Language*.  

## Estructura básica de una setencia DDL con CREATE

A continuación voy a definir los predicados de las sentencias de *CREATE*.  
> DATABASE ---> Sirve para crear bases de datos, pero tiene permisos más restrictivos.  
> SCHEMA ---> Tiene el mismo uso que DATABASE, pero no tiene tantas restricciones.  
> TABLE ---> Crea las tablas de una base de datos.  
> USER ---> Crea usuarios.  
> IF NOT EXISTS ---> Comprueba si hay tablas, bases de datos o usuarios con el nombre que asignas.  
> CHARACTER SET ---> Se usa para asignar juegos de carácteres a la base de datos, como por ejemplo el UTF.  
> dominio1 ---> NCHAR(n), DATE, INT, TIME...  
> DEFAULT <x> ---> Asigna un valor por defecto.  

```sql
CREATE (DATABASE || SCHEMA || TABLE || USER)
	[IF NOT EXISTS] DB_Name
	[CHARACTER SET Charset_Name](<atributo1> <dominio1> [NOT NULL] [DEFAULT <x>],
	...
	<atributoN> <dominioN> [NOT NULL] [DEFAULT <x>],
	[restriction1],
	...
	[restrictionN]
	);
```
-----

Las restricciones que aparecen al final de la sentencia también reciben el nombre de *constraints* porque se crean con dicha palabra, en DDL hay cuatro *constraints*, que veremos a continuación.  
Restricción de clave primaria.  
```sql
[[CONSTRAINT <nombreDeRestriccion>] 
	PRIMARY KEY (<atributos>)]
```
-----
Restricción de clave foránea.  
```sql
[[CONSTRAINT <nombreDeRestriccion>] 
	FOREIGN KEY (<atributos>)
	REFERENCES <nombreDeTablaReferenciada> (<atibutoReferenciado>)]
```
-----
Restricción de unicidad.  

```sql
[[CONSTRAINT <nombreDeRestriccion>]
	UNIQUE (<atributo>)[, (<atributo>)]]
```
-----
Comprobación de si los datos añadidos son válidos.  
```sql
[[CONSTRAINT <nombreDeRestriccion>]
	CHECK (atributoA IN ('valor1', 'valor2', ... , 'valorN'))
	[[NOT] DEFERRABLE]
	[INITIALLY INMEDIATE | DEFERRED]]
```
## Ejemplos de creación de una tabla
Para crear una tabla con el nombre de *people* donde tendremos que almacenar el DNI, la nota y el sueldo se haría de la siguiente forma.  
Primero crearemos la tabla con los atributos correspondientes, al DNI le pondremos CHAR(9) porque sabemos a ciencia cierta que todos los DNI tienen nueve carácteres.  
```sql
CREATE TABLE
	IF NOT EXIST people
	DNI char(9) NOT NULL
	nota INT
	sueldo INT;
```
Y una vez creada la tabla, crearemos las restricciones con los *constranints*, el DNI será único, la nota estará situada entre 0 y 10, y el sueldo tendrá un máximo que será el de la clase "A".  
```sql
CONSTRAINT persona_dni_unique
	UNIQUE DNI;
```
```sql
COMSTRAINT nota_minima
	CHECK nota BETWEEN 0 AND 10;
```
```sql
CONSTRAINT check_sueldo_maximo
	CHECK sueldo >= (SELECT sueldo	
			 FROM empleado
			 WHERE departament = 'A')
	DEFERRABLE
	INITIALLY DEFERRED;
```

## Borrado de una tabla
La eliminación de una tabla es mucho más fácil que la creación de la misma. Se realiza con el siguiente comando.  

```sql
DROP TABLE
	[IF EXISTS] <nombreDeLaTabla>
	[CASCADE | RESTRICT];
```
> RESTRICT solo borra la tabla mientras que CASCADE hace un borrado en cascadade todo lo que almacenaba esta tabla.  












