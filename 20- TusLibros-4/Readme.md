### Manual de uso para demo de TusLibros.Smalltalk.com

##### Server

Para iniciar el servidor de TusLibros se ejecuta esta linea:

```smalltalk
serverTusLibros := TusLibrosRestInterface listeningOn: 8088.
```

Para destruir las instancias abiertas del servidor podemor ejecutar en un Workspace la siguiente linea:

```smalltalk
TusLibrosRestInterface allInstances do:[:server | server destroy]. 
```



##### Client

Para crear una ventana cliente de TusLibros se ejecuta esta linea:

```
clientTusLibros := StoreClientLoginWindow open.
```

#### Vistas

##### Inicio de sesión

Para ingresar al sistema tenemos una ventana que pide el usuario y la contraseña, en la cual tenemos habilitado solamente al usuario y contraseña que figuran en la imagen. Finalmente luego de ingresar estos datos se aprieta el boton **ingresar**.

![loginWindow](/home/bruno/Downloads/loginWindow.png)



##### Ventana principal

Esta es la ventana principal del sistema, donde podemos hacer varias operaciones:

- **flecha roja **: agregar libros desde el catalogo al carrito de compras 
- **flecha verde **: remover libros del carrito de compras
- **flecha violeta **: finalizar la compra, mediante el cual se abre la ventana de _Detalle de la compra_
- **flecha azul **: ver el historial de compras del usuario

![ventanaPrincipalFlechitas](/home/bruno/Downloads/ventanaPrincipalFlechitas.jpeg)

##### Detalle de la compra

Esta vista se muestra cuando finalizamos la compra. En esta podemos visualizar la compra realizada y tambien decidir si queremos realizar otra compra o salir del sistema presentando los botones **SI** o **NO** respectivamente.

![DetalleDeLaCompra](/home/bruno/Downloads/DetalleDeLaCompra.png)

##### Historial de compras

![historialDeCompras](/home/bruno/Downloads/historialDeCompras.png)

##### Mensaje de error

Este es un ejemplo de la ventana que emerge cuando ocurre un error al finalizar la compra. Puede ocurrir cuando falla cualquiera de las operaciones indicando en el titulo el tipo de la operación que falló junto con su descripción.

![mensajeDeError](/home/bruno/Downloads/mensajeDeError.png)

