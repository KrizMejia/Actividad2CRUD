CREATE DATABASE inventario_merca_facil;
USE inventario_merca_facil;
CREATE TABLE Proveedores (
  Prov_NIT VARCHAR(50) NOT NULL PRIMARY KEY,
  Prov_Nombre VARCHAR(50) NOT NULL,
  Prov_Direccion VARCHAR(100) NOT NULL,
  Prov_Telefono VARCHAR(20) NOT NULL
);

SHOW TABLES;

describe Proveedores;