USE huellitas_traviesas;

-- Vista opcional: Turnos del día
CREATE VIEW turnos_hoy AS
SELECT t.id_turno, t.fecha, t.hora_inicio, t.estado, v.nombre_apellido AS veterinario, p.nombre AS paciente
FROM turno t
JOIN veterinario v ON t.id_veterinario = v.id_veterinario
JOIN paciente p ON t.id_paciente = p.id_paciente
WHERE t.fecha = CURDATE();