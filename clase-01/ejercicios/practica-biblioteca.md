

Ejercicio 1: Gestión de una Biblioteca
Una biblioteca necesita gestionar información sobre sus libros, autores, préstamos y usuarios.


Para ello, tienes el siguiente modelo relacional:

Tablas y estructura:

Usuarios (id_usuario, nombre, email, telefono)
Autores (id_autor, nombre_autor, nacionalidad)
Libros (id_libro, titulo, id_autor, genero, anio_publicacion)
Prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion)

Relaciones:
Un Autor puede escribir varios libros (1:N).
Un Libro pertenece a un solo autor (N:1).
Un Usuario puede tener varios préstamos (1:N).
Un Libro puede estar en varios préstamos (1:N).
Un Préstamo siempre involucra un usuario y un libro.