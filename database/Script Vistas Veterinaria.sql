USE huellitas_traviesas;


-- vista turnos detallados
CREATE OR REPLACE VIEW vista_turnos_detallados AS
SELECT
    t.id_turno,
    t.fecha,
    t.hora_inicio,
    t.duracion_minutos,
    t.estado,
    t.tipo_consulta,
    p.nombre AS nombre_paciente,
    p.especie,
    d.nombre AS nombre_dueno,
    d.apellido AS apellido_dueno,
    d.telefono AS telefono_dueno,
    v.nombre AS nombre_veterinario,
    v.apellido AS apellido_veterinario,
    v.especialidad
FROM turno t
JOIN paciente p ON t.id_paciente = p.id_paciente
JOIN dueno d ON p.id_dueno = d.id_dueno
JOIN veterinario v ON t.id_veterinario = v.id_veterinario;


-- vista auditoria resumida
CREATE OR REPLACE VIEW vista_auditoria_resumida AS
SELECT
    a.id_auditoria,
    a.fecha_evento,
    a.accion,
    a.usuario,
    a.detalles,
    t.fecha AS fecha_turno,
    t.hora_inicio AS hora_turno,
    v.nombre AS nombre_veterinario,
    v.apellido AS apellido_veterinario
FROM auditoria_turnos a
LEFT JOIN turno t ON a.id_turno = t.id_turno
LEFT JOIN veterinario v ON t.id_veterinario = v.id_veterinario;


-- vista turnos por veterinario
CREATE OR REPLACE VIEW vista_turnos_por_veterinario AS
SELECT
    v.id_veterinario,
    v.nombre AS nombre_veterinario,
    v.apellido AS apellido_veterinario,
    v.especialidad,
    t.id_turno,
    t.fecha,
    t.hora_inicio,
    t.estado,
    p.nombre AS nombre_paciente
FROM turno t
JOIN veterinario v ON t.id_veterinario = v.id_veterinario
JOIN paciente p ON t.id_paciente = p.id_paciente;

