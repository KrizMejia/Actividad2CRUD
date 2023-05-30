const express = require("express"); // Llamo al módulo y luego utilizo el módelo Router. 

const router = express.Router(); // Le puedo agregar rutas y reutilizarlo
const proveedorescontroller = require("../controllers/proveedoresController"); // Reuqiero el modulo exportado en ProveedoresController

/*router.get('/', (req, res) => { // Url que nuestra aplicación del servidor va a manejar, esta es para prueba. 
    res.send('Hola mundo');
}) */

router.get('/', proveedorescontroller.list);
router.post('/add', proveedorescontroller.save); // Método post, actualización
router.get('/delete/:Prov_NIT', proveedorescontroller.delete); // Método delete, borrado
router.get('/update/:Prov_NIT', proveedorescontroller.edit); // Método para editar 
router.post('/update/:Prov_NIT', proveedorescontroller.update); // 

module.exports = router; // luego exporto el Router. 