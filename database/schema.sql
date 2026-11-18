-- Esquema Relacional Base de Datos EcoHogar (PostgreSQL)
CREATE TABLE copropiedad (
    id_copropiedad SERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    direccion VARCHAR(150),
    municipio VARCHAR(80) DEFAULT 'San Martín, Cesar'
);

CREATE TABLE inmueble (
    id_inmueble SERIAL PRIMARY KEY,
    tipo VARCHAR(20) CHECK (tipo IN ('Casa', 'Apto', 'Local')),
    numero_identificador VARCHAR(30) NOT NULL,
    id_copropiedad INT REFERENCES copropiedad(id_copropiedad)
);

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(20) CHECK (rol IN ('Admin', 'Residente', 'Comerciante')),
    id_inmueble INT REFERENCES inmueble(id_inmueble)
);

CREATE TABLE pqrs (
    id_pqrs SERIAL PRIMARY KEY,
    codigo_ticket VARCHAR(20) UNIQUE NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    tipo VARCHAR(20) CHECK (tipo IN ('Peticion', 'Queja', 'Reclamo', 'Sugerencia')),
    estado VARCHAR(20) DEFAULT 'Registrado',
    fecha_creacion TIMESTAMP DEFAULT (NOW() AT TIME ZONE 'America/Bogota'),
    id_usuario INT REFERENCES usuario(id_usuario)
);

CREATE TABLE reserva (
    id_reserva SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    estado VARCHAR(20) DEFAULT 'Pendiente',
    id_usuario INT REFERENCES usuario(id_usuario),
    id_espacio INT NOT NULL
);

CREATE TABLE registro_consumo (
    id_registro SERIAL PRIMARY KEY,
    tipo_recurso VARCHAR(20) CHECK (tipo_recurso IN ('Agua', 'Energia')),
    lectura_valor DECIMAL(10,2) CHECK (lectura_valor >= 0),
    costo_estimado DECIMAL(12,2),
    fecha_lectura DATE NOT NULL,
    id_copropiedad INT REFERENCES copropiedad(id_copropiedad)
);
