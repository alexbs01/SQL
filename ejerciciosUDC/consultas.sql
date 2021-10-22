-- Consulta 1
SELECT deptno ,dname 
FROM dept;

-- Consulta 2
SELECT MGR AS "Codigo del jefe"
FROM EMP
WHERE mgr IS NOT NULL;

-- Consulta 3
SELECT loc
FROM dept
WHERE deptno = 30;

-- Consulta 4
SELECT ename
FROM emp
WHERE mgr IS NULL;

-- Consulta 5
SELECT *
FROM emp
WHERE mgr IS NOT NULL AND 
	(sal + comm > 2500 OR sal > 2500 );
	
-- Consulta 6
SELECT *
FROM emp
WHERE ename LIKE 'S%';

-- Consulta 7
SELECT *
FROM emp
WHERE (comm IS NULL AND sal BETWEEN 1500 AND 2500) OR 
	(sal + comm BETWEEN 1500 AND 2500);

-- Consulta 8
SELECT *
FROM emp
WHERE (job IN ('CLERK', 'SALESMAN', 'ANALYST')) AND (sal > 1250 OR sal + comm > 1250);

-- Consultas GROUP BY
-- Consulta 1
SELECT deptno  AS "Numero de departamento",
	count(ename) AS "Empleados por departamento",
	count(comm) AS "Empleados con comision", 
	count(*)-count(comm) AS "Empleados sin comision", 
	avg(COALESCE(sal + comm, sal)) AS "Media de salarios + comision" -- COALESCE ignora los nulos de comm y en su lugar hace la media del salario
FROM emp
GROUP BY deptno;

-- Consulta 2
SELECT DISTINCT deptno
FROM emp
WHERE comm IS NOT NULL;

-- Consulta 3
 --Coalesce ace que los nulos valgan 0
SELECT distinct deptno, COALESCE(avg(comm), 0)
FROM emp
GROUP BY deptno

-- Consulta 4
SELECT deptno, count(DISTINCT job) AS "Puestos de trabajo distintos"
FROM emp
GROUP BY deptno;
