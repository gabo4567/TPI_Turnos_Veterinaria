USE huellitas_traviesas;


-- -------------------------------------------------------------------
-- TRIGGER: trg_crear_recordatorio
-- Descripción: Genera automáticamente un recordatorio al insertar un turno
-- con estado 'Pendiente' o 'Reprogramado'. Crea un mensaje en la tabla
-- recordatorio_turno con la fecha y hora del turno agendado.
-- Se ejecuta automáticamente después de insertar un nuevo turno.
-- -------------------------------------------------------------------
-- Trigger para recordatorio
DELIMITER $$

CREATE TRIGGER trg_crear_recordatorio
AFTER INSERT ON turno
FOR EACH ROW
BEGIN
    IF NEW.estado IN ('Pendiente', 'Reprogramado') THEN
        INSERT INTO recordatorio_turno (id_turno, mensaje)
        VALUES (
            NEW.id_turno,
            CONCAT('Recordatorio: el turno está agendado para el ', NEW.fecha, ' a las ', NEW.hora_inicio)
        );
    END IF;
END$$

DELIMITER ;


-- -------------------------------------------------------------------
-- TRIGGER: verificar_turno_superpuesto
-- Descripción: Previene que se inserte un turno que se superponga con
-- otro turno ya asignado al mismo veterinario en la misma fecha.
-- Calcula dinámicamente el rango de tiempo utilizando hora_inicio y
-- duracion_minutos. Si hay solapamiento, lanza un error.
-- -------------------------------------------------------------------
-- Trigger para evitar solapamiento de turnos
DELIMITER $$

CREATE TRIGGER verificar_turno_superpuesto
BEFORE INSERT ON turno
FOR EACH ROW
BEGIN
    DECLARE conflictos INT;

    SELECT COUNT(*) INTO conflictos
    FROM turno
    WHERE fecha = NEW.fecha
      AND id_veterinario = NEW.id_veterinario
      AND (
            NEW.hora_inicio < ADDTIME(hora_inicio, SEC_TO_TIME(duracion_minutos * 60))
            AND
            ADDTIME(NEW.hora_inicio, SEC_TO_TIME(NEW.duracion_minutos * 60)) > hora_inicio
          );

    IF conflictos > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El veterinario ya tiene un turno en ese horario.';
    END IF;
END$$

DELIMITER ;


-- -------------------------------------------------------------------
-- TRIGGER: audit_turno_insert
-- Descripción: Registra en la tabla auditoria_turnos cada vez que se
-- crea un nuevo turno. Guarda el ID del turno, el usuario que lo insertó,
-- la acción realizada y una descripción.
-- -------------------------------------------------------------------
-- Trigger de Auditoría para INSERT
DELIMITER $$

CREATE TRIGGER audit_turno_insert
AFTER INSERT ON turno
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_turnos (id_turno, accion, usuario, detalles)
    VALUES (
        NEW.id_turno,
        'INSERT',
        CURRENT_USER(),
        CONCAT('Se creó un turno para el ', NEW.fecha, ' a las ', NEW.hora_inicio)
    );
END$$

DELIMITER ;


-- -------------------------------------------------------------------
-- TRIGGER: audit_turno_update
-- Descripción: Registra en la tabla auditoria_turnos cada vez que se
-- modifica un turno. Guarda tanto la fecha y hora anteriores como las nuevas,
-- junto con el usuario y la acción realizada.
-- -------------------------------------------------------------------
-- Trigger de Auditoría para UPDATE
DELIMITER $$

CREATE TRIGGER audit_turno_update
AFTER UPDATE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_turnos (id_turno, accion, usuario, detalles)
    VALUES (
        NEW.id_turno,
        'UPDATE',
        CURRENT_USER(),
        CONCAT('Se modificó el turno del ', OLD.fecha, ' a las ', OLD.hora_inicio,
               ' ahora es el ', NEW.fecha, ' a las ', NEW.hora_inicio)
    );
END$$

DELIMITER ;


-- -------------------------------------------------------------------
-- TRIGGER: audit_turno_delete
-- Descripción: Registra en la tabla auditoria_turnos cuando se elimina
-- un turno. Guarda el ID del turno eliminado, el usuario y la fecha y hora
-- del turno que fue borrado.
-- -------------------------------------------------------------------
-- Trigger de Auditoría para DELETE
DELIMITER $$

CREATE TRIGGER audit_turno_delete
AFTER DELETE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_turnos (id_turno, accion, usuario, detalles)
    VALUES (
        OLD.id_turno,
        'DELETE',
        CURRENT_USER(),
        CONCAT('Se eliminó el turno del ', OLD.fecha, ' a las ', OLD.hora_inicio)
    );
END$$

DELIMITER ;

