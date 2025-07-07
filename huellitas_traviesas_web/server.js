const express = require('express');
const cors = require('cors');
const db = require('./db');
const path = require('path');

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// Listar veterinarios
app.get('/api/veterinarios', (req, res) => {
    db.query('SELECT * FROM veterinario', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Listar dueños
app.get('/api/duenos', (req, res) => {
    db.query('SELECT * FROM dueno', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Listar pacientes con nombre dueño (JOIN)
app.get('/api/pacientes', (req, res) => {
    const sql = `
        SELECT p.*, d.nombre AS nombre_dueno, d.apellido AS apellido_dueno
        FROM paciente p
        JOIN dueno d ON p.id_dueno = d.id_dueno
    `;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Listar turnos (con veterinario y paciente)
app.get('/api/turnos', (req, res) => {
    const sql = `
        SELECT t.*, v.nombre AS nombre_veterinario, v.apellido AS apellido_veterinario,
               p.nombre AS nombre_paciente
        FROM turno t
        JOIN veterinario v ON t.id_veterinario = v.id_veterinario
        JOIN paciente p ON t.id_paciente = p.id_paciente
    `;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Agregar turno (con manejo de error por solapamiento del trigger)
app.post('/api/turnos', (req, res) => {
    const { fecha, hora_inicio, duracion_minutos, estado, tipo_consulta, descripcion, id_veterinario, id_paciente } = req.body;

    const sql = `INSERT INTO turno (fecha, hora_inicio, duracion_minutos, estado, tipo_consulta, descripcion, id_veterinario, id_paciente)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;

    db.query(sql, [fecha, hora_inicio, duracion_minutos, estado || 'Pendiente', tipo_consulta, descripcion, id_veterinario, id_paciente], (err, result) => {
        if (err) {
            // Si es error por solapamiento que lanza el trigger
            if (err.code === 'ER_SIGNAL_EXCEPTION') {
                return res.status(400).json({ error: err.sqlMessage || 'Error de solapamiento' });
            }
            return res.status(500).json({ error: err.message });
        }
        res.json({ message: 'Turno creado', id_turno: result.insertId });
    });
});

// Modificar turno (fecha, hora, estado, descripción)
app.put('/api/turnos/:id', (req, res) => {
    const { id } = req.params;

    // Si solo se quiere cancelar el turno
    if (Object.keys(req.body).length === 1 && req.body.estado === 'Cancelado') {
        const sql = `UPDATE turno SET estado=? WHERE id_turno=?`;
        db.query(sql, [req.body.estado, id], (err) => {
            if (err) return res.status(500).json({ error: err.message });
            res.json({ message: 'Turno cancelado' });
        });
        return;
    }

    // Si se envían todos los campos, actualizar todo el turno
    const { fecha, hora_inicio, duracion_minutos, estado, tipo_consulta, descripcion, id_veterinario, id_paciente } = req.body;

    const sql = `UPDATE turno SET fecha=?, hora_inicio=?, duracion_minutos=?, estado=?, tipo_consulta=?, descripcion=?, id_veterinario=?, id_paciente=? WHERE id_turno=?`;

    db.query(sql, [fecha, hora_inicio, duracion_minutos, estado, tipo_consulta, descripcion, id_veterinario, id_paciente, id], (err) => {
        if (err) {
            if (err.code === 'ER_SIGNAL_EXCEPTION') {
                return res.status(400).json({ error: err.sqlMessage || 'Error de solapamiento' });
            }
            return res.status(500).json({ error: err.message });
        }
        res.json({ message: 'Turno modificado' });
    });
});


// Listar recordatorios
app.get('/api/recordatorios', (req, res) => {
    const sql = `
        SELECT r.*, t.fecha, t.hora_inicio
        FROM recordatorio_turno r
        JOIN turno t ON r.id_turno = t.id_turno
        ORDER BY r.fecha_generacion DESC
    `;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// Listar auditoría de turnos
app.get('/api/auditoria', (req, res) => {
    const sql = `
        SELECT id_auditoria, id_turno, fecha_evento, accion, usuario, detalles
        FROM auditoria_turnos
        ORDER BY fecha_evento DESC
    `;
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error al obtener auditoría:', err);
            return res.status(500).json({ error: 'Error interno del servidor' });
        }
        res.json(results);
    });
});

// Iniciar servidor
app.listen(3000, () => {
    console.log('Servidor iniciado en http://localhost:3000');
});

