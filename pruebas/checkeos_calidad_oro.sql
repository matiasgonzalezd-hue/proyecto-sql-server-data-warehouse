/*
===============================================================================
Controles de Calidad
===============================================================================
Propósito del Script:
    Este script realiza controles de calidad para validar la integridad,
    consistencia y precisión de la Capa Oro. Estas validaciones aseguran:
    - Unicidad de las claves sustitutas en las tablas de dimensiones.
    - Integridad referencial entre las tablas de hechos y dimensiones.
    - Validación de las relaciones del modelo de datos con fines analíticos.

Notas de Uso:
    - Investigar y corregir cualquier discrepancia encontrada durante las validaciones.
===============================================================================
*/

-- ====================================================================
-- Validando 'oro.dim_cliente'
-- ====================================================================
-- Validar unicidad de la clave de cliente en oro.dim_cliente
-- Resultado esperado: Sin resultados
SELECT 
    cliente_key,
    COUNT(*) AS conteo_duplicados
FROM oro.dim_cliente
GROUP BY cliente_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Validando 'oro.producto_key'
-- ====================================================================
-- Validar unicidad de la clave de producto en oro.dim_producto
-- Resultado esperado: Sin resultados
SELECT 
    producto_key,
    COUNT(*) AS conteo_duplicados
FROM oro.dim_producto
GROUP BY producto_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Validando 'oro.fact_ventas'
-- ====================================================================
-- Validar la conectividad del modelo de datos entre la tabla de hechos y las dimensiones
SELECT * 
FROM oro.fact_ventas f
LEFT JOIN oro.dim_cliente c
ON c.cliente_key = f.cliente_key
LEFT JOIN oro.dim_products p
ON p.producto_key = f.producto_key
WHERE p.producto_key IS NULL OR c.cliente_key IS NULL;
