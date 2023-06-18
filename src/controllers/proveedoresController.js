// Vamos a exportar varios objetos ya que existen muchos métodos. 

const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();


const controller = {}; // Objeto que irá cambiando

/* controller.list = (req, res) => { // Esta función hace parte de un objeto
    res.send('Hola mundo desde el controlador');
}; */

/*
controller.list = (req, res) => {
    req.getConnection((err, conn) => {  // GET CONNECTION PEDIRÁ UNA CONEXIÓN A SQL
        conn.query('SELECT * FROM proveedores', (err, proveedores) => {
            if (err) {
                res.json(err);
            }
            res.render('proveedores', {
                data: proveedores

            });
        });
    });
}; 

*/


prisma.$connect()
  .then(() => {
    console.log('Conexión exitosa a la base de datos');
   
  })
  .catch((error) => {
    console.error('Error al conectar a la base de datos:', error);
  });


controller.list = async (req, res) => {
    try {
      const proveedores = await prisma.proveedores.findMany();
      res.render('proveedores', { data: proveedores });
    } catch (error) {
      res.json(error);

    }
  };
  
  
  controller.save = async (req, res) => {
    const data = req.body; 
  
    try {
      const proveedor = await prisma.proveedores.create({ data });
      console.log(proveedor);
      res.redirect('/');
    } catch (error) {
      console.error(error);
      // Manejo del error
      res.status(500).send('Error al guardar el registro');
    }
  };



/* controller.save = (req, res) => { //Método para almacenar los registros del formulario
    const data = JSON.parse(JSON.stringify(req.body)); // Data guarda todos los datos que vienen desde el formulario
    req.getConnection((err, conn) => {

        conn.query('INSERT INTO proveedores set ?', [data], (err, proveedor) => {
            console.log(proveedor);
            //res.send('Funcionó')
            res.redirect('/');
        });
    })
}; */

/* controller.edit = (req, res) => {
    const { Prov_NIT } = req.params;
    req.getConnection((err, conn) => {
        conn.query("SELECT * FROM proveedores WHERE Prov_NIT = ?", [Prov_NIT], (err, proveedor) => {
            res.render("proveedor_editar", {
                data: proveedor[0]
            });
        });
    });
}; */


controller.edit = async (req, res) => {
    const { Prov_NIT } = req.params;
  
    try {
      const proveedor = await prisma.proveedores.findUnique({
        where: { Prov_NIT },
      });
  
      res.render("proveedor_editar", {
        data: proveedor,
      });
    } catch (error) {
      console.error(error);
      // Manejo del error
      res.status(500).send('Error al obtener el proveedor');
    }
  };


  controller.update = async (req, res) => {
    const { Prov_NIT } = req.params;
    const nuevoProveedor = req.body;
  
    try {
      await prisma.proveedores.update({
        where: { Prov_NIT },
        data: nuevoProveedor,
      });
  
      res.redirect('/');
    } catch (error) {
      console.error(error);
      // Manejo del error
      res.status(500).send('Error al actualizar el registro');
    }
  };

   
  /*controller.update = (req, res) => {
    const { Prov_NIT } = req.params;
    const nuevoProveedor = req.body;
    req.getConnection((err, conn) => {
        conn.query("UPDATE proveedores set ? WHERE Prov_NIT = ?", [nuevoProveedor, Prov_NIT], (err, rows) => {
            res.redirect('/');

        });
        });
        };
*/
    

        controller.delete = async (req, res) => {
            const { Prov_NIT } = req.params;
          
            try {
              await prisma.proveedores.delete({
                where: { Prov_NIT },
              });
          
              res.redirect('/');
            } catch (error) {
              console.error(error);
              // Manejo del error
              res.status(500).send('Error al borrar el registro');
            }
          };




/*controller.delete = (req, res) => { //Método para borrar los registros del formulario
    const { Prov_NIT } = req.params;
    req.getConnection((err, conn) => {
        conn.query("DELETE FROM proveedores WHERE Prov_NIT = ?", [Prov_NIT], (err, conn) => {
            res.redirect('/');
        })
    })
};
*/

/*
[Object: null prototype] {
  nit: '89',
  nombre: '89',
  direccion: '89',
  telefono: '89'
}
*/

module.exports = controller; // Exportación del controlador