// App ejecuta todo el servidor
const express = require("express"); // Requerimos express y luego lo inicializaremos
const path = require("path"); // Este se encarga de unir directorios
const morgan = require("morgan"); // Morgan para funciones que se ejecutan antes de las peticiones de los usuarios
const mysql = require("mysql"); // Conexión con Mysql
const myConnection = require("express-myconnection"); // Ahora en myconnection tengo la funcionalidad de este módulo

const app = express(); // declaro la inicialización por medio de una constante llamada app
// Importando rutas
const proveedoresRoutes = require('./routes/proveedores'); // Ya tengo todas estas rutas que utlizaré en esta constante


// Settings
app.set('port', process.env.PORT || 3001); // Process, revisar si hay un puerto y si no existe que use el puerto 3001
app.set("view engine", "ejs") // View engine, motor de plantillas, este será ejs // Express ya sabe que usaremos ejs como el motor de plantillas
// Vamos a decirle donde está mi carpeta views: 
app.set("views", path.join(__dirname, "views")); // En el segundo parámetro vamos a decirle donde está la carpeta, la dirección. path. se une con los directorios que recibirá como parámetro. 
// el dirname se encarga de darme la ruta del archivo que lo ejecuta



// Midlewares: Funciones que se ejecutan antes de las peticiones de los usuarios: 
// Para esto requerimos morgan
app.use(morgan("dev")); // Para mostrar algunos mensajes por consola sencillos
// Ahora vamos a conectarlo con My sql


/*
app.use(myConnection(mysql, { // Recibira como parámetro el módulo que conecta a la base de datos  y los datos de la conexión
    host: "localhost",
    user: "crizmejia",
    password: "123456789",
    port: 3306,
    database: "inventario_merca_facil"
}, "single")); // Entre comillas como estaremos conectándonos con nuestro servidor

*/


// Este middleware es para guardar los usuarios
app.use(express.urlencoded({extended:false})); //signiFica que desde el módulo de express, estamos requiriendo un método que nos va a 
// permitir entender los datos que vienen del formulario, es false porque no vamos a enviar imagenes ni datos codificados. 

// Routes
// Cada vez que un usuario abra mi servidor va a tener acceso a mi servidor
app.use('/',proveedoresRoutes);

// static files
app.use(express.static(path.join(__dirname, "public")));
//vamos a inicializar el servidor
app.listen(app.get("port"), () => { // El get lo que va a hacer es llevar la información del process. 
    console.log("Servidor en puerto 3001");
});

// YA TENEMOS UNA MANERA PARA INICIALIZAR NUESTRO SERVIDOR
// 
