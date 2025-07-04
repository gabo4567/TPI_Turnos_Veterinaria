DROP DATABASE IF EXISTS huellitas_traviesas;

CREATE DATABASE IF NOT EXISTS huellitas_traviesas;
USE huellitas_traviesas;

-- tabla dueño
CREATE TABLE dueno (
    id_dueno INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NULL,
    direccion VARCHAR(150) NULL,
    genero ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
    fecha_nacimiento DATE NULL
);

-- tabla paciente
CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_animal ENUM('Doméstico', 'Exótico', 'Silvestre', 'De granja') NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raza VARCHAR(50) NULL,
    sexo ENUM('Macho', 'Hembra') NOT NULL,
    color VARCHAR(50) NULL,
    peso_actual DECIMAL(5,2) NULL,
    fecha_nacimiento DATE NULL,
    estado_reproductivo ENUM('Entero', 'Castrado', 'Esterilizado') NOT NULL,
    descripcion_clinica TEXT NULL,
    id_dueno INT NOT NULL,
    FOREIGN KEY (id_dueno) REFERENCES dueno(id_dueno)
);

-- tabla veterinario
CREATE TABLE veterinario (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NULL,
    direccion VARCHAR(150) NULL,
    genero ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    especialidad VARCHAR(100) NOT NULL
);

-- tabla turno
CREATE TABLE turno (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    duracion_minutos INT NOT NULL,
    estado ENUM('Pendiente', 'Atendido', 'Reprogramado', 'Cancelado') DEFAULT 'Pendiente' NOT NULL,
    tipo_consulta VARCHAR(50) NULL,
    descripcion TEXT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME ON UPDATE CURRENT_TIMESTAMP,
    id_veterinario INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- tabla auditoria_turnos
CREATE TABLE auditoria_turnos (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_turno INT,
    fecha_evento DATETIME DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('INSERT', 'UPDATE', 'DELETE'),
    usuario VARCHAR(100),
    detalles TEXT
);

-- tabla recordatorio_turno
CREATE TABLE recordatorio_turno (
    id_recordatorio INT AUTO_INCREMENT PRIMARY KEY,
    id_turno INT NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_generacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno)
);
