use pizzeriaDB;

insert into clientes(nombre, telefono)
values
('Alejandro', '3124256856'),
('Felipe', '3124332453'),
('Jhaider', '3124662873'),
('Fredy', '3112457895');

insert into pedido(fecha, metodoPago, modalidadPedido, clientes_id)
values
('2025-05-07', 'efectivo', 'para llevar', 1),
('2025-05-10', 'tarjeta', 'para llevar', 2),
('2025-06-01', 'transferencia', 'para recoger', 3),
('2025-06-20', 'efectivo', 'para llevar', 1);

insert into Producto(nombre, precio, categoria, elaborado, disponible)
values
('pizza carnes' , 10, 'pizza', 'si', 'si'),
('panzarottis' , 12, 'pizza', 'si', 'no'),
('coca-cola' , 2, 'bebida', 'no', 'si'),
('patacones' , 5, 'entrada', 'si', 'si');

insert into Combo(nombre, descripcion, precio)
values
('FullHouse','pizza medio carne, medio vegetariana, con bevida de preferencia y cualquier entrada', 30),
('SuperHot','pizza mexicana super picante con todas las adiciones picantes', 20),
('DulceFuerte','coctel de ron con cocacola', 12),
('AmericanMix','pizza de carnes con todas las adiciones de carnes y cualquier entrada', 40);


insert into Ingredientes(nombre, cantidad)
values
('tomate', '100'),
('cebolla', '110'),
('peperoni', '30'),
('habaneros', '100');

insert into Adicionales(nombre, precio)
values
('papas', 3),
('salsas', 2),
('patacones', 3),
('extra queso', 5);

insert into ProductoPedido(Producto_id, pedido_id, cantidad)
values
(1, 2, 3),
(1, 2, 1),
(2, 3, 2),
(3, 1, 2);

insert into ComboPedido(Combo_id, pedido_id, cantidad)
values
(1, 2, 12),
(3, 1, 10),
(3, 1, 15),
(2, 1, 20);

insert into AdicionalesPedido(pedido_id, Adicionales_id, cantidad)
values
(1, 2, 13),
(2, 3, 14),
(1, 3, 22),
(3, 2, 16);

insert into Ingredientes_has_Producto(Ingredientes_id, Producto_id)
values
(1, 2),
(3, 2),
(4, 2), 
(1, 3);

insert into CombosProductos(Cantidad, Producto_id, Combo_id)
values
(12, 1, 3),
(35, 2, 1),
(18, 3, 4),
(22, 3, 1);




