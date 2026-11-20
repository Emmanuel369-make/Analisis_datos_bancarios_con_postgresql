# Análisis de Datos de Transacciones Bancarias en Colombia (2024–2025)

> **Autor:** Emmanuel Rendon Vélez
> **Fecha:** Octubre 2026
> **Herramientas utilizadas:** PostgreSQL, Power BI

---

## 📌 Descripción del Proyecto

Este proyecto consiste en el análisis exploratorio y descriptivo de una base de datos ficticia de transacciones bancarias realizadas en Colombia durante los años 2024 y 2025. La base de datos contiene **6.500 registros** con información sobre montos, tipo de transacción, estado de aprobación, entidad bancaria, sucursal, ciudad, canal de transacción y datos de clientes.

El objetivo principal fue extraer información accionable mediante consultas SQL y visualizaciones interactivas, respondiendo preguntas clave sobre el comportamiento de las transacciones, desempeño por entidad bancaria, distribución geográfica, perfiles de clientes y tendencias temporales.

---

## 📂 Estructura del Repositorio

analisis_datos_bancarios/
├── dashboard/ # Archivo del tablero interactivo en Power BI
├── data/ # Conjunto de datos en formato CSV
├── images/ # Capturas de pantalla y visualizaciones del dashboard
├── analisis_bancario.sql # Código completo en PostgreSQL
└── informe_analisis_bancario.docx # Informe detallado con resultados y conclusiones


---

## 🔍 Preguntas de Investigación Respondidas

1. ¿Cuántas transacciones y cuánto dinero total hay por banco, considerando solo las aprobadas?
2. ¿Cuál es el monto promedio por tipo de transacción y por canal?
3. ¿Cuál es el porcentaje de transacciones rechazadas por banco, y qué banco tiene la tasa más alta?
4. ¿Cuántas transacciones hubo por mes y cómo cambió el monto aprobado entre 2024 y 2025?
5. ¿Cuáles son las 10 sucursales con mayor monto total aprobado y a qué ciudad pertenecen?
6. ¿Cuáles son los 10 clientes con mayor monto total aprobado y cuántas transacciones tiene cada uno?
7. ¿Qué canal concentra más transacciones en cada ciudad?
8. ¿Cuántos clientes tienen más de 10 transacciones y cuál es el monto promedio de esos clientes frente al resto?
9. ¿Cuántas transacciones superan los $2.000.000 COP, y cuántas fueron rechazadas o quedaron pendientes?
10. ¿Qué clientes hicieron transacciones en más de un banco o ciudad?

---

## 📈 Principales Hallazgos

- **Concentración de mercado:** Bancolombia lidera con ~30% del monto total aprobado ($687M COP), seguido por Davivienda con ~18.5%. Ambos concentran casi el 49% del flujo total.
- **Canal líder:** La **App Móvil** es el medio con mayor cantidad de transacciones en las 8 ciudades principales analizadas.
- **Rechazos:** Tasas cercanas al 10% en promedio. Davivienda presenta la tasa más alta (10.86%) y Banco de Occidente la más baja (8.18%).
- **Tendencia:** El monto aprobado creció un **~4%** entre 2024 y 2025 ($1.105M → $1.152M), con caídas solo en abril, agosto y diciembre de 2025.
- **Transacciones de alto valor:** Se registraron 176 transacciones superiores a $2M COP, de las cuales ~11% fueron rechazadas o quedaron pendientes.
- **Perfiles de valor:** Se identificaron 322 clientes con alta frecuencia de uso y 427 clientes que operan en múltiples bancos o ciudades.

---

## 💡 Recomendaciones Estratégicas

- ✅ Potenciar la App Móvil como canal prioritario de atención al cliente
- ✅ Investigar causas de rechazo en Davivienda, BBVA y Nu Colombia
- ✅ Implementar monitoreo especial para transacciones de alto monto
- ✅ Analizar la caída de diciembre 2025 para diferenciar comportamiento estacional de cambio de tendencia

---

## 🛠️ Habilidades Demostradas

- ✅ Consultas avanzadas en SQL (agrupaciones, filtros, funciones de agregación)
- ✅ Análisis exploratorio de datos
- ✅ Visualización de datos y creación de paneles interactivos en Power BI
- ✅ Generación de informes con hallazgos y recomendaciones accionables, es el primer proyecto de analisis de datos independiente donde creo un informe resumiento la informacion encontrada

---

> Este análisis fue realizado con fines educativos y de portafolio, utilizando una base de datos simulada. No representa información real de entidades financieras.
