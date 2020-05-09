# Marvel

Usando el API de Marvel para crear una app pequeñita que mostrará un listado de personajes que al pinchar en uno nos llevará al detalle de dicho personaje donde podremos ver en que comics e historias ha participado y un detalle sobre él mismo abriendo los enlaces en una web.

He creado 2 protocolos:
- Spinnable -> Crear y anima un spinner en la vista que indiques. 
- Alertable -> Lanza un alertView.

También he creado 2 extensiones para estos protocolos:
- Spinnable -> Una extension de viewController para lanzar el spinner de manera más sencilla para las peticiones.
- Alertable -> Una extension de viewController para controlar los errores y mostrar una alerta cuando uno de los servicios falle.

Otra extensión es para UIImageview para descargar una imagen de una URL y la cual usa también el protocolo Spinnable por lo que mientras la descarga se verá un spinner.

Todas las vistas están en el mismo storyboard(Marvel.storyboard) incluida una celda personalizada para el listado de personajes.

Para la gestión de los servicios REST he utilizado URLSession de Apple aunque si algún día se quiere cambiar a Alamofire u otro framework solo habría que cambiar la extensión del protocolo BaseRepository. Para mapear las respuestas utilizo Codable y he creado varios structs para obtener el Character que es al final el que traslado a los presenter.
