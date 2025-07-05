-- ------------------------------------------------------------
-- Prueba de solapamiento de turnos
-- ------------------------------------------------------------
-- Intenta insertar un turno que se superpone con otro ya existente
-- para comprobar que el trigger de solapamiento lo bloquee.
USE huellitas_traviesas;
INSERT INTO turno (fecha, hora_inicio, duracion_minutos, estado, tipo_consulta, descripcion, id_veterinario, id_paciente)
VALUES 
('2025-07-10', '10:15:00', 30, 'Pendiente', 'Consulta de control', 'Chequeo general', 1, 2);


-- ----------------------------------------------------------------
-- Prueba del trigger de auditoría y recordatorio al insertar turno
-- ----------------------------------------------------------------
-- Inserta un nuevo turno válido para verificar que se active el
-- trigger 'audit_turno_insert' y se cree un recordatorio en 
-- 'recordatorio_turno' mediante 'trg_crear_recordatorio'.
USE huellitas_traviesas;
INSERT INTO turno (fecha, hora_inicio, duracion_minutos, estado, tipo_consulta, descripcion, id_veterinario, id_paciente)
VALUES 
('2025-07-10', '12:00:00', 30, 'Pendiente', 'Consulta general', 'Revisión anual', 1, 1);


-- ---------------------------------------------------------------------------------------------
-- Prueba del trigger de auditoría para actualización de turnos y actualización de recordatorios
-- ---------------------------------------------------------------------------------------------
-- Actualiza el turno con ID 1 para verificar que el trigger 'audit_turno_update'
-- registre el cambio en la tabla 'auditoria_turnos'.
USE huellitas_traviesas;
UPDATE turno
SET hora_inicio = '22:00:00', duracion_minutos = 10
WHERE id_turno = 1;
