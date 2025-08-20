

INSERT INTO autores (nombre_autor, nacionalidad, fecha_nacimiento) VALUES
('Gabriel García Márquez', 'Colombiana', '1927-03-06'),
('Isabel Allende', 'Chilena', '1942-08-02'),
('Mario Vargas Llosa', 'Peruana', '1936-03-28'),
('Julio Cortázar', 'Argentina', '1914-08-26'),
('Jorge Luis Borges', 'Argentina', '1899-08-24');

-- Insertar usuarios de ejemplo
INSERT INTO usuarios (nombre, email, telefono) VALUES
('Juan Pérez', 'juan.perez@email.com', '+54-11-1234-5678'),
('María González', 'maria.gonzalez@email.com', '+54-11-8765-4321'),
('Carlos Rodríguez', 'carlos.rodriguez@email.com', '+54-11-5555-6666'),
('Ana Martínez', 'ana.martinez@email.com', '+54-11-7777-8888'),
('Luis Fernández', 'luis.fernandez@email.com', '+54-11-9999-0000');

-- Insertar libros de ejemplo
INSERT INTO libros (titulo, id_autor, genero, anio_publicacion, isbn) VALUES
('Cien años de soledad', 1, 'Realismo mágico', 1967, '978-84-376-0494-7'),
('La casa de los espíritus', 2, 'Realismo mágico', 1982, '978-84-204-2962-7'),
('La ciudad y los perros', 3, 'Novela', 1963, '978-84-322-0441-9'),
('Rayuela', 4, 'Literatura experimental', 1963, '978-84-376-0543-2'),
('El Aleph', 5, 'Cuentos', 1949, '978-84-206-3914-8'),
('Conversación en La Catedral', 3, 'Novela', 1969, '978-84-322-0442-6'),
('Paula', 2, 'Autobiografía', 1994, '978-84-204-2963-4');

-- Insertar préstamos de ejemplo
INSERT INTO prestamos (id_usuario, id_libro, fecha_prestamo, fecha_limite, devuelto, fecha_devolucion) VALUES
(1, 1, '2024-08-01', '2024-08-15', TRUE, '2024-08-14'),
(2, 3, '2024-08-05', '2024-08-19', FALSE, NULL),
(3, 2, '2024-08-10', '2024-08-24', TRUE, '2024-08-22'),
(1, 5, '2024-08-15', '2024-08-29', FALSE, NULL),
(4, 4, '2024-08-18', '2024-09-01', FALSE, NULL);
