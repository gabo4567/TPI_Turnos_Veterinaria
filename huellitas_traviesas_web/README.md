# 🐾 Clínica Veterinaria Huellitas Traviesas - Web de Prueba de Base de Datos

Esta es una página web desarrollada en **HTML, CSS y JavaScript puro**, con backend en **Node.js + Express**, diseñada para interactuar con la base de datos MySQL de la clínica veterinaria **Huellitas Traviesas**. 

El propósito de esta web es probar, visualizar y validar los datos almacenados en la base, además de realizar operaciones básicas como gestión de turnos, visualización de pacientes, veterinarios, recordatorios y auditoría.

---

## 📁 Estructura del Proyecto

huellitas_traviesas_web/
├── public/
│ ├── index.html # Página principal con menú y contenedor dinámico
│ ├── style.css # Estilos visuales básicos
│ └── app.js # Lógica de interacción y consumo de API (frontend)
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

Gracias por los detalles, Juan. Acá tenés el bloque corregido y formateado correctamente del README, incluyendo:

* La sección de requisitos **fuera del bloque de código**,
* Las **notas correctamente separadas**,
* Y los **nombres de tus compañeros de grupo** añadidos profesionalmente.

---

## 🔧 Requisitos para ejecutar localmente

- Tener **Node.js** instalado
- Tener **MySQL** en funcionamiento con la base de datos ya importada
- Ejecutar los siguientes comandos desde la terminal:

```bash
npm install
node server.js
````

Luego, abrir [http://localhost:3000](http://localhost:3000) en el navegador.

---

## 📌 Notas

* Esta página **no está diseñada con foco estético**, sino **funcional**.
* Todos los datos se obtienen directamente de la base de datos real mediante **consultas SQL**.
* Proyecto desarrollado como parte del trabajo práctico para la materia **Base de Datos II**.

---

## 👨‍💻 Equipo de Desarrollo

* **Juan Gabriel Pared**
* **Lucas Cáceres**
* **Andrés Herrero**
* **Juan Mill**

📅 Año: 2025
🏫 Universidad Tecnológica Nacional (UTN), Sede ITG de Goya

