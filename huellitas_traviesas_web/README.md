# 🐾 Clínica Veterinaria Huellitas Traviesas - Web de Prueba de Base de Datos

Esta es una página web desarrollada en **HTML, CSS y JavaScript puro**, con backend en **Node.js + Express**, diseñada para interactuar con la base de datos MySQL de la clínica veterinaria **Huellitas Traviesas**. 

El propósito de esta web es probar, visualizar y validar los datos almacenados en la base, además de realizar operaciones básicas como gestión de turnos, visualización de pacientes, veterinarios, recordatorios y auditoría.

---

## 📁 Estructura del Proyecto

huellitas_traviesas_web/
│
├── index.html # Página principal con menú y contenedor dinámico
├── style.css # Estilos visuales básicos
├── app.js # Lógica de interacción y consumo de API (frontend)
├── server.js # Servidor Express con todos los endpoints
├── db.js # Conexión a la base de datos MySQL
├── package.json # Dependencias y configuración de Node.js
├── package-lock.json # Lockfile generado por npm
└── README.md # (Este archivo)

---

## 🚀 Funcionalidades

### 👩‍⚕️ Veterinarios
- ✅ Listar todos los veterinarios

### 👤 Dueños
- ✅ Listar todos los dueños registrados

### 🐶 Pacientes
- ✅ Listar pacientes con nombre y dueño

### 📆 Turnos
- ✅ Listar turnos con fecha, hora, veterinario, paciente y estado  
- ✅ Crear nuevos turnos con validación de solapamientos (via trigger)  
- ✅ Modificar o cancelar un turno existente

### 🔔 Recordatorios
- ✅ Visualizar recordatorios generados automáticamente

### 📝 Auditoría
- ✅ Mostrar historial de inserciones y modificaciones sobre turnos  
- (Acciones obtenidas a través de triggers en la base de datos)

---

## 🔧 Requisitos para ejecutar localmente

- Node.js instalado
- MySQL con base de datos importada
- Ejecutar:

```bash
npm install
node server.js
Abrir http://localhost:3000 en el navegador.

---

📌 Notas
Esta página no está diseñada con foco estético, sino funcional.

Todos los datos son obtenidos de la base de datos real mediante consultas SQL.

Este proyecto fue desarrollado como parte del trabajo práctico para la materia Base de Datos II.

👨‍💻 Desarrollador
Juan Gabriel Pared

Proyecto académico - 2025

Universidad Tecnológica Nacional (UTN), Sede ITG de Goya

---
