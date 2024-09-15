-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-09-2024 a las 19:30:54
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_gastos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ahorros`
--

CREATE TABLE `ahorros` (
  `id_ahorro` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `saldo_actual` float DEFAULT 0,
  `saldo_meta` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bancos`
--

CREATE TABLE `bancos` (
  `id_banco` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `nombre_banco` varchar(100) DEFAULT NULL,
  `pagos` float DEFAULT 0,
  `saldo` float DEFAULT 0,
  `fondos` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastos`
--

CREATE TABLE `gastos` (
  `id_gasto` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `gasto_fijo` float DEFAULT 0,
  `gasto_diario` float DEFAULT 0,
  `gasto_hormiga` float DEFAULT 0,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `gastos`
--

INSERT INTO `gastos` (`id_gasto`, `id_usuario`, `gasto_fijo`, `gasto_diario`, `gasto_hormiga`, `fecha`) VALUES
(1, 1, 343, 12, 2, '2024-09-14'),
(2, 2, 300, 35, 22, '2024-09-14'),
(3, 2, 500, 50, 20, '2024-09-15'),
(4, 3, 1000, 200, 50, '2024-09-15'),
(6, 5, 20000, 100, 25, '2024-09-15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `predicciones_gastos`
--

CREATE TABLE `predicciones_gastos` (
  `id_prediccion` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `gasto_estimado` float DEFAULT 0,
  `fecha_estimacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contraseña` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellido`, `correo`, `contraseña`) VALUES
(1, 'manuel', 'rubio', 'mane@123', '1234'),
(2, 'Manuel', 'Rubio', 'manu@gmail.com', '1234'),
(3, 'Alan', 'Alvarado', 'luigialv76@gmail.com', 'alanalva76'),
(5, 'emiliano', 'Piolin', 'emiviolin@gmail.com', '0987'),
(6, 'Mario', 'Lira', 'mario@gmail.com', 'mario1'),
(7, 'angel', 'Nevarez', 'Angel@gmail.com', 'angel1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ahorros`
--
ALTER TABLE `ahorros`
  ADD PRIMARY KEY (`id_ahorro`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `bancos`
--
ALTER TABLE `bancos`
  ADD PRIMARY KEY (`id_banco`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `gastos`
--
ALTER TABLE `gastos`
  ADD PRIMARY KEY (`id_gasto`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `predicciones_gastos`
--
ALTER TABLE `predicciones_gastos`
  ADD PRIMARY KEY (`id_prediccion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ahorros`
--
ALTER TABLE `ahorros`
  MODIFY `id_ahorro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bancos`
--
ALTER TABLE `bancos`
  MODIFY `id_banco` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id_gasto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `predicciones_gastos`
--
ALTER TABLE `predicciones_gastos`
  MODIFY `id_prediccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ahorros`
--
ALTER TABLE `ahorros`
  ADD CONSTRAINT `ahorros_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `bancos`
--
ALTER TABLE `bancos`
  ADD CONSTRAINT `bancos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `gastos`
--
ALTER TABLE `gastos`
  ADD CONSTRAINT `gastos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `predicciones_gastos`
--
ALTER TABLE `predicciones_gastos`
  ADD CONSTRAINT `predicciones_gastos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
