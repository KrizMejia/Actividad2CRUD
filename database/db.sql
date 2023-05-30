CREATE DATABASE inventario_merca_facil;
USE inventario_merca_facil;
CREATE TABLE Proveedores (
  Prov_NIT VARCHAR(50) NOT NULL PRIMARY KEY,
  Prov_Nombre VARCHAR(50) NOT NULL,
  Prov_Direccion VARCHAR(100) NOT NULL,
  Prov_Telefono VARCHAR(20) NOT NULL
);

CREATE TABLE Proveedores (
  Prov_NIT VARCHAR(50) NOT NULL PRIMARY KEY,
  Prov_Nombre VARCHAR(50) NOT NULL,
  Prov_Direccion VARCHAR(100) NOT NULL,
  Prov_Telefono VARCHAR(20) NOT NULL
);


CREATE TABLE Grupos (
  Grp_Codigo INT NOT NULL PRIMARY KEY,
  Grp_Descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE Articulos (
  Art_Codigo INT NOT NULL PRIMARY KEY,
  Art_Nombre VARCHAR(50) NOT NULL,
  Art_UnidadMedida VARCHAR(20) NOT NULL,
  Art_Existencia INT NOT NULL,
  Art_CantMaxima INT NOT NULL,
  Art_CantMinima INT NOT NULL
);

CREATE TABLE Clientes (
  Cli_Cedula VARCHAR(15) NOT NULL PRIMARY KEY,
  Cli_Nombre VARCHAR(100) NOT NULL,
  Cli_Direccion VARCHAR(100) NOT NULL,
  Cli_Telefono VARCHAR(20) NOT NULL
);



CREATE TABLE Almacenes (
  Alm_Codigo INT NOT NULL PRIMARY KEY,
  Alm_Nombre VARCHAR(50) NOT NULL,
  Alm_Direccion VARCHAR(100) NOT NULL,
  Alm_Gerente VARCHAR(50) NOT NULL
);

CREATE TABLE Compras (
  Comp_NumFactura INT NOT NULL PRIMARY KEY,
  Comp_Fecha DATE NOT NULL,
  Comp_ValorTotal FLOAT NULL,
  Comp_Tipo VARCHAR(10) NOT NULL,
  Comp_Proveedor VARCHAR(50) NOT NULL,
  Comp_Almacen INT NOT NULL,
  FOREIGN KEY (Comp_Proveedor) REFERENCES Proveedores(Prov_NIT),
  FOREIGN KEY (Comp_Almacen) REFERENCES Almacenes(Alm_Codigo)
);

CREATE TABLE DetallesCompras (
  DtComp_NumFactura INT NOT NULL,
  DtComp_Articulo INT NOT NULL,
  DtComp_Cantidad INT NOT NULL,
  DtComp_Valor FLOAT NOT NULL,
  PRIMARY KEY (DtComp_NumFactura, DtComp_Articulo),
  FOREIGN KEY (DtComp_NumFactura) REFERENCES Compras(Comp_NumFactura),
  FOREIGN KEY (DtComp_Articulo) REFERENCES Articulos(Art_Codigo)
);

CREATE TABLE PreciosArticulo (
  PrArt_Codigo INT NOT NULL,
  PrArt_Precio FLOAT NOT NULL,
  PrArt_Descripcion VARCHAR(50),
  PRIMARY KEY (PrArt_Codigo, PrArt_Descripcion),
  FOREIGN KEY (PrArt_Codigo) REFERENCES Articulos(Art_Codigo)
);

CREATE TABLE Ventas (
  Vent_NumFactura INT NOT NULL PRIMARY KEY,
  Vent_Fecha DATE NOT NULL,
  Vent_ValorTotal FLOAT NULL,
  Vent_Tipo VARCHAR(10) NOT NULL,
  Vent_Cliente VARCHAR(15) NOT NULL,
  Vent_Almacen INT NOT NULL,
  FOREIGN KEY (Vent_Cliente) REFERENCES Clientes(Cli_Cedula),
  FOREIGN KEY (Vent_Almacen) REFERENCES Almacenes(Alm_Codigo)
);

CREATE TABLE DetallesVentas (
  DtVent_NumFactura INT NOT NULL,
  DtVent_Articulo INT NOT NULL,
  DtVent_Cantidad INT NOT NULL,
  DtVent_Valor FLOAT NOT NULL,
  PRIMARY KEY (DtVent_NumFactura, DtVent_Articulo),
  FOREIGN KEY (DtVent_NumFactura) REFERENCES Ventas(Vent_NumFactura),
  FOREIGN KEY (DtVent_Articulo) REFERENCES Articulos(Art_Codigo)
);

CREATE TABLE PedidosProveedores (
  PedProv_NumPedido INT NOT NULL PRIMARY KEY,
  PedProv_Fecha DATE NOT NULL,
  PedProv_Proveedor VARCHAR(50) NOT NULL,
  PedProv_Articulo INT NOT NULL,
  PedProv_Cantidad INT NOT NULL,
  PedProv_ValorPedido INT NOT NULL,
  FOREIGN KEY (PedProv_Proveedor) REFERENCES Proveedores(Prov_NIT),
  FOREIGN KEY (PedProv_Articulo) REFERENCES Articulos(Art_Codigo)
);

CREATE TABLE ArticulosGrupos (
  ArtGrup_CodigoArticulo INT NOT NULL,
  ArtGrup_CodigoGrupo INT NOT NULL,
  PRIMARY KEY (ArtGrup_CodigoArticulo, ArtGrup_CodigoGrupo),
  FOREIGN KEY (ArtGrup_CodigoArticulo) REFERENCES Articulos(Art_Codigo),
  FOREIGN KEY (ArtGrup_CodigoGrupo) REFERENCES Grupos(Grp_Codigo)
);

CREATE TABLE ArticulosProveedores (
  ArtProv_CodigoArticulo INT NOT NULL,
  ArtProv_NITProveedor VARCHAR(50) NOT NULL,
  ArtProv_PrecioProveedor INT NOT NULL,
  PRIMARY KEY (ArtProv_CodigoArticulo, ArtProv_NITProveedor),
  FOREIGN KEY (ArtProv_CodigoArticulo) REFERENCES Articulos(Art_Codigo),
  FOREIGN KEY (ArtProv_NITProveedor) REFERENCES Proveedores(Prov_NIT)
);


INSERT INTO grupos VALUES
(101012, "Electrodomésticos"),
(141412, "Aparatos de cocina"),
(744562, "Audio y video"),
(996521, "Cárnicos"),
(995412, "Embutidos");

INSERT INTO articulos VALUES 
(1010, "Olla Expréss Imusa", "Capacidad Lt", 150, 100, 300),
(1012, "Carne molida", "Libra", 100, 50, 160),
(1014, "Salchicha vienesa", "Unidades x lata", 300, 100, 450),
(1016, "Reproductor de DVD", "N/A", 10, 20, 60),
(1018, "Licuadora Samurai", "Capacidad Lt", 83, 50, 300);

INSERT INTO clientes VALUES 
("1024567454", "Rafael Alberto López", "Cra 45 C # 75-57", "3012922145"),
("1010124485", "Ana María Rico Sierra", "Cll 65 Sur # 11-50", "3145458624"),
("1020458545", "Cristian Mejía Iglesias", "Cra 24 # 56-45", "3102458796"),
("36279680", "Angela Patricia Aragón", "Tv. 52 Sur # 25-45", "3014579633"),
("56854125", "Hilary Farfán Parra", "Cll 6 # 11-54 Apto 204", "3008795462");

INSERT INTO Almacenes VALUES 
(1, "Merca Fácil - Sede Norte", "Calle 123 # 45 - 67", "Pedro González"),
(2, "Merca Fácil - Sede Sur", "Carrera 56 # 78 - 90", "María Rodríguez"),
(3, "Merca Fácil - Sede Este", "Avenida 12 # 34 - 56", "Juan Pérez"),
(4, "Merca Fácil - Sede Oeste", "Calle 45 # 67 - 89", "Ana Gómez"),
(5, "Merca Fácil - Sede Centro", "Carrera 89 # 12 - 34", "Luisa Ramírez");

INSERT INTO articulosproveedores VALUES
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'),(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir'), 8000),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'),(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Distribuciones Hernández y Cia.'), 40000),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'),(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir'), 3500),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'),(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Nacional de distribuidoras'), 65000),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'),(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='El Embalse LTDA'), 75000);

