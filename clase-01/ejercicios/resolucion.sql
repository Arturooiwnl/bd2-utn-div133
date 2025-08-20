

-- A) Mostrar todos los libros con sus autores
SELECT 
    titulo,
    nombre_autor,
    genero,
    anio_publicacion
FROM libros 
JOIN autores ON libros.id_autor = autores.id_autor;


-- B) Préstamos que aún no se han devuelto
SELECT 
    nombre AS usuario,
    titulo AS libro,
    fecha_prestamo,
    fecha_limite
FROM prestamos 
JOIN usuarios ON prestamos.id_usuario = usuarios.id_usuario
JOIN libros ON prestamos.id_libro = libros.id_libro
WHERE fecha_devolucion IS NULL;


-- C) Usuarios que han prestado libros de "Ficción"
SELECT DISTINCT
    nombre AS usuario,
    email
FROM usuarios 
JOIN prestamos ON usuarios.id_usuario = prestamos.id_usuario
JOIN libros ON prestamos.id_libro = libros.id_libro
WHERE genero = 'Ficción';


-- D) Contar préstamos por usuario
SELECT 
    nombre AS usuario,
    COUNT(*) AS total_prestamos
FROM usuarios 
JOIN prestamos ON usuarios.id_usuario = prestamos.id_usuario
GROUP BY nombre
ORDER BY total_prestamos DESC;


-- E) Autores con más de un libro
SELECT 
    nombre_autor,
    COUNT(*) AS cantidad_libros
FROM autores 
JOIN libros ON autores.id_autor = libros.id_autor
GROUP BY nombre_autor
HAVING COUNT(*) > 1;


-- F) Libros que nunca se han prestado
SELECT 
    titulo,
    nombre_autor,
    genero
FROM libros 
JOIN autores ON libros.id_autor = autores.id_autor
LEFT JOIN prestamos ON libros.id_libro = prestamos.id_libro
WHERE prestamos.id_libro IS NULL;