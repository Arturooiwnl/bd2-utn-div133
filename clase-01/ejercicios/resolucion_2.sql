-- =============================================
-- CONSULTAS SQL - EJERCICIOS CLASE 01
-- Base de datos: gestionbiblioteca
-- =============================================

-- =============================================
-- EJERCICIO A) Obtener todos los libros junto con sus autores
-- =============================================

/*
EXPLICACIÓN:
- Usamos INNER JOIN para unir las tablas libros y autores
- La relación se establece a través del campo id_autor
- INNER JOIN solo muestra registros que tienen coincidencia en ambas tablas
- Seleccionamos campos relevantes de ambas tablas
*/

SELECT 
    l.id_libro,
    l.titulo,
    l.genero,
    l.anio_publicacion,
    l.isbn,
    a.nombre_autor,
    a.nacionalidad,
    a.fecha_nacimiento
FROM libros l
INNER JOIN autores a ON l.id_autor = a.id_autor
ORDER BY l.titulo;






-- =============================================
-- EJERCICIO B) Listar los préstamos activos (fecha_devolucion es NULL)
-- =============================================

/*
EXPLICACIÓN:
- Filtramos con WHERE fecha_devolucion IS NULL (préstamos no devueltos)
- Usamos INNER JOIN para obtener información completa del usuario y libro
- También podríamos usar WHERE devuelto = FALSE como alternativa
- Mostramos información relevante para el seguimiento de préstamos
*/

SELECT 
    p.id_prestamo,
    u.nombre AS usuario,
    u.email,
    l.titulo AS libro,
    a.nombre_autor AS autor,
    p.fecha_prestamo,
    p.fecha_limite,
    DATEDIFF(p.fecha_limite, CURDATE()) AS dias_restantes
FROM prestamos p
INNER JOIN usuarios u ON p.id_usuario = u.id_usuario
INNER JOIN libros l ON p.id_libro = l.id_libro
INNER JOIN autores a ON l.id_autor = a.id_autor
WHERE p.fecha_devolucion IS NULL
ORDER BY p.fecha_limite;






-- =============================================
-- EJERCICIO C) Usuarios que han tomado prestado libros de género específico
-- =============================================

/*
EXPLICACIÓN:
- Usamos múltiples INNER JOIN para conectar usuarios -> prestamos -> libros
- Filtramos por género específico (ejemplo: 'Realismo mágico')
- DISTINCT evita que aparezcan usuarios duplicados si han tomado varios libros del mismo género
- Podemos cambiar el género en el WHERE según necesitemos
*/

-- Ejemplo con género "Realismo mágico"
SELECT DISTINCT
    u.id_usuario,
    u.nombre,
    u.email,
    l.genero
FROM usuarios u
INNER JOIN prestamos p ON u.id_usuario = p.id_usuario
INNER JOIN libros l ON p.id_libro = l.id_libro
WHERE l.genero = 'Realismo mágico'
ORDER BY u.nombre;

-- Versión más detallada mostrando qué libros tomaron
SELECT 
    u.nombre AS usuario,
    l.titulo AS libro,
    l.genero,
    p.fecha_prestamo
FROM usuarios u
INNER JOIN prestamos p ON u.id_usuario = p.id_usuario
INNER JOIN libros l ON p.id_libro = l.id_libro
WHERE l.genero = 'Realismo mágico'
ORDER BY u.nombre, p.fecha_prestamo;





-- =============================================
-- EJERCICIO D) Contar cuántos libros ha tomado prestado cada usuario
-- =============================================

/*
EXPLICACIÓN:
- Usamos LEFT JOIN para incluir usuarios que nunca tomaron préstamos
- GROUP BY agrupa por usuario para poder contar
- COUNT(p.id_prestamo) cuenta solo los préstamos no nulos
- COALESCE maneja el caso de usuarios sin préstamos (NULL -> 0)
- ORDER BY cantidad DESC muestra primero a los usuarios más activos
*/

SELECT 
    u.id_usuario,
    u.nombre,
    u.email,
    COALESCE(COUNT(p.id_prestamo), 0) AS total_prestamos,
    COUNT(CASE WHEN p.devuelto = FALSE THEN 1 END) AS prestamos_activos,
    COUNT(CASE WHEN p.devuelto = TRUE THEN 1 END) AS prestamos_devueltos
FROM usuarios u
LEFT JOIN prestamos p ON u.id_usuario = p.id_usuario
GROUP BY u.id_usuario, u.nombre, u.email
ORDER BY total_prestamos DESC, u.nombre;





