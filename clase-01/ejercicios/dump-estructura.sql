

-- =============================================
-- TABLA: usuarios
-- =============================================
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_nombre (nombre)
);

-- =============================================
-- TABLA: autores
-- =============================================
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_autor VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE,
    INDEX idx_nacionalidad (nacionalidad),
    INDEX idx_nombre_autor (nombre_autor)
);

-- =============================================
-- TABLA: libros
-- =============================================
CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    id_autor INT NOT NULL,
    genero VARCHAR(50),
    anio_publicacion YEAR,
    isbn VARCHAR(20) UNIQUE,
    disponible BOOLEAN DEFAULT TRUE,
    fecha_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    INDEX idx_titulo (titulo),
    INDEX idx_genero (genero),
    INDEX idx_anio (anio_publicacion),
    INDEX idx_autor (id_autor)
);

-- =============================================
-- TABLA: prestamos
-- =============================================
CREATE TABLE prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_devolucion DATE,
    fecha_limite DATE NOT NULL,
    devuelto BOOLEAN DEFAULT FALSE,
    observaciones TEXT,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
    
    INDEX idx_usuario (id_usuario),
    INDEX idx_libro (id_libro),
    INDEX idx_fecha_prestamo (fecha_prestamo),
    INDEX idx_devuelto (devuelto)
);



--- Todos los datos para ir agregando data prueba..

-- Insertar autores de ejemplo
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
