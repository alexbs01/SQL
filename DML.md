# El sublenguaje DML  

## Índice

- [Como usar la sentencia INSERT](#Como-usar-la-sentencia-INSERT)
- [Como usar una setencia UPDATE](#Como-usar-una-setencia-UPDATE)
- [Como usar una setencia DELETE](#Como-usar-una-setencia-DELETE)

DML es el sublenguaje de SQL que sirve para agregar, borrar o modificar las tuplas de una tabla en una base de datos, recibe este nombre por las siglas de *Data Manipulation Language*. Este sublenguaje tiene tres sentencias importantes, **INSERT**, **UPDATE** y **DELETE**.  
Como vamos a trabajar sobre la base de datos que creamos anteriormente dejo [aquí](https://github.com/davidgchaves/first-steps-with-git-and-github-wirtz-asir1-and-dam1/tree/master/exercicios-ddl/1-proxectos-de-investigacion), otra vez el enunciado con el diseño de la base de datos.  

## Como usar la sentencia INSERT

La sentencia INSERT tiene la función de añadir datos a una tabla.  

```sql
INSERT INTO <nombreDeLaTabla>
  (<atributo1>[, <atributo2>, <atributo3>...])
  VALUES (
  (<valor1>[, <valor2>, <valor3>...])
  ) || (
  SELECT <atributoX> FROM <tablaX> ...);
```

Como podemos ver en la fórmula, esta sentencia sirve para añadir valores a mano o para pasar los valores de una tabla a otra usando una sentencia SELECT que pertenece al subleguaje DQL que vimos al proncipio de todo.  
También hay que decir que se puede hacer una tupla con los valores por defecto poniendo:  

```sql
INSERT INTO <nombreDeLaTabla> DEAFULT VALUES;
```  

Ahora vamos a añadir valores a la tabla **sede** para tener un ejemplo real.  

```sql
INSERT INTO sede
  (nomeSede, campus)
  VALUES
  ('Informástica', 'Elviña'),
  ('Enfermería', 'Oza'),
  ('Derecho', 'Elviña');
```

Con esa sententcia añadiríamos tres tuplas con esos valores, porque como se puede ver, se pueden añadir más de una tupla a la vez, siempre y cuando separemos los bloques por una coma (los valores numéricos van sin comillas).  

## Como usar una setencia UPDATE

Realmente campus no puede ser nulo, pero para este ejemplo imaginémonos que sí puede serlo, y que esta sentencia es correcta.  

```sql
INSERT INTO sede
  (nomeSede, campus)
  VALUES
  ('Caminos', ''),
  ('Fisioterapia', 'Zapateira');
```

Ahora nos piden que a Caminos le asignemos un campus y que el de fisioterapia lo cambiemos por el de Oza porque el que está puesto es erroneo.  

| nomeSede | campus |
| -------- | ------ |
| Informática | Elviña |
| Enfermería | Oza |
| Derecho | Elviña |
| Caminos |  |
| Fisioterapia| Zapateira |

Entonces partiendo de la siguiente fórmula:  

```sql
UPDATE <nombreDeLaTabla> 
SET <atributo1> = <valor1>,
    <atrubuto2> = <valor2>,
    ...
    <atributoN> = <valorN>
[WHERE <predicado>];
```

Haremos lo siguiente.  

```sql
UPDATE sede
  SET campus = 'Elviña'
  WHERE nomeSede = 'Caminos';
  
UPDATE sede
  SET campus = 'Oza'
  WHERE nomeSede LIKE 'Fisiot%';
```

El predicado *SET* establece el nuevo valor de los atributos y el *WHERE* busca las tuplas en las que debe cambiar los valores. **Es muy importante recordar que si no ponemos el WHERE, se aplicará el cambio a toda la base de datos**.  
En el predicado del *WHERE* se pueden usar operadores, expresiones regulares o modificaciones del tipo ``` precio = precio * 1.25 ```.  

La tabla *sede* quedará arreglada y tendrá la siguiente forma:  

| nomeSede | campus |
| -------- | ------ |
| Informática | Elviña |
| Enfermería | Oza |
| Derecho | Elviña |
| Caminos | Elviña |
| Fisioterapia| Oza |

## Como usar una setencia DELETE

Ahora acabar con este subleguaje, borraremos valores de alguna tuplas. Pongamos que por cualquier motivo tenemos que borrar las tuplas en las que el campus está en Oza.  
Partiendo de la fórmula:  

```sql
DELETE FROM <nombreDeLaTabla>
  WHERE <predicado>;
```

Para borrar las tuplas haremos...  

```sql
DELETE FROM sede
  WHERE campus = 'Oza';
```

La pasaría de estar así:  

| nomeSede | campus |
| -------- | ------ |
| Informática | Elviña |
| Enfermería | Oza |
| Derecho | Elviña |
| Caminos | Elviña |
| Fisioterapia| Oza |

A perder las tuplas que le borramos arriba.  

| nomeSede | campus |
| -------- | ------ |
| Informática | Elviña |
| Derecho | Elviña |
| Caminos | Elviña |

