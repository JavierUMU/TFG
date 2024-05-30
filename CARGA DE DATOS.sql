-- Desactivar la restricción de clave foránea
SET foreign_key_checks = 0;

INSERT INTO localidad (Codigo_postal, localidad, provincia)
VALUES 
(30140, 'Santomera', 'Murcia'),
(30530, 'Cieza', 'Murcia');

SELECT * FROM localidad;
-- DELETE FROM localidad;

-- He tenido que cambiar las parcelas A1,A2,B1 a números porque no me funcionaba
INSERT INTO parcela (Num_parcela, localidad_Codigo_Postal)
VALUES 
(1, 30140),
(2, 30140),
(3, 30140),
(4, 30140),
(5, 30140),
(6, 30140),
(7, 30530);

SELECT * FROM arbol
WHERE parcela_Num_parcela = '2';

SELECT * FROM parcela;
-- DELETE FROM parcela;

SELECT parcela.Num_parcela, localidad.localidad, localidad.provincia
FROM parcela
JOIN localidad ON parcela.localidad_Codigo_Postal = localidad.Codigo_postal;


LOAD DATA INFILE 'J:/ESCRITORIO/DATOS/arbol_P.csv'
INTO TABLE arbol
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@col1, @col2, @col3, @col4, @col5, @col6, @col7, @col8, @col9)
SET idarbol = NULLIF(@col1, ''),
	Num_arbol = NULLIF(@col2, ''),
    Desce = NULLIF(@col3, ''),
    Objetivo = NULLIF(@col4, ''),
    Selección = NULLIF(@col5, ''),
    Variedad = NULLIF(@col6, ''),
    Padre = NULLIF(@col7, ''),
    Madre = NULLIF(@col8, ''),
    parcela_Num_parcela = NULLIF(@col9, 0);
    
SELECT * FROM arbol;
SELECT COUNT(*) AS numero_de_arboles
FROM arbol;

SELECT COUNT(DISTINCT CONCAT(Padre, '-', Madre)) AS total_familias
FROM arbol;

DELETE FROM arbol;


LOAD DATA INFILE 'J:/ESCRITORIO/DATOS/observacion.csv'
INTO TABLE observacion
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@col1, @col2, @col3, @col4)
SET idobservacion = NULLIF(@col1, ''),
	Año = NULLIF(@col2, ''),
    Observacion = NULLIF(@col3, ''),
    arbol_idarbol = NULLIF(@col4, '');
    


SELECT COUNT(*) FROM observacion WHERE arbol_idarbol REGEXP 'D03_022';


SELECT * FROM observacion;



LOAD DATA INFILE 'J:/ESCRITORIO/DATOS/fruto.csv'
INTO TABLE fruto
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@col1, @col2)
SET idfruto = NULLIF(@col1, ''),
    arbol_idarbol = NULLIF(@col2, '');
SELECT * FROM fruto;
DELETE FROM fruto;


LOAD DATA INFILE 'J:/ESCRITORIO/DATOS/caracter_arbol.csv'
INTO TABLE caracter_arbol
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@col1, @col2, @col3, @col4, @col5, @col6 )
SET arbol_idarbol = NULLIF(@col1, ''),
	Año = NULLIF(@col2, ''),
    Nombre = NULLIF(@col3, ''),
    Valor = NULLIF(@col4, ''),
    Tipo_caracter = NULLIF(@col5, ''),
    idcaracter_arbol = NULLIF(@col6, '');
    
    SELECT * FROM caracter_arbol;
    
    -- Desactivar la restricción de clave foránea
SET foreign_key_checks = 0;

SET GLOBAL max_allowed_packet = 128*1024*1024; -- Establece el tamaño máximo del paquete a 128 MB

    SET GLOBAL wait_timeout = 600; -- Cambia 600 por el número de segundos que desees
    SET GLOBAL max_execution_time = 600;
    SET GLOBAL interactive_timeout = 600;
    
    
SELECT * FROM caracter_arbol;
DELETE FROM caracter_arbol;

SET GLOBAL connect_timeout = 60;
SET GLOBAL wait_timeout = 600;




select *from observacion  where ClientId LIKE '%\_%';

select *from fruto where arbol_idarbol REGEXP 'D'; -- me busca todas
select *from observacion where arbol_idarbol REGEXP 'D03'; -- las de ese año
select *from fruto where arbol_idarbol REGEXP 'D00_015';  -- esas especifica

select *from caracter_arbol where arbol_idarbol REGEXP 'D00_015'; 



