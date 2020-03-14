# El sublenguaje DDL

## Índice

- [El sublenguaje DDL](#el-sublenguaje-ddl)
	- [Estructura básica de una setencia DDL con CREATE](#Estructura-básica-de-una-setencia-DDL-con-CREATE)
	- [Ejemplos de creación de una tabla](#Ejemplos-de-creación-de-una-tabla)
- [Creación y modificación de una BD](#Creación-y-modificación-de-una-BD)
	- [Creando la base de datos](#Creando-la-base-de-datos)
	- [Crear los dominios](#Crear-los-dominios)
	- [Creación de las tablas](#Creacion-de-las-tablas)
	- [Actualización frente al borrado y a la modificación](#Actualización-frente-al-borrado-y-a-la-modificación)
	- [Como alterar una tabla con ALTER](#Como-alterar-una-tabla-con-ALTER)
- [Como declarar los CONSTRAINTS](#Como-declarar-los-CONSTRAINTS)
	- [Como declarar una clave primaria](#Como-declarar-una-clave-primaria)
	- [Como declarar una clave foránea](#Como-declarar-una-clave-foránea)
	- [Como declarar un atributo único](#Como-declarar-un-atributo-único)
	- [Como declarar una validación con CHECK](#Como-declarar-una-validacion-con-CHECK)
- [Como alterar una tabla](#Como-alterar-una-tabla)
- [Como borrar una tabla](#Como-borrar-una-tabla)

El sublenguaje de SQL que sirve para crear, borrar y modificar tablas de bases de datos. Recibe el nombre de DDL por ser las siglas de *Data Definition Language*.  

## Estructura básica de una setencia DDL con CREATE

A continuación voy a definir los predicados de las sentencias de *CREATE*.  
> DATABASE ---> Sirve para crear bases de datos, pero tiene permisos más restrictivos.  
> SCHEMA ---> Tiene el mismo uso que DATABASE, pero no tiene tantas restricciones.  
> TABLE ---> Crea las tablas de una base de datos.  
> USER ---> Crea usuarios.  
> IF NOT EXISTS ---> Comprueba si hay tablas, bases de datos o usuarios con el nombre que asignas.  
> CHARACTER SET ---> Se usa para asignar juegos de carácteres a la base de datos, como por ejemplo el UTF.  
> dominio1 ---> VARCHAR(n), DATE, INT, TIME...  
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
	DNI char(9) NOT NULL,
	nota INT,
	sueldo INT;
```

Y una vez creada la tabla, crearemos las restricciones con los *constraints*, el DNI será único, la nota estará situada entre 0 y 10, y el sueldo tendrá un máximo que será el de la clase "A".  

```sql
CONSTRAINT persona_dni_unique
	UNIQUE (DNI);
```

```sql
CONSTRAINT nota_minima
	CHECK (nota BETWEEN 0 AND 10);
```

```sql
CONSTRAINT check_sueldo_maximo
	CHECK (sueldo >= (SELECT sueldo	
			 FROM empleado
			 WHERE departament = 'A'))
	DEFERRABLE
	INITIALLY DEFERRED;
```

# Creación y modificación de una BD

Ahora con estas pequeñas bases vamos a crear una base de datos desde cero (lo haré de forma que se pueda implementar en **PostreSQL**), explicando en cada paso lo que se hace y procurando hacerlo de todas las formas posibles. Lo haremos siguiendo el esquema y el enunciado de la cuenta de GitHub de @davidgchaves. Para el enunciado y el esquema entra [aquí](https://github.com/davidgchaves/first-steps-with-git-and-github-wirtz-asir1-and-dam1/tree/master/exercicios-ddl/1-proxectos-de-investigacion), además, este ejercicio que voy a poner es uno que realizamos en clase.  
También tengo que aclarar que todas las formas de declarar una clave primaria, foránea, un atributo único o la validación con un *CHECK* será tratado después de la creación de la base de datos. Para ir directamente pulsa [aquí](#Como-declarar-los-CONSTRAINTS)

## Creando la base de datos

El primer paso es crear una base de datos, para ello usaremos la siguiente sentencia.  

```sql
CREATE SCHEMA proxectosDeACoruna
```

## Crear los dominios

La creación de los dominios es muy util, ya que así nos evitamos tener que poner todo el tiempo un dominio para cada atributo. Un dominio funciona de una forma parecida a una variable, se declara y luego se usa. Y si por cualquier motivo tenemos que cambiar algo de esto, solo tendremos que cambiarlo en la declaración del dominio, si no hicieramos esto, tendríamos que cambiar los datos correspondientes en todos los sitios que aparezcan.  

```sql
CREATE DOMAIN nomeValido VARCHAR(30);
CREATE DOMAIN tipoCodigo CHAR(50);
CREATE DOMAIN tipoDNI CHAR(9);
```

## Creación de las tablas

Comenzaremos creando la tabla **sede**, ya que no tiene ninguna clave foránea y sirve para explicar dos *CONSTRAINTS*. Esta tabla se crea de la siguiente forma.  

```sql
CREATE TABLE sede (
  nomeSede nomeValido PRIMARY KEY,
  campus nomeValido NOT NULL
);
```
Como podemos ver la tabla **sede** es una tabla con dos atriutos, de los cuales, *nomeSede* es la clave primaria y *campus* no puede ser nula. Ambas restricciones **están "declaradas" en la misma línea** en la que e declaran los atributos, así que así ya tenemos una forma de nombrar restricciones.  

-----

Ahora procederemos a crear la tabla de **departamento** la cual tiene un atributo que es una clave foránea de una tabla que aun no creamos, esto lo aprovecharemos para explicar más adelante como modificar una tabla, pero por ahora, esta tabla no estará relacionada con ninguna otra.  

```sql
CREATE TABLE departamento (
  nomeDepartamento nomeValido,
  telefono CHAR(9) NOT NULL,
  director tipoDNI,
  PRIMARY KEY (nomeDepartamento)
);
```

En esta parte de la creación de tablas lo que podemos destacar es como declaramos la clave primaria, ya que no lo hicimo como en el caso anterior. Esta vez lo que hicimos fue declarar la clave primaria una vez ya fueron declarados todos los atributos, ```PRIMARY KEY (<atributo>)```, hay que destacar que los **paréntesis que enmarcan al atributo son obligatorios**, tanto si es una clave primaria simple como si es una compuesta.  

-----

### Actualización frente al borrado y a la modificación

A continuación crearemos la tabla **ubicación** en la que tendremos que realizar dos relaciones con otras dos tablas.  

```sql
CREATE TABLE ubicacion (
  nomeSede nomeValido,
  nomeDepartamento nomeValido,
  CONSTRAINT PK_ubicacion
    PRIMARY KEY (nomeSede, nomeDepartamento)
  CONSTRAINT KF_sede
    FOREIGN KEY (nomeSede)
      REFERENCES sede (nomeSede)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  CONSTRAINT FK_departamento
    FOREIGN KEY (nomeDepartamento)
      REFERENCES departamento (nomeDepartamento)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);
```
Como podemos ver esta tabla solo tiene dos atributos que conforman la clave primaria compuesta.  

Aquí hay que aclarar que las restricciones se están haciendo con ```CONSTRAINT <nomeConstraint> ```, esto se utiliza para llevar un registro de las restricciones de la base de datos en otra base de datos que recibe el nombre de "diccionario de la base de datos". Con esto explicado, podemos ver que la clave primaria se declara de la misma forma con *constraint* o sin él, también hay que aclarar que si la tabla tiene una clave primaria compuesta se tendrá que declarar obligatoriamente fuera de la declaración de variables, esto lo trataré un poco más adelante.  

La restricción de clave foránea funciona de una forma parecida a la anterior, la fórmula es ```FOREIGN KEY (<atributo>) REFERENCES <tablaReferenciada> (<atributoQueSePropaga>)```, y los paréntesis como con la clave primaria, también son obligatorios. Las dos últimas líneas de cada clave foránea tienen la función de como se actualizará la base de datos en caso de que se actualice o se borre la clave foránea, hay cuatro posibilidades:  

1. **C**: *CASCADE*, actúa en cascada ante la modificación.  
2. **R**: *NO ACTION*, es R de restricted y quiere decir que cuando haya una actualización, no se modifique nada, también es la opción por defecto.  
3. **N**: *SET NULL*, ante la modificación que corresponda, en este caso se suele aplicar al borrado, los campos de una clave propagada recibirán un valor nulo.  
4. **D**: *SET DEFAUL <x>*, establece un valor por defecto, aunque esta opción no es muy recomendable.  

Esto en las interrelaciones se señala poniendo o **B** o **M** según sea de borrado o de modificación, como por ejemplo: **B:C** y **M:C**, aplicar en cascada el borrado y la modificación.  

-----

Después de esta explicación podemos seguir creando las tablas de nuestra base de datos, ahora crearemos la tabla **grupo**.  

```sql
CREATE TABLE grupo (
  nomeGrupo nomeValido,
  nomeDepartamento nomeValido,
  area nomeValido NOT NULL, -- area se refiere al area de conocimiento (BD, programación...)
  lider nomeValido,
  PRIMARY KEY (nomeGrupo, nomeDepartamento),
  FOREIGN KEY (nomeDepartamento) REFERENCES departamento
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
```

Como se puede ver, no hice uso de *CONSTRAINT* esto es porque tampoco es obligatorio ponerlo, pero esto ya lo hice anteriormente, lo especial es que no indiqué la clave que se propaga, solo indiqué la tabla. El motivo de esto es porque por defecto se coge el atributo que tiene el mismo nombre, pero personalmente prefiero incluir el atributo para ser más específicos, de igual forma que antes, si incluimos el atributo que se propaga habrá que ponerlo entre paréntesis después de la tabla.  

-----

Ahora procederemos a crear la tabla de **profesores**, que lo único distinto que tiene es en lo que hará si se borra la clave propagada.  

```sql
CREATE TABLE profesor (
  dni tipoDNI PRIMARY KEY,
  nomeProfesor nomeValido NOT NULL,
  titulación VARCHAR(20) NOT NULL,
  experiencia INTEGER,
  grupo nomeValido,
  departamento nomeValido,
  CONSTRAINT FK_profesor_grupo
    FOREIGN KEY (grupo, departamento)
      REFERENCES grupo (nomeGrupo, nomeDepartamento)
      ON DELETE SET NULL
      ON UPDATE CASCADE
);
```

Como podemos ver, ante un borrado el la tabla **grupo**, se cambiarán los campos para poner un valor nulo. También lo que puede destacar es que se propagan dos claves a la vez para mantener la integridad de la base de datos, esto se hace de la misma forma que con un único atributo, solo que lo que hay que hacer es separar los atributos con una coma tal y como se indica en la sentencia de arriba.  

-----

En la siguiente tabla que corresponde con la de **proxecto**, tendremos el primer *CHECK* de la base de datos, y también pondremos las interrelación de la clave foránea en la propia declaración del atributo.  

```sql
CREATE TABLE proxecto (
  codigoProxecto tipoCodigo PRIMARY KEY,
  nomeProxecto tipoValido,
  orzamento MONEY NOT NULL,
  dataInicio DATE NOT NULL,
  dataFin DATE,
  nomeGrupo nomeValido,
  nomeDep nomeValido,
  UNIQUE (nomeProxecto),
  CONSTRAINT CHECKDates
    CHECK (dataInicio < dataFin),
  FOREIGN KEY (nomeGrupo, nomeDep)
    REFERENCES grupo (nomeGrupo, nomeDepartamento)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
```

Como vimos arriba, el *CHECK* sirve para que solo se puedan poner fechas de fin anteriores a la fecha de inicio, también algo nuevo que hay es el dominio de *orzamento* que es MONEY, un dominio para manejar dinero y evitar los errores de aproximación que pueden tener otros tipos de números decimales.

-----

### Como alterar una tabla con ALTER

A continuación tendremos los dos primeros *ALTER* los haremos en las tablas **departamento** y **grupo**, para añadir una clave foránea a cada una. Pero antes, la fórmula de *ALTER* es:  

```sql
ALTER TABLE <nombreDeLaTabla>
	[ADD [COLUMN] <atributo1> <dominio1> [NOT NULL] [DEFAULT <x>]] ||
	[DROP [COLUMN] <atributo1> [CASCADE | RESTRICT]] ||
	[ADD CONSTRAINT <nombre>] ||
	[DROP CONSTRAINT <nombre>];
```

Nosotros lo que vamos a hacer es lo que corresponde con la cuarta línea de la formula, pero para ver una explicación más detallada de la formula pulsa [aquí](#Como-alterar-una-tabla).

```sql
ALTER TABLE departamento
  ADD CONSTRAINT FK_departamento
    FOREIGN KEY (director)
      REFERENCES profesor (dni)
      ON DELETE SET NULL
      ON UPDATE CASCADE;

ALTER TABLE grupo
  ADD CONSTRAINT FK_grupo
    FOREIGN KEY (lider)
      REFERENCES profesor (dni)
      ON DELETE SET NULL
      ON UPDATE CASCADE;
```

De esta forma pudimos hacer una propagación de una clave primaria a dos tablas que se crearon antes de que existiera la relación con esta tabla.  

-----

Una vez hechos estos dos *ALTER* vamos a hacer la tabla **participa**, que es relativamente.  

```sql
CREATE TABLE participa (
  dni tipoDNI,
  codigoProxecto tipoCodigo,
  dataInicio DATE NOT NULL,
  dataCese DATE,
  dedicación INTEGER NOT NULL,
  PRIMARY KEY (dni, codigoProxecto),
  FOREIGN KEY (dni)
    REFERENCES profesor (dni)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,
  FOREIGN KEY (codigoProxecto)
    REFERENCES proxecto (codigoProxecto)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,
	CHECK (dataInicio < dataCese)
);
```

En esta tabla decidí declarar las restricciones al final, una vez declarados los atributos, más que nada, porque la clave primaria al ser compuesta ya había que ponerla si o si al final. En las actualizaciones de borrado se podría evitar ponerlas ya que por defecto es *NO ACTION*, aun así recomiendo ponerlo para no tener que recordar cuales son los valores por defecto para ahorrarse escribir dos palabras más.  

-----

Ahora supongamos que nos equivocamos al crear la modificación de actualización de la clave foránea en la tabla de **profesor**, modificar como tal no se puede hacer en SQL, lo que si podemos hacer es borrar la *CONSTRAINT* correspondiente y volverla a crear con *ALTER*.

```sql
ALTER TABLE profesor
  DROP CONSTRAINT FK_grupo_profesor
  ADD CONSTRAINT FK_grupo_profesor
    FOREIGN KEY (grupo, departamento)
	  REFERENCES grupo (nomeGrupo, nomeDepartamento)
	  ON DELETE SET NULL
	  ON UPDATE NO ACTION; -- Antes ponía ON UPDATE CASCADE
```

Como ya explique arriba, para cambiar una cosa por otra en una tabla ya creada no se puede modificar como se haría en muchas otras lenguajes de programación.  

-----

Ahora crearemos la tabla **programa**, que es la más pequeña de todas ya que solo tiene un atributo, por lo que la declaración de clave primaria lo haré en la propia línea del atributo.  

```sql
CREATE TABLE programa (
  nomePrograma nomeValido PRIMARY KEY
);
```

Ahora casi acabando, crearemos la última tabla que es **financia**, pero solo la crearemos con la clave primaria para después tener que alterarla.  

```sql
CREATE TABLE financia (
  nomePrograma nomeValido,
  codigoProxecto tipoCodigo,
  numeroProxecto tipoCodigo NOT NULL,
  cantidadeFinanciada MONEY NOT NULL,
  PRIMARY KEY (nomePrograma, codigoProxecto)
);
```

-----

Y ahora sí que para acabar, añadiremos las claves foráneas a la tabla que acabamos de crear.  

```sql
ALTER TABLE financia
  ADD CONSTRAINT FK_proxecto_financia
    FOREIGN KEY (codigoProxecto)
	  REFERENCES proxecto (codigoProxecto)
	  ON DELETE CASCADE
	  ON UPDATE CASCADE;

ALTER TABLE financia
  ADD CONSTRAINT FK_programa_financia
    FOREIGN KEY (nomePrograma)
	  REFERENCES programa (nomePrograma)
	  ON DELETE CASCADE
      ON UPDATE CASCADE;
```

Así es como se crea una base de datos a partir de un esquema ya dado, procurando hacer las cosas de todas las formas distintas para que quede claro que se puede y que no hacer.  
Si todos los fragmentos de codigo que hay repartidos en esta parte de SQL los ponemos todos juntos uno detrás de otro debería funcionar, puede que me equivocara al teclear alguna letra, salvo eso lo dicho, debería ir sin problemas.  

# Como declarar los CONSTRAINTS
## Como declarar una clave primaria

La creación de una tabla implica la creación de una clave primaria de forma obligatoria, por eso si intentamos crear una tabla sin una PK nos saltará un error. Para declarar una clave primaria tenemos tres maneras de hacerlo.  

### Declaración en la propia línea

La clave primaria se puede declarar en la propia línea de la declaración del atributo.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1> PRIMARY KEY,
  ...
);
```

-----

### Declaración fuera de la línea del atributo

Si es compuesta se tiene que declarar obligatoriamente fuera de la declaración de atributos, eso significa que no puedes poner dos *PRIMARY KEY* en dos líneas distintas de la misma forma que en el ejemplo anterior. Declarando la clave primaria al acabar de declarar los atributos sirve tanto para claves simples como compuestas y se tendría que poner de la siguiente forma.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
  PRIMARY KEY (<atributo1>[, <atributo2>, ...])
);
```

-----

Y la última forma de declaración es poniendo *CONSTRAINT* antes de *PRIMARY KEY*, la utilidad de esto es para llevar registro de todas las restricciones que hay en una base de datos.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
  CONSTRAINT <nombreDelConstraint>
    PRIMARY KEY (<atributo1>[, <atributo2>, ...])
);
```

## Como declarar una clave foránea

Si para la creación de una clave principal tenemos tres opciones, para las claves foráneas tenemos cuatro posibilidades.  

### Declaración en la propia línea

Como podemos ver, podemos declararla en la propia línea del atributo, y la especificación del atributo referenciado solo es obligatorio cuando ambos atributos tienen nombres distintos. Aunque es recomendable que se ponga siempre para no tener que andar viendo todo el rato cual es el atributo referenciado.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1> REFERENCES <nombreDeLaTablaReferenciada> [(<nombreDelAtributoReferenciado>]),
  ...
);
```

### Declaración fuera de la línea del atributo

Al igual que la clave primaria aqui también podemos ponerlo de dos formas distintas, como son las mismas no me pararé mucho en ellas. Solo hay que destacar que frente a la declaración en línea o la declaración fuera de la línea es preferible la que no sea en la propia línea del atributo.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
  FOREIGN KEY (<atributo1>[, <atributo2>, ...])
    REFERENCES <nombreTablaDeLaReferenciada> (<nombreDelAtributoReferenciado1>[, <nombreDelAtributoReferenciado2>]>)
    ON DELETE [CASCADE | NO ACTION | SET NULL | SET DEFAULT <x>]
    ON UPDATE [CASCADE | NO ACTION | SET NULL | SET DEFAULT <x>]
);
```

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
  CONSTRAINT <nombreDelConstraint>
    FOREIGN KEY (<atributo1>[, <atributo2>, ...])
      REFERENCES <nombreTablaDeLaReferenciada> (<nombreDelAtributoReferenciado1>[, <nombreDelAtributoReferenciado2>])
      ON DELETE [CASCADE | NO ACTION | SET NULL | SET DEFAULT <x>]
      ON UPDATE [CASCADE | NO ACTION | SET NULL | SET DEFAULT <x>]
);
```

### Declaración fuera de la tabla

Esta forma es muy útil porque con un esquema relacional lioso con muchas claves primarias que se propagan a muchas tablas distintas, con tablas que siempre tienen claves foráneas, una buena opción es crear las tablas solo con las claves primarias y posteriormente hacer las interrelaciones con este método una vez estén todas las tablas creadas.  
Para esta forma hay que usar *ALTER* para alterar la tabla.  

```sql
ALTER TABLE <nombreDeLaTabla>
  ADD CONSTRAINT <nombreDelConstraint>
    FOREIGN KEY (<atributo1>[, <atributo2>, ...])
      REFERENCES <nombreTablaDeLaReferenciada> (<nombreDelAtributoReferenciado1>[, <nombreDelAtributoReferenciado2>])
      ON DELETE [CASCADE | NO ACTION | SET NULL | SET DEFAULT <x>]
      ON UPDATE [CASCADE | NO ACTION | SET NULL | SET DEFAULT <x>];
```

## Como declarar un atributo único

Otra restricción de los atributos es el de *UNIQUE*, que como su propio nombre indica sirve para hacer que el atributo sea único, a mayores si a un atributo le ponemos los atributos de *UNIQUE* y *NOT NULL* tendrá el mismo efecto que una clave primaria, por lo que "UNIQUE + NOT NULL = PRIMARY KEY", con esto se pueden crear claves alternativas.  

### Declaración en la propia línea

Como con las otras restricciones, esta también se puede poner en la propia línea del atributo.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1> UNIQUE,
  ...
);
```

### Declaración fuera de la línea del atributo

Al igual que con las otras restricciones, es preferible usar una de estas dos opciones que situan las restricciones fuera de la declaración del atributo.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
  UNIQUE (<atributo1>[, <atributo2>...])
);
```

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
  CONSTRAINT <nombreDelConstraint>
    UNIQUE (<atributo1>[, <atributo2>...])
);
```

### Declaración fuera de la tabla

Ahora como con la clave foránea, también se puede crear esta restricción con un *ALTER*.  

```sql
ALTER TABLE <nombreDeLaTabla>
  ADD CONSTRAINT <nombreDelConstraint>
    UNIQUE (<atributo1>[, <atributo2>...]);
```

## Como declarar una validación con CHECK  

Los *CHECK* se utilizan con los números, y sobretodo para evitar que se pongan valores que no corresponden con el campo el que se están intentando poner. Como por ejemplo: No se puede poner una edad negativa, o tener más años de experiencia que tu propia edad... Estos son todo ejemplos de para que se puede usar un *CHECK*, en la base de datos que creamos anteriormente, lo usamos para especificar que la fecha de salida del hotel no puede ser anterior a la fecha de entrada.  
Al igual que con la restricción anterior, tenemos cuatro formas de declarar esta restricción:  

### Declaración en la propia línea

Como ya nombramos antes, se puede declara en la propia línea de declaración del atributo poniendo el *CHECK* después del dominio.

```sql
CREATE TABLE <nombreDeLaTabla> (
  <EDAD> <dominio1> CHECK (<EDAD> >= 0)
);
```

### Declaración fuera de la línea del atributo

Al igual que las otras constraints, esta se puede hacer de la misma forma.  

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
    CHECK (<atributo1> > <atributo2>)
);
```

```sql
CREATE TABLE <nombreDeLaTabla> (
  <atributo1> <dominio1>,
  <atributo2> <dominio2>,
  <atributo3> <dominio3>,
  ...
  CONSTRAINT <nombreDelConstraint>
    CHECK (<atributo1> >= <atributo2>...)
);
```

### Declaración fuera de la tabla

Y como era de esperar, para hacerlo desde fuera debemos usar un *ALTER TABLE*.

```sql
ALTER TABLE <nombreDeLaTabla>
  ADD CONSTRAINT <nombreDelConstraint>
    CHECK (<atributo1> >= <atributo2>);
```

# Como alterar una tabla

Para alterar una tabla hay que usar lo mismo que usamos para añadir constraints a una tabla ya creada, para esto debemos usar el *ALTER TABLE*.  
El *ALTER TABLE* sirve tanto para agregar columnas y restricciones, como para borrar esto mismo, es de uso fácil y tiene una formula sencilla de recordar.  

```sql
ALTER TABLE <nombreDeLaTabla>
  [ADD COLUMN <atributo1> <dominio1> [NOT NULL] [DEFAULT <x>]]
  ||
  [DROP COLUMN <atributo1> [CASCADE | RESTRICT]]
  ||
  [ADD <CONSTRAINT>] 
  ||
  [DROP <CONSTRAINT>];
```

**CASCADE**: Borra la columna y a todas las tablas a las que se propaga.  
**RESTRICT**: Borra única y exclusivamente la columna que indicamos sin afectar a ninguna otra.  
Como indiqué antes en la creación de las tablas, **si por cualquier motivo queremos modificar** una columna o una restricción, **primero tendremos que borrarla y luego volver a crearla** con las modificaciones que queramos. Esto es debido a que en SQL no se puede modificar algo ya creado.

# Como borrar una tabla

Al igual que para la alteración de una tabla, el borrado de la misma también se hace de una forma muy sencilla.  

```sql
DROP TABLE <nombreDeLaTabla> CASCADE | RESTRICT;
```

**CASCADE**: Borra la tabla y todos los atributos que se propagan desde esta tabla a las demás.  
**RESTRICT**: Solo borra la tabla y deja intactos los atributos que se propagan, esta es la opción que hace por defecto si no le indicamos nada, ya que es la que menos peligrosa si borramos algo por error.  

