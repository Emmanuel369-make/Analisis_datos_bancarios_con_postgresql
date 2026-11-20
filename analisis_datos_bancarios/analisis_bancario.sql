SELECT * FROM public.transacciones_banco
ORDER BY id_transaccion ASC LIMIT 100

SELECT COUNT(*) FROM public.transacciones_banco

/*
1 ¿Cuántas transacciones y cuánto dinero total hay por banco, considerando solo las aprobadas?
2 ¿Cuál es el monto promedio por tipo de transacción y por canal?
3 ¿Cuál es el porcentaje de transacciones rechazadas por banco, y qué banco tiene la tasa más alta?
4 ¿Cuántas transacciones hubo por mes y cómo cambió el monto aprobado entre 2024 y 2025?
5 ¿Cuáles son las 10 sucursales con mayor monto total aprobado y a qué ciudad pertenecen?
6 ¿Cuáles son los 10 clientes con mayor monto total aprobado y cuántas transacciones tiene cada uno?
7 ¿Qué canal concentra más transacciones en cada ciudad?
8 ¿Cuántos clientes tienen más de 10 transacciones y cuál es el monto promedio de esos clientes frente al resto?
9 ¿Cuántas transacciones superan los 2,000,000 COP, y cuántas de ellas fueron rechazadas o quedaron pendientes?
10 ¿Qué clientes hicieron transacciones en más de un banco o en más de una ciudad, y cuántos son?
*/

-- 1 ¿Cuántas transacciones y cuánto dinero total hay por banco, considerando solo las aprobadas?
SELECT 
    banco,
    COUNT(*) AS cantidad_transacciones,
    SUM(monto) AS dinero_total
FROM public.transacciones_banco
WHERE estado = 'Aprobada'
GROUP BY banco
ORDER BY dinero_total DESC;

-- 2 ¿Cuál es el monto promedio por tipo de transacción y por canal?
-- monto promedio por tipo de transacción
SELECT tipo_transaccion, ROUND(AVG(monto),2) AS Promedio_monto_por_tipo_transaccion
FROM public.transacciones_banco
GROUP BY tipo_transaccion
ORDER BY Promedio_monto_por_tipo_transaccion DESC

-- monto promedio por canal
SELECT canal, ROUND(AVG(monto),2) AS Promedio_monto_por_canal
FROM public.transacciones_banco
GROUP BY canal
ORDER BY Promedio_monto_por_canal DESC

-- 3 ¿Cuál es el porcentaje de transacciones rechazadas por banco, y qué banco tiene la tasa más alta?
SELECT
    banco,
    COUNT(*) FILTER (WHERE estado = 'Rechazada') AS rechazadas,
    COUNT(*) AS total,
    ROUND(100.0 * COUNT(*) FILTER (WHERE estado = 'Rechazada') / COUNT(*),2) AS pct_rechazo
FROM public.transacciones_banco
WHERE banco IS NOT NULL
GROUP BY banco
ORDER BY pct_rechazo DESC;

-- 4 ¿Cuántas transacciones hubo por mes y cómo cambió el monto aprobado entre 2024 y 2025?
SELECT
    EXTRACT(MONTH FROM fecha) AS mes,
    COUNT(CASE WHEN EXTRACT(YEAR FROM fecha) = 2024 THEN 1 END) AS transacciones_2024,
    SUM(CASE WHEN EXTRACT(YEAR FROM fecha) = 2024 AND estado = 'Aprobada' THEN monto ELSE 0 END) AS monto_aprobado_2024,
    COUNT(CASE WHEN EXTRACT(YEAR FROM fecha) = 2025 THEN 1 END) AS transacciones_2025,
    SUM(CASE WHEN EXTRACT(YEAR FROM fecha) = 2025 AND estado = 'Aprobada' THEN monto ELSE 0 END) AS monto_aprobado_2025,
    -- Diferencia para ver el cambio
    SUM(CASE WHEN EXTRACT(YEAR FROM fecha) = 2025 AND estado = 'Aprobada' THEN monto ELSE 0 END)
  - SUM(CASE WHEN EXTRACT(YEAR FROM fecha) = 2024 AND estado = 'Aprobada' THEN monto ELSE 0 END) AS cambio_monto_aprobado
FROM public.transacciones_banco
WHERE EXTRACT(YEAR FROM fecha) IN (2024, 2025)
GROUP BY mes
ORDER BY mes;

-- 5 ¿Cuáles son las 10 sucursales con mayor monto total aprobado y a qué ciudad pertenecen?
SELECT sucursal, SUM(monto), ciudad
FROM public.transacciones_banco
WHERE estado = 'Aprobada'
GROUP BY sucursal, ciudad
ORDER BY SUM(monto) DESC
LIMIT 10;

-- 6 ¿Cuáles son los 10 clientes con mayor monto total aprobado y cuántas transacciones tiene cada uno?
SELECT nombre_cliente, SUM(monto), COUNT(*)
FROM public.transacciones_banco
WHERE estado = 'Aprobada'
GROUP BY nombre_cliente
ORDER BY SUM(monto) DESC
LIMIT 10;

-- 7 ¿Qué canal concentra más transacciones en cada ciudad?
SELECT ciudad, canal, total_transacciones
FROM(
    SELECT
	    ciudad,
		canal,
		COUNT(*) AS total_transacciones,
		ROW_NUMBER() OVER(PARTITION BY ciudad ORDER BY COUNT(*) DESC) AS rn
	FROM public.transacciones_banco
    GROUP BY ciudad, canal
) t
WHERE rn = 1;

-- 8 ¿Cuántos clientes tienen más de 10 transacciones y cuál es el monto promedio de esos clientes frente al resto?
SELECT 
     nombre_cliente, 
	 COUNT(*) AS total_transacciones, 
	 ROUND(AVG(monto),2) AS total_monto_promedio
FROM public.transacciones_banco
GROUP BY nombre_cliente
HAVING COUNT(*) >= 10
ORDER BY total_transacciones DESC;

--9 ¿Cuántas transacciones superan los 2,000,000 COP, y cuántas de ellas fueron rechazadas o quedaron pendientes?
SELECT
     SUM(CASE WHEN monto >= 2000000 THEN 1 ELSE 0 END)
FROM public.transacciones_banco;

-- rechasadas
SELECT
     SUM(CASE WHEN monto >= 2000000 AND estado = 'Rechazada'THEN 1 ELSE 0 END)
FROM public.transacciones_banco;

-- 10 ¿Qué clientes hicieron transacciones en más de un banco o en más de una ciudad, y cuántos son?

SELECT
  nombre_cliente,
  numero_documento,
  COUNT(DISTINCT banco) AS cantidad_bancos_distintos,
  COUNT(DISTINCT ciudad) AS cantidad_ciudades_distintas
FROM public.transacciones_banco
GROUP BY nombre_cliente, numero_documento
HAVING COUNT(DISTINCT banco) > 2
   OR COUNT(DISTINCT ciudad) > 2
ORDER BY cantidad_bancos_distintos DESC, cantidad_ciudades_distintas DESC;
