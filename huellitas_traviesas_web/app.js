// app.js

const content = document.getElementById('content');
const buttons = document.querySelectorAll('#menu button');

buttons.forEach(btn => {
  btn.addEventListener('click', () => {
    const section = btn.getAttribute('data-section');
    loadSection(section);
  });
});

function loadSection(section) {
  content.innerHTML = '<p>Cargando...</p>';
  switch(section) {
    case 'veterinarios':
      fetchVeterinarios();
      break;
    case 'duenos':
      fetchDuenos();
      break;
    case 'pacientes':
      fetchPacientes();
      break;
    case 'turnos':
      showTurnosSection();
      break;
    case 'recordatorios':
      fetchRecordatorios();
      break;
    case 'auditoria':
      fetchAuditoria();
      break;
    default:
      content.innerHTML = '<p>Sección no encontrada</p>';
  }
}

function fetchVeterinarios() {
  fetch('/api/veterinarios')
    .then(res => res.json())
    .then(data => {
      let html = '<h2>Veterinarios</h2><table><thead><tr><th>ID</th><th>Nombre</th><th>Apellido</th><th>Especialidad</th></tr></thead><tbody>';
      data.forEach(v => {
        html += `<tr><td>${v.id_veterinario}</td><td>${v.nombre}</td><td>${v.apellido}</td><td>${v.especialidad}</td></tr>`;
      });
      html += '</tbody></table>';
      content.innerHTML = html;
    })
    .catch(() => content.innerHTML = '<p>Error al cargar veterinarios</p>');
}

function fetchDuenos() {
  fetch('/api/duenos')
    .then(res => res.json())
    .then(data => {
      let html = '<h2>Dueños</h2><table><thead><tr><th>ID</th><th>Nombre</th><th>Apellido</th><th>DNI</th></tr></thead><tbody>';
      data.forEach(d => {
        html += `<tr><td>${d.id_dueno}</td><td>${d.nombre}</td><td>${d.apellido}</td><td>${d.dni}</td></tr>`;
      });
      html += '</tbody></table>';
      content.innerHTML = html;
    })
    .catch(() => content.innerHTML = '<p>Error al cargar dueños</p>');
}

function fetchPacientes() {
  fetch('/api/pacientes')
    .then(res => res.json())
    .then(data => {
      let html = '<h2>Pacientes</h2><table><thead><tr><th>ID</th><th>Nombre</th><th>Especie</th><th>Dueño</th></tr></thead><tbody>';
      data.forEach(p => {
        html += `<tr><td>${p.id_paciente}</td><td>${p.nombre}</td><td>${p.especie}</td><td>${p.nombre_dueno} ${p.apellido_dueno}</td></tr>`;
      });
      html += '</tbody></table>';
      content.innerHTML = html;
    })
    .catch(() => content.innerHTML = '<p>Error al cargar pacientes</p>');
}

function fetchRecordatorios() {
  fetch('/api/recordatorios')
    .then(res => res.json())
    .then(data => {
      let html = '<h2>Recordatorios</h2><table><thead><tr><th>ID</th><th>Mensaje</th><th>Fecha Generación</th></tr></thead><tbody>';
      data.forEach(r => {
        html += `<tr><td>${r.id_recordatorio}</td><td>${r.mensaje}</td><td>${new Date(r.fecha_generacion).toLocaleString()}</td></tr>`;
      });
      html += '</tbody></table>';
      content.innerHTML = html;
    })
    .catch(() => content.innerHTML = '<p>Error al cargar recordatorios</p>');
}

function showTurnosSection() {
  content.innerHTML = `
    <h2>Turnos</h2>
    <div id="turnos-list"></div>
    <div id="edit-turno-container"></div>
    <h3>Agregar nuevo turno</h3>
    <form id="turno-form">
      <label>Fecha: <input type="date" name="fecha" required></label>
      <label>Hora inicio: <input type="time" name="hora_inicio" required></label>
      <label>Duración (min): <input type="number" name="duracion_minutos" min="1" required></label>
      <label>Estado: 
        <select name="estado">
          <option value="Pendiente" selected>Pendiente</option>
          <option value="Atendido">Atendido</option>
          <option value="Reprogramado">Reprogramado</option>
          <option value="Cancelado">Cancelado</option>
        </select>
      </label>
      <label>Tipo consulta: <input type="text" name="tipo_consulta"></label>
      <label>Descripción: <textarea name="descripcion"></textarea></label>
      <label>Veterinario:
        <select name="id_veterinario" required></select>
      </label>
      <label>Paciente:
        <select name="id_paciente" required></select>
      </label>
      <button type="submit">Crear turno</button>
      <div id="message"></div>
    </form>
  `;

  loadTurnos();
  loadVeterinariosToSelect();
  loadPacientesToSelect();

  document.getElementById('turno-form').addEventListener('submit', e => {
    e.preventDefault();
    createTurno();
  });
}

