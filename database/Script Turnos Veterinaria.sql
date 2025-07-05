DROP DATABASE IF EXISTS huellitas_traviesas;

CREATE DATABASE IF NOT EXISTS huellitas_traviesas;
USE huellitas_traviesas;

-- tabla dueño
CREATE TABLE dueno (
    id_dueno INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(150),
    genero ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
    fecha_nacimiento DATE
);
INSERT INTO dueno (dni, nombre, apellido, telefono, direccion, genero, fecha_nacimiento)
VALUES 
('30111222', 'Carla', 'Fernández', '1122334455', 'Calle 123', 'Femenino', '1985-06-10'),
('30222333', 'Luciano', 'Martínez', '1133445566', 'Av. Siempre Viva 742', 'Masculino', '1990-09-15');


-- tabla paciente
CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_animal ENUM('Doméstico', 'Exótico', 'Silvestre', 'De granja') NOT NULL,
    especie VARCHAR(50) NOT NULL,
    raza VARCHAR(50),
    sexo ENUM('Macho', 'Hembra') NOT NULL,
    color VARCHAR(50),
    peso_actual DECIMAL(5,2),
    fecha_nacimiento DATE,
    estado_reproductivo ENUM('Entero', 'Castrado', 'Esterilizado') NOT NULL,
    descripcion_clinica TEXT,
    id_dueno INT NOT NULL,
    FOREIGN KEY (id_dueno) REFERENCES dueno(id_dueno)
);
INSERT INTO paciente (nombre, tipo_animal, especie, raza, sexo, color, peso_actual, fecha_nacimiento, estado_reproductivo, descripcion_clinica, id_dueno)
VALUES 
('Toby', 'Doméstico', 'Canis lupus familiaris', 'Labrador', 'Macho', 'Marrón', 30.5, '2019-03-20', 'Castrado', 'Sin antecedentes clínicos', 1),
('Mishi', 'Doméstico', 'Felis catus', 'Siames', 'Hembra', 'Gris', 4.3, '2020-07-15', 'Esterilizado', 'Última vacuna aplicada', 2);


-- tabla veterinario
CREATE TABLE veterinario (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(150),
    genero ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    especialidad VARCHAR(100) NOT NULL
);
INSERT INTO veterinario (dni, nombre, apellido, telefono, direccion, genero, fecha_nacimiento, especialidad)
VALUES 
('20111222', 'Soledad', 'Pérez', '1155667788', 'Diag. 74 Nº 1111', 'Femenino', '1980-02-05', 'Clínica General'),
('20222333', 'Martín', 'Gómez', '1166778899', 'Calle Falsa 123', 'Masculino', '1983-11-20', 'Cirugía');


-- tabla turno
CREATE TABLE turno (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    duracion_minutos INT NOT NULL,
    estado ENUM('Pendiente', 'Atendido', 'Reprogramado', 'Cancelado') DEFAULT 'Pendiente' NOT NULL,
    tipo_consulta VARCHAR(50),
    descripcion TEXT,
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
    id_turno INT NOT NULL,
    fecha_evento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    accion ENUM('INSERT', 'UPDATE') NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    detalles TEXT,
    CONSTRAINT fk_auditoria_turno
        FOREIGN KEY (id_turno)
        REFERENCES turno(id_turno)
);


-- tabla recordatorio_turno
CREATE TABLE recordatorio_turno (
    id_recordatorio INT AUTO_INCREMENT PRIMARY KEY,
    id_turno INT NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_generacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno)
);
