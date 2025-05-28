-- database/init.sql
-- Script para crear la tabla de pinturas y sus precios/stock por formato
-- con los colores y formatos especificados.

-- Elimina las tablas si ya existen (útil para desarrollo y pruebas)
DROP TABLE IF EXISTS formatos_pintura;
DROP TABLE IF EXISTS pinturas_inventario;

-- Crea la tabla principal para las pinturas
CREATE TABLE pinturas_inventario (
    id SERIAL PRIMARY KEY,
    nombre_pintura VARCHAR(255) NOT NULL,
    color VARCHAR(100) NOT NULL,
    descripcion TEXT,
    imagen_url VARCHAR(255) -- URL a una imagen de la pintura (opcional)
);

-- Crea una tabla para los precios y stock por formato
-- Esto permite flexibilidad si añades más formatos en el futuro
CREATE TABLE formatos_pintura (
    id SERIAL PRIMARY KEY,
    pintura_id INT NOT NULL,
    formato VARCHAR(50) NOT NULL, -- Ej: 'galon', 'medio_galon', 'cuarto'
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    UNIQUE (pintura_id, formato), -- Asegura que no haya duplicados de formato para la misma pintura
    FOREIGN KEY (pintura_id) REFERENCES pinturas_inventario(id) ON DELETE CASCADE
);

-- Inserta datos de ejemplo en la tabla de pinturas con los colores solicitados
INSERT INTO pinturas_inventario (nombre_pintura, color, descripcion, imagen_url) VALUES
('Rojo Primario', 'Rojo', 'El rojo fundamental, vibrante y puro.', 'https://placehold.co/150x150/FF0000/FFFFFF?text=Rojo'),
('Azul Primario', 'Azul', 'Un azul profundo y esencial para cualquier paleta.', 'https://placehold.co/150x150/0000FF/FFFFFF?text=Azul'),
('Amarillo Primario', 'Amarillo', 'El amarillo brillante y base para mezclas.', 'https://placehold.co/150x150/FFFF00/000000?text=Amarillo'),
('Negro Absoluto', 'Negro', 'Negro intenso para sombras y contrastes.', 'https://placehold.co/150x150/000000/FFFFFF?text=Negro'),
('Blanco Puro', 'Blanco', 'Blanco brillante para luminosidad y mezclas.', 'https://placehold.co/150x150/FFFFFF/000000?text=Blanco'),
('Magenta Vibrante', 'Magenta', 'Un magenta intenso y moderno.', 'https://placehold.co/150x150/FF00FF/FFFFFF?text=Magenta'),
('Amarillo Fluorescente', 'Amarillo Fluorescente', 'Un amarillo neón que brilla con intensidad.', 'https://placehold.co/150x150/CCFF00/000000?text=Amarillo+Fluo'),
('Verde Fluorescente', 'Verde Fluorescente', 'Verde neón, ideal para efectos llamativos.', 'https://placehold.co/150x150/00FF00/000000?text=Verde+Fluo'),
('Azul Fluorescente', 'Azul Fluorescente', 'Azul eléctrico que destaca en la oscuridad.', 'https://placehold.co/150x150/00FFFF/000000?text=Azul+Fluo'),
('Naranja Cálido', 'Naranja', 'Un naranja vibrante y enérgico.', 'https://placehold.co/150x150/FFA500/FFFFFF?text=Naranja');

-- Inserta datos de precios y stock para cada formato y color
-- Los precios son inventados y el stock inicial es de 50 para galón, 75 para medio galón, 100 para cuarto.

-- Rojo Primario (ID 1)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(1, 'galon', 28.50, 50),
(1, 'medio_galon', 16.99, 75),
(1, 'cuarto', 9.25, 100);

-- Azul Primario (ID 2)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(2, 'galon', 27.00, 50),
(2, 'medio_galon', 15.75, 75),
(2, 'cuarto', 8.50, 100);

-- Amarillo Primario (ID 3)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(3, 'galon', 26.25, 50),
(3, 'medio_galon', 14.99, 75),
(3, 'cuarto', 8.00, 100);

-- Negro Absoluto (ID 4)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(4, 'galon', 29.99, 50),
(4, 'medio_galon', 17.50, 75),
(4, 'cuarto', 9.75, 100);

-- Blanco Puro (ID 5)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(5, 'galon', 24.00, 50),
(5, 'medio_galon', 13.99, 75),
(5, 'cuarto', 7.50, 100);

-- Magenta Vibrante (ID 6)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(6, 'galon', 31.00, 50),
(6, 'medio_galon', 18.25, 75),
(6, 'cuarto', 10.50, 100);

-- Amarillo Fluorescente (ID 7)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(7, 'galon', 35.50, 50),
(7, 'medio_galon', 20.00, 75),
(7, 'cuarto', 11.75, 100);

-- Verde Fluorescente (ID 8)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(8, 'galon', 34.75, 50),
(8, 'medio_galon', 19.50, 75),
(8, 'cuarto', 11.25, 100);

-- Azul Fluorescente (ID 9)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(9, 'galon', 36.00, 50),
(9, 'medio_galon', 20.25, 75),
(9, 'cuarto', 12.00, 100);

-- Naranja Cálido (ID 10)
INSERT INTO formatos_pintura (pintura_id, formato, precio, stock) VALUES
(10, 'galon', 27.50, 50),
(10, 'medio_galon', 15.99, 75),
(10, 'cuarto', 8.75, 100);