INSERT INTO Compras VALUES 
(1001, '2023-05-01', NULL, 'Contado', (SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir'), (SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Norte')),
(1002, '2023-05-02', NULL, 'Crédito', (SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Distribuciones Hernández y Cia.'), (SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Sur')),
(1003, '2023-05-03', NULL, 'Contado', (SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Nacional de distribuidoras'), (SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Este')),
(1004, '2023-05-04', NULL, 'Crédito', (SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='El Embalse LTDA'), (SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Oeste')),
(1005, '2023-05-05', NULL, 'Contado', (SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir'), (SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Centro'));

INSERT INTO detallescompras 
VALUES 
		(1001, 
        (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'), 
        10, 
        ((SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Comp_Proveedor FROM compras WHERE Comp_NumFactura=1001) AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'))) * 10),

		(1001, 
        (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'), 
        20, 
        ((SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Comp_Proveedor FROM compras WHERE Comp_NumFactura=1001) AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'))) * 20),
        
        (1002, 
        (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'), 
        15, 
        ((SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Comp_Proveedor FROM compras WHERE Comp_NumFactura=1002) AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'))) * 15),
        
        (1003, 
        (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'), 
        25, 
        ((SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Comp_Proveedor FROM compras WHERE Comp_NumFactura=1003) AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'))) * 25),
        
        (1004, 
        (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'), 
        12, 
        ((SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Comp_Proveedor FROM compras WHERE Comp_NumFactura=1004) AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'))) * 12),

			(1005, 
        (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'), 
        30, 
        ((SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Comp_Proveedor FROM compras WHERE Comp_NumFactura=1005) AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'))) * 30);
        


UPDATE Compras
SET Comp_ValorTotal = (SELECT SUM(DtComp_Valor) FROM detallescompras WHERE DtComp_NumFactura = 1001)
WHERE Comp_NumFactura = 1001;

UPDATE Compras
SET Comp_ValorTotal = (SELECT SUM(DtComp_Valor) FROM detallescompras WHERE DtComp_NumFactura = 1002)
WHERE Comp_NumFactura = 1002;

UPDATE Compras
SET Comp_ValorTotal = (SELECT SUM(DtComp_Valor) FROM detallescompras WHERE DtComp_NumFactura = 1003)
WHERE Comp_NumFactura = 1003;

UPDATE Compras
SET Comp_ValorTotal = (SELECT SUM(DtComp_Valor) FROM detallescompras WHERE DtComp_NumFactura = 1004)
WHERE Comp_NumFactura = 1004;


INSERT INTO preciosarticulo VALUES
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'), 12000, 'Al detal'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'), (12000- (12000*20/100)), 'Desc. 20%'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'), 70000, 'Al detal'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'), 70000 - (70000*15/100), 'Por mayor (Sup. 10 unidades)'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'), 5500, 'Al detal'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'), 5500 - (5500*7/100), 'Jueves de descuentos'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'), 90000, 'Al detal'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'), 100000, 'Al detal'),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'), 100000 - (100000*20/100), 'Mercaniversario');


INSERT INTO ventas VALUES
(2001, '2022-10-12', NULL, 'Contado',(SELECT Cli_Cedula FROM clientes WHERE Cli_Nombre='Rafael Alberto López'),(SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Norte')),
(2002, '2022-09-25', NULL, 'Contado',(SELECT Cli_Cedula FROM clientes WHERE Cli_Nombre='Ana María Rico Sierra'),(SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Sur')),
(2003, '2022-07-20', NULL, 'Crédito',(SELECT Cli_Cedula FROM clientes WHERE Cli_Nombre='Angela Patricia Aragón'),(SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Este')),
(2004, '2022-05-15', NULL, 'Contado',(SELECT Cli_Cedula FROM clientes WHERE Cli_Nombre='Cristian Mejía Iglesias'),(SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Sur')),
(2005, '2022-02-07', NULL, 'Contado',(SELECT Cli_Cedula FROM clientes WHERE Cli_Nombre='Rafael Alberto López'),(SELECT Alm_Codigo FROM Almacenes WHERE Alm_Nombre='Merca Fácil - Sede Norte'));


INSERT INTO detallesventas VALUES
(2001, (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'),3,(SELECT PrArt_Precio FROM preciosarticulo WHERE PrArt_Codigo = (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida') AND PrArt_Descripcion='Al detal')*3),
(2002, (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'),11,(SELECT PrArt_Precio FROM preciosarticulo WHERE PrArt_Codigo = (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa') AND PrArt_Descripcion='Por mayor (Sup. 10 unidades)')*11),
(2003, (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'),1,(SELECT PrArt_Precio FROM preciosarticulo WHERE PrArt_Codigo = (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai') AND PrArt_Descripcion='Mercaniversario')*1),
(2003, (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'),1,(SELECT PrArt_Precio FROM preciosarticulo WHERE PrArt_Codigo = (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD') AND PrArt_Descripcion='Al detal')*1),
(2004, (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'),3,(SELECT PrArt_Precio FROM preciosarticulo WHERE PrArt_Codigo = (SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa') AND PrArt_Descripcion='Al detal')*3);

UPDATE ventas
SET Vent_ValorTotal = (SELECT SUM(DtVent_Valor) FROM detallesventas WHERE DtVent_NumFactura = 2001)
WHERE Vent_NumFactura = 2001;

UPDATE ventas
SET Vent_ValorTotal = (SELECT SUM(DtVent_Valor) FROM detallesventas WHERE DtVent_NumFactura = 2002)
WHERE Vent_NumFactura = 2002;

UPDATE ventas
SET Vent_ValorTotal = (SELECT SUM(DtVent_Valor) FROM detallesventas WHERE DtVent_NumFactura = 2003)
WHERE Vent_NumFactura = 2003;

UPDATE ventas
SET Vent_ValorTotal = (SELECT SUM(DtVent_Valor) FROM detallesventas WHERE DtVent_NumFactura = 2004)
WHERE Vent_NumFactura = 2004;

INSERT INTO pedidosproveedores VALUES
(4001,'2020-10-16',(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir'),(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'),30,(SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir') AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'))*30),
(4002,'2020-11-12',(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Distribuciones Hernández y Cia.'),(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'),45,(SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Distribuciones Hernández y Cia.') AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'))*45),
(4003,'2020-09-08',(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='El Embalse LTDA'),(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'),50,(SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='El Embalse LTDA') AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'))*50),
(4004,'2020-07-05',(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Nacional de distribuidoras'),(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'),20,(SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Nacional de distribuidoras') AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'))*20),
(4005,'2020-05-25',(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir'),(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'),60,(SELECT ArtProv_PrecioProveedor FROM articulosproveedores WHERE ArtProv_NITProveedor=(SELECT Prov_NIT FROM Proveedores WHERE Prov_Nombre='Alimentos Porvenir') AND ArtProv_CodigoArticulo=(SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'))*60);

INSERT INTO articulosgrupos VALUES
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Carne molida'),(SELECT Grp_Codigo FROM grupos WHERE Grp_Descripcion = 'Cárnicos')),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Olla Expréss Imusa'),(SELECT Grp_Codigo FROM grupos WHERE Grp_Descripcion = 'Aparatos de cocina')),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'),(SELECT Grp_Codigo FROM grupos WHERE Grp_Descripcion = 'Aparatos de cocina')),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Licuadora Samurai'),(SELECT Grp_Codigo FROM grupos WHERE Grp_Descripcion = 'Electrodomésticos')),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'),(SELECT Grp_Codigo FROM grupos WHERE Grp_Descripcion = 'Electrodomésticos')),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Reproductor de DVD'),(SELECT Grp_Codigo FROM grupos WHERE Grp_Descripcion = 'Audio y video')),
((SELECT Art_Codigo FROM articulos WHERE Art_Nombre='Salchicha vienesa'),(SELECT Grp_Codigo FROM grupos WHERE Grp_Descripcion = 'Embutidos'));



-- Subconsulta
SELECT
    Vent_NumFactura AS Factura,
    GROUP_CONCAT(DISTINCT Art_Nombre SEPARATOR ', ') AS Artículos,
    GROUP_CONCAT(DISTINCT gr.Grp_Descripcion SEPARATOR ', ') AS Grupo,
    Alm_Nombre AS Almacén,
    Cli_Nombre AS Cliente,
    Vent_ValorTotal AS Valor_Total,
    Vent_Fecha AS Fecha
FROM 
    articulos AS art
    INNER JOIN articulosgrupos AS artgr ON artgr.ArtGrup_CodigoArticulo=art.Art_Codigo
    INNER JOIN grupos AS gr ON gr.Grp_Codigo = artgr.ArtGrup_CodigoGrupo
    INNER JOIN detallesventas AS dtven ON dtven.DtVent_Articulo=art.Art_Codigo
    INNER JOIN ventas AS vnt ON vnt.Vent_NumFactura=dtven.DtVent_NumFactura
    INNER JOIN clientes AS cli ON vnt.Vent_Cliente=cli.Cli_Cedula
    INNER JOIN almacenes AS alm ON alm.Alm_Codigo=vnt.Vent_Almacen
WHERE 
    art.Art_Nombre="Licuadora Samurai" OR art.Art_Nombre="Salchicha vienesa" OR art.Art_Nombre="Reproductor de DVD"
GROUP BY 
    Vent_NumFactura, Cli_Nombre;

-- Vista

CREATE VIEW ArticulosVendidos
AS
SELECT
    Vent_NumFactura AS Factura,
    GROUP_CONCAT(DISTINCT Art_Nombre SEPARATOR ', ') AS Artículos,
    GROUP_CONCAT(DISTINCT gr.Grp_Descripcion SEPARATOR ', ') AS Grupo,
    Alm_Nombre AS Almacén,
    Cli_Nombre AS Cliente,
    Vent_ValorTotal AS Valor_Total,
    Vent_Fecha AS Fecha
FROM 
    articulos AS art
    INNER JOIN articulosgrupos AS artgr ON artgr.ArtGrup_CodigoArticulo=art.Art_Codigo
    INNER JOIN grupos AS gr ON gr.Grp_Codigo = artgr.ArtGrup_CodigoGrupo
    INNER JOIN detallesventas AS dtven ON dtven.DtVent_Articulo=art.Art_Codigo
    INNER JOIN ventas AS vnt ON vnt.Vent_NumFactura=dtven.DtVent_NumFactura
    INNER JOIN clientes AS cli ON vnt.Vent_Cliente=cli.Cli_Cedula
    INNER JOIN almacenes AS alm ON alm.Alm_Codigo=vnt.Vent_Almacen
GROUP BY 
    Vent_NumFactura, Cli_Nombre;