

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