function loadTurnos() {
  fetch('/api/turnos')
    .then(res => res.json())
    .then(data => {
      let html = `<table><thead><tr><th>ID</th><th>Fecha</th><th>Hora</th><th>Duración</th><th>Estado</th><th>Veterinario</th><th>Paciente</th><th>Acciones</th></tr></thead><tbody>`;
      data.forEach(t => {
        html += `<tr>
          <td>${t.id_turno}</td>
          <td>${t.fecha}</td>
          <td>${t.hora_inicio}</td>
          <td>${t.duracion_minutos} min</td>
          <td>${t.estado}</td>
          <td>${t.nombre_veterinario} ${t.apellido_veterinario}</td>
          <td>${t.nombre_paciente}</td>
          <td>
            <button onclick="showEditTurnoForm(${t.id_turno})">Editar</button>
            <button onclick="cancelTurno(${t.id_turno})">Cancelar</button>
          </td>
        </tr>`;
      });
      html += '</tbody></table>';
      document.getElementById('turnos-list').innerHTML = html;
    })
    .catch(() => {
      document.getElementById('turnos-list').innerHTML = '<p>Error al cargar turnos</p>';
    });
}

function loadVeterinariosToSelect() {
  fetch('/api/veterinarios')
    .then(res => res.json())
    .then(data => {
      const select = document.querySelector('select[name="id_veterinario"]');
      select.innerHTML = '<option value="">Seleccione veterinario</option>';
      data.forEach(v => {
        select.innerHTML += `<option value="${v.id_veterinario}">${v.nombre} ${v.apellido}</option>`;
      });
    });
}

function loadPacientesToSelect() {
  fetch('/api/pacientes')
    .then(res => res.json())
    .then(data => {
      const select = document.querySelector('select[name="id_paciente"]');
      select.innerHTML = '<option value="">Seleccione paciente</option>';
      data.forEach(p => {
        select.innerHTML += `<option value="${p.id_paciente}">${p.nombre} (${p.especie})</option>`;
      });
    });
}

function showEditTurnoForm(id_turno) {
  fetch('/api/turnos')
    .then(res => res.json())
    .then(data => {
      const turno = data.find(t => t.id_turno === id_turno);
      if (!turno) return alert('Turno no encontrado');

      const editContainer = document.getElementById('edit-turno-container');
      editContainer.innerHTML = `
        <h3>Editar Turno ID ${id_turno}</h3>
        <form id="edit-turno-form">
          <label>Fecha: <input type="date" name="fecha" value="${turno.fecha}" required></label>
          <label>Hora inicio: <input type="time" name="hora_inicio" value="${turno.hora_inicio}" required></label>
          <label>Duración (min): <input type="number" name="duracion_minutos" value="${turno.duracion_minutos}" required></label>
          <label>Estado:
            <select name="estado">
              <option value="Pendiente" ${turno.estado === 'Pendiente' ? 'selected' : ''}>Pendiente</option>
              <option value="Atendido" ${turno.estado === 'Atendido' ? 'selected' : ''}>Atendido</option>
              <option value="Reprogramado" ${turno.estado === 'Reprogramado' ? 'selected' : ''}>Reprogramado</option>
              <option value="Cancelado" ${turno.estado === 'Cancelado' ? 'selected' : ''}>Cancelado</option>
            </select>
          </label>
          <label>Tipo consulta: <input type="text" name="tipo_consulta" value="${turno.tipo_consulta || ''}"></label>
          <label>Descripción: <textarea name="descripcion">${turno.descripcion || ''}</textarea></label>
          <label>Veterinario:
            <select name="id_veterinario" required></select>
          </label>
          <label>Paciente:
            <select name="id_paciente" required></select>
          </label>
          <button type="submit">Guardar cambios</button>
          <button type="button" onclick="cancelEditForm()">Cancelar</button>
          <div id="edit-message"></div>
        </form>`;

      loadVeterinariosToSelectForEdit(turno.id_veterinario);
      loadPacientesToSelectForEdit(turno.id_paciente);

      document.getElementById('edit-turno-form').addEventListener('submit', e => {
        e.preventDefault();
        submitEditTurno(id_turno);
      });
    });
}

