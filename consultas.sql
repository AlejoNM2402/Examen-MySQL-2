	use pizzeriaDB;

SELECT p.nombre, p.categoria, SUM(pp.cantidad) AS total_vendidos
FROM ProductoPedido pp
JOIN Producto p ON pp.Producto_id = p.id
GROUP BY p.id
ORDER BY total_vendidos DESC;

SELECT c.nombre, SUM(cp.cantidad * c.precio) AS ingresos_totales
FROM ComboPedido cp
JOIN Combo c ON cp.Combo_id = c.id
GROUP BY c.id;

SELECT modalidadPedido, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY modalidadPedido;

SELECT a.nombre, SUM(ap.cantidad) AS total_solicitada
FROM AdicionalesPedido ap
JOIN Adicionales a ON ap.Adicionales_id = a.id
GROUP BY a.id
ORDER BY total_solicitada DESC;

SELECT p.categoria, SUM(pp.cantidad) AS total_vendidos
FROM ProductoPedido pp
JOIN Producto p ON pp.Producto_id = p.id
GROUP BY p.categoria;

SELECT c.nombre, AVG(t.pizza_count) AS promedio_pizzas
FROM clientes c
JOIN (
    SELECT pe.clientes_id, COUNT(*) AS pizza_count
    FROM pedido pe
    JOIN ProductoPedido pp ON pp.pedido_id = pe.id
    JOIN Producto pr ON pr.id = pp.Producto_id
    WHERE pr.categoria = 'pizza'
    GROUP BY pe.clientes_id
) t ON c.id = t.clientes_id
GROUP BY c.id;

SELECT DAYNAME(fecha) AS dia_semana, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY dia_semana;

SELECT SUM(ap.cantidad) AS total_con_extra_queso
FROM AdicionalesPedido ap
JOIN Adicionales a ON ap.Adicionales_id = a.id
WHERE a.nombre = 'extra queso';

SELECT DISTINCT cp.pedido_id
FROM CombosProductos cbp
JOIN Producto p ON cbp.Producto_id = p.id
JOIN ComboPedido cp ON cbp.Combo_id = cp.Combo_id
WHERE p.categoria = 'bebida';

SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM clientes c
JOIN pedido p ON c.id = p.clientes_id
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.id
HAVING total_pedidos > 5;

SELECT SUM(p.precio * pp.cantidad) AS ingresos_no_elaborados
FROM Producto p
JOIN ProductoPedido pp ON p.id = pp.Producto_id
WHERE p.elaborado = 'no';

SELECT AVG(cant) AS promedio_adiciones
FROM (
    SELECT pedido_id, SUM(cantidad) AS cant
    FROM AdicionalesPedido
    GROUP BY pedido_id
) t;

SELECT SUM(cp.cantidad) AS total_combos
FROM ComboPedido cp
JOIN pedido p ON cp.pedido_id = p.id
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

SELECT c.nombre
FROM clientes c
JOIN pedido p ON c.id = p.clientes_id
GROUP BY c.id
HAVING SUM(p.modalidadPedido = 'para recoger') > 0
AND SUM(p.modalidadPedido = 'para llevar') > 0;

SELECT COUNT(DISTINCT pedido_id) AS pedidos_con_adiciones
FROM AdicionalesPedido;

SELECT pedido_id, COUNT(DISTINCT Producto_id) AS productos_diferentes
FROM ProductoPedido
GROUP BY pedido_id
HAVING productos_diferentes > 3;

SELECT AVG(total_dia) AS promedio_diario
FROM (
    SELECT DATE(p.fecha) AS fecha_dia, SUM(pr.precio * pp.cantidad) AS total_dia
    FROM pedido p
    JOIN ProductoPedido pp ON p.id = pp.pedido_id
    JOIN Producto pr ON pp.Producto_id = pr.id
    GROUP BY fecha_dia
) t;

SELECT c.nombre
FROM clientes c
JOIN pedido p ON c.id = p.clientes_id
LEFT JOIN AdicionalesPedido a ON p.id = a.pedido_id
JOIN ProductoPedido pp ON p.id = pp.pedido_id
JOIN Producto pr ON pp.Producto_id = pr.id
WHERE pr.categoria = 'pizza'
GROUP BY c.id
HAVING SUM(a.Adicionales_id IS NOT NULL) / COUNT(DISTINCT p.id) > 0.5;

SELECT ROUND(
    (SELECT SUM(p.precio * pp.cantidad)
     FROM Producto p
     JOIN ProductoPedido pp ON p.id = pp.Producto_id
     WHERE p.elaborado = 'no') / 
    (SELECT SUM(p.precio * pp.cantidad)
     FROM Producto p
     JOIN ProductoPedido pp ON p.id = pp.Producto_id) * 100, 2
) AS porcentaje_no_elaborado;

SELECT DAYNAME(fecha) AS dia, COUNT(*) AS total
FROM pedido
WHERE modalidadPedido = 'para recoger'
GROUP BY dia
ORDER BY total DESC
LIMIT 1;
