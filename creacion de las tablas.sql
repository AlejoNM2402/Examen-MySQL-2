create database if not exists pizzeriaDB;

use pizzeriaDB;

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  telefono VARCHAR(15)
);

CREATE TABLE pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fecha DATETIME,
  metodoPago ENUM('efectivo', 'tarjeta', 'transferencia'),
  modalidadPedido ENUM('para recoger', 'para llevar'),
  clientes_id INT,
  FOREIGN KEY (clientes_id) REFERENCES clientes(id)
);

CREATE TABLE Producto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(60),
  precio INT,
  categoria ENUM('pizza', 'bebida', 'entrada'),
  elaborado ENUM('si', 'no'),
  disponible ENUM('si', 'no')
);

CREATE TABLE Combo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45),
  descripcion VARCHAR(150),
  precio INT
);

CREATE TABLE Ingredientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  cantidad VARCHAR(10)
);

CREATE TABLE Adicionales (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(45),
  precio INT
);

CREATE TABLE ProductoPedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  Producto_id INT,
  pedido_id INT,
  cantidad INT,
  FOREIGN KEY (Producto_id) REFERENCES Producto(id),
  FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

CREATE TABLE ComboPedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  Combo_id INT,
  pedido_id INT,
  cantidad INT,
  FOREIGN KEY (Combo_id) REFERENCES Combo(id),
  FOREIGN KEY (pedido_id) REFERENCES pedido(id)
);

CREATE TABLE AdicionalesPedido (
  pedido_id INT,
  Adicionales_id INT,
  cantidad INT,
  PRIMARY KEY (pedido_id, Adicionales_id),
  FOREIGN KEY (pedido_id) REFERENCES pedido(id),
  FOREIGN KEY (Adicionales_id) REFERENCES Adicionales(id)
);

CREATE TABLE Ingredientes_has_Producto (
  Ingredientes_id INT,
  Producto_id INT,
  id INT AUTO_INCREMENT PRIMARY KEY,
  FOREIGN KEY (Ingredientes_id) REFERENCES Ingredientes(id),
  FOREIGN KEY (Producto_id) REFERENCES Producto(id)
);

CREATE TABLE CombosProductos (
  idCombosProductos INT AUTO_INCREMENT PRIMARY KEY,
  cantidad INT,
  Producto_id INT,
  Combo_id INT,
  FOREIGN KEY (Producto_id) REFERENCES Producto(id),
  FOREIGN KEY (Combo_id) REFERENCES Combo(id)
);