function loadVeterinariosToSelectForEdit(selectedId) {
  fetch('/api/veterinarios')
    .then(res => res.json())
    .then(data => {
      const container = document.getElementById('edit-turno-container');
      const select = container.querySelector('select[name="id_veterinario"]');
      select.innerHTML = '';
      data.forEach(v => {
        const selected = v.id_veterinario === selectedId ? 'selected' : '';
        select.innerHTML += `<option value="${v.id_veterinario}" ${selected}>${v.nombre} ${v.apellido}</option>`;
      });
    });
}

function loadPacientesToSelectForEdit(selectedId) {
  fetch('/api/pacientes')
    .then(res => res.json())
    .then(data => {
      const container = document.getElementById('edit-turno-container');
      const select = container.querySelector('select[name="id_paciente"]');
      select.innerHTML = '';
      data.forEach(p => {
        const selected = p.id_paciente === selectedId ? 'selected' : '';
        select.innerHTML += `<option value="${p.id_paciente}" ${selected}>${p.nombre} (${p.especie})</option>`;
      });
    });
}

function createTurno() {
  const form = document.getElementById('turno-form');
  const formData = new FormData(form);
  const jsonData = {};
  formData.forEach((v, k) => jsonData[k] = v);

  fetch('/api/turnos', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(jsonData)
  })
  .then(async res => {
    const data = await res.json();
    const msgDiv = document.getElementById('message');
    if (!res.ok) {
      msgDiv.style.color = 'red';
      msgDiv.textContent = data.error || 'Error creando turno';
    } else {
      msgDiv.style.color = 'green';
      msgDiv.textContent = 'Turno creado correctamente';
      form.reset();
      loadTurnos();
    }
  })
  .catch(() => {
    const msgDiv = document.getElementById('message');
    msgDiv.style.color = 'red';
    msgDiv.textContent = 'Error de conexión';
  });
}

function submitEditTurno(id_turno) {
  const form = document.getElementById('edit-turno-form');
  const formData = new FormData(form);
  const jsonData = {};
  formData.forEach((v, k) => jsonData[k] = v);

  fetch(`/api/turnos/${id_turno}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(jsonData)
  })
  .then(async res => {
    const data = await res.json();
    const msgDiv = document.getElementById('edit-message');
    if (!res.ok) {
      msgDiv.style.color = 'red';
      msgDiv.textContent = data.error || 'Error modificando turno';
    } else {
      msgDiv.style.color = 'green';
      msgDiv.textContent = 'Turno modificado correctamente';
      loadTurnos();
      setTimeout(cancelEditForm, 1000);
    }
  })
  .catch(() => {
    const msgDiv = document.getElementById('edit-message');
    msgDiv.style.color = 'red';
    msgDiv.textContent = 'Error de conexión';
  });
}

function cancelTurno(id_turno) {
  if (!confirm('¿Querés cancelar este turno?')) return;

  fetch(`/api/turnos/${id_turno}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ estado: 'Cancelado' })
  })
  .then(async res => {
    if (!res.ok) {
      const data = await res.json();
      alert('Error cancelando turno: ' + (data.error || 'Error desconocido'));
    } else {
      alert('Turno cancelado correctamente');
      loadTurnos();
    }
  })
  .catch(() => {
    alert('Error de conexión al cancelar turno');
  });
}

function cancelEditForm() {
  document.getElementById('edit-turno-container').innerHTML = '';
  loadTurnos();
}

function fetchAuditoria() {
  fetch('/api/auditoria')
    .then(res => res.json())
    .then(data => {
      let html = '<h2>Auditoría de Turnos</h2><table><thead><tr>' +
        '<th>ID</th><th>Turno ID</th><th>Fecha</th><th>Acción</th><th>Usuario</th><th>Detalle</th>' +
        '</tr></thead><tbody>';

      data.forEach(a => {
        html += `<tr>
          <td>${a.id_auditoria}</td>
          <td>${a.id_turno}</td>
          <td>${new Date(a.fecha_evento).toLocaleString()}</td>
          <td>${a.accion}</td>
          <td>${a.usuario}</td>
          <td>${a.detalles}</td>
        </tr>`;
      });

      html += '</tbody></table>';
      content.innerHTML = html;
    })
    .catch(() => content.innerHTML = '<p>Error al cargar auditoría</p>');
}

loadSection('veterinarios');
