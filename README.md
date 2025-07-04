# 🐾 Proyecto Base de Datos: Turnos para Clínica Veterinaria "Huellitas Traviesas"

Este repositorio contiene el diseño y la implementación de una base de datos para la gestión de turnos en una clínica veterinaria, desarrollada como parte del Trabajo Práctico Integrador Final de la materia **Bases de Datos**.

---

## 📌 Objetivo del proyecto

Organizar la gestión de turnos para una clínica veterinaria, **evitando superposiciones**, garantizando la **integridad de los datos** y aplicando técnicas de **automatización mediante triggers**.

---

## 🧱 Estructura de la base de datos

El archivo `Script-Turnos-Veterinaria.sql` contiene la creación de las siguientes tablas:

1. **`dueno`**: Información personal del dueño de una mascota.
2. **`paciente`**: Datos veterinarios y clínicos de cada mascota.
3. **`veterinario`**: Profesionales que atienden en la clínica.
4. **`turno`**: Registros de los turnos asignados, con hora, duración y estado.
5. **`auditoria_turnos`**: Tabla para registrar cambios realizados sobre los turnos.
6. **`recordatorio_turno`**: Mensajes automáticos generados para recordar turnos agendados.

Todas las tablas están correctamente vinculadas mediante claves foráneas, con tipos de datos apropiados y uso de ENUM para campos controlados.

---

## ⚙️ Automatización mediante triggers

El archivo `Script-Triggers-Veterinaria.sql` contiene **cinco triggers**, todos documentados:

### 🛎️ `trg_crear_recordatorio`
- Se ejecuta luego de insertar un turno.
- Genera automáticamente un mensaje recordatorio si el estado del turno es `'Pendiente'` o `'Reprogramado'`.

### 🔄 `verificar_turno_superpuesto`
- Se ejecuta antes de insertar un nuevo turno.
- Previene que se creen turnos superpuestos para el mismo veterinario en la misma fecha y franja horaria, calculando dinámicamente la duración.

### 📥 `audit_turno_insert`
- Se ejecuta después de insertar un turno.
- Registra la acción en la tabla `auditoria_turnos`.

### ✏️ `audit_turno_update`
- Se ejecuta después de modificar un turno.
- Registra el cambio, incluyendo la hora anterior y la nueva.

### 🗑️ `audit_turno_delete`
- Se ejecuta después de eliminar un turno.
- Registra la eliminación con sus detalles.

---

## ✅ Requisitos cumplidos del TPI

- ✔️ Tablas normalizadas para veterinarios, pacientes, dueños y turnos.
- ✔️ Prevención de solapamientos de turnos.
- ✔️ Automatización útil mediante triggers.
- ✔️ Registro y trazabilidad completa de operaciones.
- ✔️ Uso eficiente de restricciones y relaciones.
- ✔️ Documentación clara en código y estructura profesional.

---

## 🛠️ Cómo utilizar este repositorio

1. Abrir **MySQL Workbench**.
2. Ejecutar `Script-Turnos-Veterinaria.sql` para crear la base de datos y sus tablas.
3. Ejecutar `Script-Triggers-Veterinaria.sql` para crear los triggers asociados.
4. Insertar datos de prueba y verificar el comportamiento automatizado.

---

## 👨‍💻 Integrantes del grupo

- 👨‍💻 Juan Gabriel Pared  
- 👨‍💻 Lucas Cáceres  
- 👨‍💻 Juan Mill  
- 👨‍💻 Gustavo Andrés Herrero  

---

Desarrollado para el Trabajo Práctico Integrador Final – Bases de Datos II  
📅 Año: 2025
