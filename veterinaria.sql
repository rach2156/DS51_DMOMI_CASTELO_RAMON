CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(255),
    direccion VARCHAR(255)
);

CREATE TABLE mascotas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(50),
    raza VARCHAR(100),
    edad INT,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE consultas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    motivo TEXT,
    diagnostico TEXT,
    tratamiento TEXT,
    mascota_id INT,
    FOREIGN KEY (mascota_id) REFERENCES mascotas(id)
);