-- =============================================
-- EJERCICIO E) Autores que tienen más de un libro en la biblioteca
-- =============================================

/*
EXPLICACIÓN:
- GROUP BY agrupa por autor para poder contar sus libros
- HAVING filtra grupos después de la agregación (diferente a WHERE)
- COUNT(l.id_libro) > 1 selecciona solo autores con más de un libro
- Mostramos información del autor y cuántos libros tiene
*/

SELECT 
    a.id_autor,
    a.nombre_autor,
    a.nacionalidad,
    COUNT(l.id_libro) AS cantidad_libros
FROM autores a
INNER JOIN libros l ON a.id_autor = l.id_autor
GROUP BY a.id_autor, a.nombre_autor, a.nacionalidad
HAVING COUNT(l.id_libro) > 1
ORDER BY cantidad_libros DESC, a.nombre_autor;

-- Versión detallada que muestra qué libros tiene cada autor
SELECT 
    a.nombre_autor,
    a.nacionalidad,
    COUNT(l.id_libro) AS total_libros,
    GROUP_CONCAT(l.titulo ORDER BY l.anio_publicacion SEPARATOR ' | ') AS libros
FROM autores a
INNER JOIN libros l ON a.id_autor = l.id_autor
GROUP BY a.id_autor, a.nombre_autor, a.nacionalidad
HAVING COUNT(l.id_libro) > 1
ORDER BY total_libros DESC;




-- =============================================
-- EJERCICIO F) Libros que no han sido prestados nunca
-- =============================================

/*
EXPLICACIÓN:
- Usamos LEFT JOIN para incluir todos los libros
- WHERE p.id_libro IS NULL identifica libros sin préstamos
- Esta consulta es útil para identificar libros poco populares
- También mostramos información del autor para contexto
*/

SELECT 
    l.id_libro,
    l.titulo,
    a.nombre_autor,
    l.genero,
    l.anio_publicacion,
    l.isbn,
    l.fecha_ingreso
FROM libros l
INNER JOIN autores a ON l.id_autor = a.id_autor
LEFT JOIN prestamos p ON l.id_libro = p.id_libro
WHERE p.id_libro IS NULL
ORDER BY l.fecha_ingreso DESC;

-- Alternativa usando NOT EXISTS (más eficiente en grandes volúmenes)
SELECT 
    l.id_libro,
    l.titulo,
    a.nombre_autor,
    l.genero,
    l.anio_publicacion
FROM libros l
INNER JOIN autores a ON l.id_autor = a.id_autor
WHERE NOT EXISTS (
    SELECT 1 
    FROM prestamos p 
    WHERE p.id_libro = l.id_libro
)
ORDER BY l.titulo;

-- =============================================
-- CONSULTAS BONUS PARA LA CLASE
-- =============================================

-- BONUS 1: Libros más prestados
SELECT 
    l.titulo,
    a.nombre_autor,
    COUNT(p.id_prestamo) AS veces_prestado
FROM libros l
INNER JOIN autores a ON l.id_autor = a.id_autor
INNER JOIN prestamos p ON l.id_libro = p.id_libro
GROUP BY l.id_libro, l.titulo, a.nombre_autor
ORDER BY veces_prestado DESC
LIMIT 5;

-- BONUS 2: Préstamos vencidos
SELECT 
    u.nombre AS usuario,
    l.titulo AS libro,
    p.fecha_limite,
    DATEDIFF(CURDATE(), p.fecha_limite) AS dias_vencido
FROM prestamos p
INNER JOIN usuarios u ON p.id_usuario = u.id_usuario
INNER JOIN libros l ON p.id_libro = l.id_libro
WHERE p.devuelto = FALSE 
  AND p.fecha_limite < CURDATE()
ORDER BY dias_vencido DESC;

-- BONUS 3: Estadísticas generales
SELECT 
    'Total usuarios' AS concepto,
    COUNT(*) AS cantidad
FROM usuarios
UNION ALL
SELECT 
    'Total libros',
    COUNT(*)
FROM libros
UNION ALL
SELECT 
    'Total autores',
    COUNT(*)
FROM autores
UNION ALL
SELECT 
    'Préstamos activos',
    COUNT(*)
FROM prestamos
WHERE devuelto = FALSE
UNION ALL
SELECT 
    'Libros disponibles',
    COUNT(*)
FROM libros
WHERE disponible = TRUE;
