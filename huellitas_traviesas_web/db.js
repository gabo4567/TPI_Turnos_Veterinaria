// db.js
const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'rulito12345',
    database: 'huellitas_traviesas'
});

connection.connect((err) => {
    if (err) throw err;
    console.log('Conectado a MySQL');
});

module.exports = connection;
