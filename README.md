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
- El archivo Script-Triggers-Veterinaria.sql contiene cinco triggers, todos correctamente documentados:

### 🛎️ trg_crear_recordatorio
- Se ejecuta después de insertar un turno.
- Genera automáticamente un mensaje en la tabla recordatorio_turno si el estado del turno es 'Pendiente' o 'Reprogramado'.

### 🔁 trg_actualizar_recordatorio
- Se ejecuta después de actualizar un turno.
- Modifica el mensaje del recordatorio si se cambia la fecha u hora del turno y el estado sigue siendo 'Pendiente' o 'Reprogramado'.

### 🚫 verificar_turno_superpuesto
- Se ejecuta antes de insertar un turno.
- Previene superposición horaria para un mismo veterinario, calculando el rango entre hora_inicio y duracion_minutos. Lanza un error si hay conflicto.

### 📥 audit_turno_insert
- Se ejecuta después de insertar un turno.
- Registra automáticamente la acción en la tabla auditoria_turnos, incluyendo usuario, fecha y descripción.

### ✏️ audit_turno_update
- Se ejecuta después de actualizar un turno.
- Guarda en la auditoría la modificación, con los valores anteriores y actuales del turno.

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
