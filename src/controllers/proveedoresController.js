// Vamos a exportar varios objetos ya que existen muchos métodos.  


const controller = {}; // Objeto que irá cambiando

/* controller.list = (req, res) => { // Esta función hace parte de un objeto
    res.send('Hola mundo desde el controlador');
}; */

controller.list = (req, res) => {
    req.getConnection((err, conn) => {  // GET CONNECTION PEDIRÁ UNA CONEXIÓN A SQL
        conn.query('SELECT * FROM proveedores', (err, proveedores) => {
            if (err) {
                res.json(err);
            }
            console.log(proveedores);
            res.render('proveedores', {
                data: proveedores

            });
        });
    });
};

controller.save = (req, res) => { //Método para almacenar los registros del formulario
    const data = JSON.parse(JSON.stringify(req.body)); // Data guarda todos los datos que vienen desde el formulario
    req.getConnection((err, conn) => {

        conn.query('INSERT INTO proveedores set ?', [data], (err, proveedor) => {
            console.log(proveedor);
            //res.send('Funcionó')
            res.redirect('/');
        });
    })
};

controller.edit = (req, res) => {
    const { Prov_NIT } = req.params;
    req.getConnection((err, conn) => {
        conn.query("SELECT * FROM proveedores WHERE Prov_NIT = ?", [Prov_NIT], (err, proveedor) => {
            res.render("proveedor_editar", {
                data: proveedor[0]
            });
        });
    });
};

controller.update = (req, res) => {
    const { Prov_NIT } = req.params;
    const nuevoProveedor = req.body;
    req.getConnection((err, conn) => {
        conn.query("UPDATE proveedores set ? WHERE Prov_NIT = ?", [nuevoProveedor, Prov_NIT], (err, rows) => {
            res.redirect('/');

        });
        });
        };
   
    




controller.delete = (req, res) => { //Método para borrar los registros del formulario
    const { Prov_NIT } = req.params;
    req.getConnection((err, conn) => {
        conn.query("DELETE FROM proveedores WHERE Prov_NIT = ?", [Prov_NIT], (err, conn) => {
            res.redirect('/');
        })
    })
};


/*
[Object: null prototype] {
  nit: '89',
  nombre: '89',
  direccion: '89',
  telefono: '89'
}
*/

module.exports = controller; // Exportación del controlador