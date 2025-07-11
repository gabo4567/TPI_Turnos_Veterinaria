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
('30222333', 'Luciano', 'Martínez', '1133445566', 'Av. Siempre Viva 742', 'Masculino', '1990-09-15'),
('30333444', 'María', 'López', '1144556677', 'Mitre 123', 'Femenino', '1988-01-12'),
('30444555', 'Jorge', 'Ramírez', '1166123456', 'San Martín 456', 'Masculino', '1975-04-22'),
('30555666', 'Laura', 'Benítez', '1177001122', 'Belgrano 789', 'Femenino', '1993-07-30'),
('30666777', 'Esteban', 'Suárez', '1144332211', 'Alsina 321', 'Masculino', '1982-10-05'),
('30777888', 'Natalia', 'Torres', '1122113344', 'Rivadavia 890', 'Femenino', '1999-12-18'),
('30888999', 'Fernando', 'Luna', '1133224455', 'Moreno 654', 'Masculino', '1986-05-09'),
('30999000', 'Carolina', 'Méndez', '1199887766', 'Lavalle 111', 'Femenino', '1995-03-17'),
('31000111', 'Alejandro', 'Paz', '1155332211', 'Sarmiento 321', 'Masculino', '1979-08-25');


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
('Toby', 'Doméstico', 'Perro', 'Labrador', 'Macho', 'Marrón', 30.5, '2019-03-20', 'Castrado', 'Sin antecedentes clínicos', 1),
('Mishi', 'Doméstico', 'Gato', 'Siames', 'Hembra', 'Gris', 4.3, '2020-07-15', 'Esterilizado', 'Última vacuna aplicada', 2),
('Firulais', 'Doméstico', 'Perro', 'Bulldog', 'Macho', 'Blanco', 20.0, '2021-01-10', 'Entero', 'Consulta por otitis', 3),
('Pelusa', 'Doméstico', 'Gato', 'Persa', 'Hembra', 'Negro', 3.2, '2022-06-01', 'Esterilizado', 'Revisión postoperatoria', 4),
('Rex', 'Doméstico', 'Perro', 'Pastor Alemán', 'Macho', 'Marrón y negro', 35.0, '2018-09-25', 'Castrado', 'Control de peso', 5),
('Luna', 'Doméstico', 'Gato', 'Mestiza', 'Hembra', 'Gris', 4.0, '2020-11-11', 'Entero', 'Vacunación anual', 6),
('Coco', 'Exótico', 'Conejo', 'Enano', 'Macho', 'Blanco y marrón', 1.5, '2023-02-02', 'Entero', 'Chequeo general', 7),
('Tango', 'Doméstico', 'Perro', 'Dálmata', 'Macho', 'Blanco con manchas negras', 25.0, '2019-05-20', 'Castrado', 'Dermatitis tratada', 8),
('Nina', 'Doméstico', 'Gato', 'Bengala', 'Hembra', 'Dorada', 3.8, '2021-07-07', 'Esterilizado', 'Vacunas completas', 9),
('Moro', 'De granja', 'Caballo', 'Criollo', 'Macho', 'Negro', 400.0, '2015-03-15', 'Entero', 'Lesión en una pata', 10);


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
('20222333', 'Martín', 'Gómez', '1166778899', 'Calle Falsa 123', 'Masculino', '1983-11-20', 'Cirugía'),
('20333444', 'Valeria', 'Nuñez', '1144001122', 'Av. Libertad 222', 'Femenino', '1987-03-11', 'Animales Exóticos'),
('20444555', 'Ramiro', 'Correa', '1155112233', 'Av. 60 N°456', 'Masculino', '1978-08-19', 'Animales de granja'),
('20555666', 'Gabriela', 'Ibarra', '1166223344', 'Calle 7 N°789', 'Femenino', '1992-11-03', 'Clínica General');


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
