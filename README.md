# Apuntes de SQL de Bases de Datos

## Índice

- [Cosas a tener en cuenta](#cosas-a-tener-en-cuenta)
- [Estructura básica de una sentencia SELECT](#estructura-básica-de-una-sentencia-SELECT)
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
- [Ejemplo práctico 11 (JOIN)](#ejemplo-práctico-11)

## Cosas a tener en cuenta

1. Los strings **siempre** van entre comillas simples.
2. Por conveinio las clausulas como SELECT, FROM, WHERE... **Van en mayúsculas**.
3. **Siempre se pone punto y coma al final.**
4. Los comentarios de una línea se hacen con -- y lo comentado irá después de los dos guiones.
5. Los comentarios multilínea se hacen con /* */ poniendo el código comentado entre los asteríscos.

## Estructura básica de una sentencia SELECT
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
---

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

Con estas dos tablas se nos pide encotrar todos los goles que marcaron los jugadores de la selección Alemana, mostrando el jugador, el identificador del equipo, el estadio y en que día fue.  

```sql
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';
```

Hasta ahora todos las consultas que hice eran en una única tabla, pero hay consultas que requieren la utlización de más tablas para esto se usa JOIN.  

**JOIN**: Su función es la de juntar dos o más tablas en una para hacer consultas más complejas. Se suele usar en conjunto con la palabra *ON* para hacer un filtro al unirlas, ya que al usar JOIN todos los valores de una tabla se unen con todos y cada uno de los valores de la otra tabla.  
Si tuvieramos una tabla con cien nombres y otra con cien apellidos, cada nombre se juntaría con cada apellido por lo que habria 100*100=10000 tuplas. Por este motivo se usa *ON*
junto con la clave ajena y la clave primaria.  

-----
También hay una forma de evitar poner el *ON*, y es poniendo:  

```sql
SELECT player, teamid, stadium, mdate
FROM game JOIN goal
WHERE teamid = 'GER'
      AND (id=matchid);
```







































