# Apuntes de SQL de Bases de Datos

## Cosas a tener en cuenta

1. Los strings siempre van entre comillas simples.
2. Por conveinio las clausulas como SELECT, FROM, WHERE... Van en mayúsculas.
3. Siempre se pone punto y coma al final.

## Ejemplo práctico 1

Selecciona la población de la tabla "world" donde el nombre del país es Alemania

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

**IN**: Se usa en sustitución de OR. En vez de poner "name = 'Sweden' OR name = 'Norway' OR name = 'Denmark'" se pone "IN ('Sweden', 'Norway', 'Denmark')" para abreviar.
























