use pizzeriaDB;

-- Saber cuales son los productos que mas se venden
select p.nombre, p.categoria, sum(pp.cantidad) as tota_vendidos
from ProductoPedido pp
join Producto p on pp.Producto_id = p.id
group by p.id
order by total_vendidos desc;

-- Total de ingresos generados por cada combo
select c.nombre, sum (cp.cantidad * c.precio) as ingresos_totales
from ComboPedido cp
join combo c on cp.Combo_id = c.id
group by c.id;

-- Pedidos para recoger o para llevar
SELECT modalidadPedido, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY modalidadPedido;

-- Adiciones más vendidas
SELECT A.nombre, SUM(AP.cantidad) AS total_solicitada
FROM AdicionalesPedido AP
JOIN Adicionales A ON AP.Adicionales_id = A.id
GROUP BY A.id
ORDER BY total_solicitada DESC;

-- Cantidad total de productos vendidos por categoría
SELECT P.categoria, SUM(PP.cantidad) AS total_vendidos
FROM ProductoPedido PP
JOIN Producto P ON PP.Producto_id = P.id
GROUP BY P.categoria;

-- Promedio de las pizzas por cliente
SELECT c.nombre, AVG(pizza_count) AS promedio_pizzas
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

-- Total de ventas diarias a la semana
SELECT DAYNAME(fecha) AS dia_semana, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY dia_semana;

-- Cantidad de panzarottis vendidas con extra queso
SELECT SUM(AP.cantidad) AS total_con_extra_queso
FROM AdicionalesPedido AP
JOIN Adicionales A ON AP.Adicionales_id = A.id
WHERE A.nombre = 'extra queso';

-- Pedidos con bebida en combos
SELECT DISTINCT CP.pedido_id
FROM CombosProductos CBP
JOIN Producto P ON CBP.Producto_id = P.id
JOIN ComboPedido CP ON CBP.Combo_id = CP.Combo_id
WHERE P.categoria = 'bebida';

-- Clientes que han hecho mas de 5 pedidos en los ultimos meses
SELECT c.nombre, COUNT(p.id) AS total_pedidos
FROM clientes c
JOIN pedido p ON c.id = p.clientes_id
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY c.id
HAVING total_pedidos > 5;

-- Ingresos totales por productos no elaborados
SELECT SUM(P.precio * PP.cantidad) AS ingresos_no_elaborados
FROM Producto P
JOIN ProductoPedido PP ON P.id = PP.Producto_id
WHERE P.elaborado = 'no';

-- Promedio de adiciones que se piden por pedido
SELECT AVG(cant) AS promedio_adiciones
FROM (
    SELECT pedido_id, SUM(cantidad) AS cant
    FROM AdicionalesPedido
    GROUP BY pedido_id
) t;

-- Combos vendidos en el ultimo mes
SELECT SUM(cantidad) AS total_combos
FROM ComboPedido
JOIN pedido ON ComboPedido.pedido_id = pedido.id
WHERE pedido.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Clientes con pedidos para recoger y para llevar
SELECT c.nombre
FROM clientes c
JOIN pedido p ON c.id = p.clientes_id
GROUP BY c.id
HAVING SUM(p.modalidadPedido = 'para recoger') > 0
   AND SUM(p.modalidadPedido = 'para llevar') > 0;

-- Total de productos personalizados con adiciones
SELECT COUNT(DISTINCT pedido_id) AS pedidos_con_adiciones
FROM AdicionalesPedido;

-- Pedidos con más de 3 productos diferentes
SELECT pedido_id, COUNT(DISTINCT Producto_id) AS productos_diferentes
FROM ProductoPedido
GROUP BY pedido_id
HAVING productos_diferentes > 3;

-- Promedio de ingresos generados por día
SELECT AVG(total_dia) AS promedio_diario
FROM (
    SELECT DATE(fecha) AS fecha_dia, SUM(P.precio * PP.cantidad) AS total_dia
    FROM pedido
    JOIN ProductoPedido PP ON pedido.id = PP.pedido_id
    JOIN Producto P ON PP.Producto_id = P.id
    GROUP BY fecha_dia
) t;

-- Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos
SELECT c.nombre
FROM clientes c
JOIN pedido p ON c.id = p.clientes_id
LEFT JOIN AdicionalesPedido a ON p.id = a.pedido_id
JOIN ProductoPedido pp ON p.id = pp.pedido_id
JOIN Producto pr ON pp.Producto_id = pr.id
WHERE pr.categoria = 'pizza'
GROUP BY c.id
HAVING SUM(a.Adicionales_id IS NOT NULL) / COUNT(DISTINCT p.id) > 0.5;

-- Porcentaje de ventas provenientes de productos no elaborados
SELECT 
  ROUND(
    (SELECT SUM(P.precio * PP.cantidad)
     FROM Producto P
     JOIN ProductoPedido PP ON P.id = PP.Producto_id
     WHERE P.elaborado = 'no') 
    / 
    (SELECT SUM(P.precio * PP.cantidad)
     FROM Producto P
     JOIN ProductoPedido PP ON P.id = PP.Producto_id)
    * 100, 2
  ) AS porcentaje_no_elaborado;

-- Día con más pedidos para recoger
SELECT DAYNAME(fecha) AS dia, COUNT(*) AS total
FROM pedido
WHERE modalidadPedido = 'para recoger'
GROUP BY dia
ORDER BY total DESC
LIMIT 1;
