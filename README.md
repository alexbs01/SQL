# Apuntes de SQL de Bases de Datos

## Cosas a tener en cuenta

1. Los strings siempre van entre comillas simples.
2. Por conveinio las clausulas como SELECT, FROM, WHERE... Van en mayúsculas.
3. Siempre se pone punto y coma al final.

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


Selecciona todos los países de la tabla "world" donde el nombre de los países empiecen por "G" y además tengan cinco letras.  

```sql
SELECT name
FROM world
WHERE name LIKE 'G____';
```

**WHEN x LIKE 'y'**: Es una forma de buscar un patrón en el atributo indicado, para esto hay que tener en cuenta dos caracteres especiales.  
   1. **%**: Sustituye una cantidad de valores de entre 0 y n, siendo n un valor sin límite.  
   2. **_**: Sustituye tantos carácteres como guiones bajos haya.  

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





















