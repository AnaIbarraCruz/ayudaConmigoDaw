-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-06-2022 a las 22:22:54
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ayudaconmigodb2`
--
CREATE DATABASE IF NOT EXISTS `ayudaconmigodb2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ayudaconmigodb2`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `createAlert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createAlert` (IN `dar` DATE, IN `di` VARCHAR(150), IN `aler` VARCHAR(150), IN `anot` VARCHAR(150), IN `pro` INT, IN `ong` INT)  INSERT INTO alerts (id_alert, date_alert, place_alert, allergens_alert, annotation_alert, product, ngo) VALUES (NULL, dar, di, aler, anot, pro, ong)$$

DROP PROCEDURE IF EXISTS `createComment`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createComment` (IN `co` VARCHAR(100), IN `na` VARCHAR(30), IN `id` INT(10))  INSERT INTO comments (id, comment, name_user, id_alert) VALUES (NULL, co, na, id )$$

DROP PROCEDURE IF EXISTS `createNgo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createNgo` (IN `cif` VARCHAR(10), IN `tlf` INT(9), IN `email` VARCHAR(40), IN `nombre` VARCHAR(30), IN `ciudad` VARCHAR(50), IN `codigoP` INT(9), IN `num` VARCHAR(100), IN `calle` VARCHAR(100), IN `coord` VARCHAR(150), IN `funcion` VARCHAR(150), IN `passwd` VARCHAR(255))  INSERT INTO ngos(cif_ngo,phone_ngo,email_ngo,name_ngo,city_ngo,pc_ngo,direct_num_ngo,direc_street_ngo,coordinates_ngo,function_ngo,password_ngo)
VALUES (cif,tlf,email,nombre,ciudad,codigoP,num,calle,coord,funcion,passwd)$$

DROP PROCEDURE IF EXISTS `createReviewNgo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createReviewNgo` (IN `calif` INT(100), IN `coment` VARCHAR(1000), IN `ong` INT(10))  INSERT INTO reviewsong(id_reviewONG,rating,text_,ngo)
VALUES (NULL,calif,coment,ong)$$

DROP PROCEDURE IF EXISTS `createReviewVolunteer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createReviewVolunteer` (IN `calif` INT(100), IN `coment` VARCHAR(1000), IN `volun` INT(10))  INSERT INTO reviewsvolunteer(rating,text_,volunt)
VALUES (calif,coment,volun)$$

DROP PROCEDURE IF EXISTS `createVolunteer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createVolunteer` (IN `userV` VARCHAR(20), IN `nameV` VARCHAR(40), IN `s1V` VARCHAR(40), IN `s2V` VARCHAR(40), IN `emV` VARCHAR(40), IN `regV` VARCHAR(25), IN `pass` VARCHAR(255), IN `checkEmail` BOOLEAN)  INSERT INTO volunteers(user_,name_volunteer,surname1_volunteer,surname2_volunteer,email_volunteer,region_volunteer,password_volunteer,request)
VALUES (userV,nameV,s1V,s2V,emV,regV,pass,checkEmail)$$

DROP PROCEDURE IF EXISTS `deleteAlert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAlert` (IN `id` INT)  DELETE FROM alerts WHERE alerts.id_alert = id$$

DROP PROCEDURE IF EXISTS `deleteNgo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteNgo` (IN `id` INT(10))  DELETE FROM ngos
WHERE ngos.id_ngo = id$$

DROP PROCEDURE IF EXISTS `deleteVolunteer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteVolunteer` (IN `id` INT(10))  DELETE FROM volunteers
WHERE volunteers.id_volunteer = id$$

DROP PROCEDURE IF EXISTS `getAlert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAlert` ()  SELECT * FROM alerts$$

DROP PROCEDURE IF EXISTS `getAlertByFilter`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAlertByFilter` (IN `fil` VARCHAR(150))  SELECT alerts.id_alert, alerts.date_alert, alerts.place_alert, alerts.allergens_alert, alerts.annotation_alert, products.name_product, ngos.name_ngo FROM alerts
INNER JOIN products ON products.id_product = alerts.product
INNER JOIN ngos ON ngos.id_ngo = alerts.ngo
WHERE products.name_product LIKE CONCAT ('%', fil, '%')$$

DROP PROCEDURE IF EXISTS `getAlertHome`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAlertHome` ()  SELECT alerts.id_alert, alerts.date_alert, alerts.place_alert, alerts.allergens_alert, alerts.annotation_alert, products.name_product, ngos.name_ngo FROM alerts
INNER JOIN products ON products.id_product = alerts.product
INNER JOIN ngos ON ngos.id_ngo = alerts.ngo$$

DROP PROCEDURE IF EXISTS `getCommentById`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCommentById` (IN `id` INT)  SELECT comments.comment, comments.name_user FROM comments WHERE comments.id_alert = id$$

DROP PROCEDURE IF EXISTS `getEmailUsers`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getEmailUsers` (IN `bol` INT)  SELECT volunteers.email_volunteer FROM volunteers WHERE volunteers.request = bol$$

DROP PROCEDURE IF EXISTS `getNgoByCif`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNgoByCif` (IN `cif` VARCHAR(10))  SELECT ngos.cif_ngo, ngos.password_ngo, ngos.name_ngo, ngos.id_ngo FROM ngos WHERE ngos.cif_ngo = cif$$

DROP PROCEDURE IF EXISTS `getNgoData`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNgoData` ()  SELECT ngos.phone_ngo, ngos.email_ngo, ngos.name_ngo, ngos.city_ngo, ngos.direc_street_ngo, ngos.direct_num_ngo, ngos.function_ngo FROM ngos$$

DROP PROCEDURE IF EXISTS `getOngByNombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getOngByNombre` (IN `nom` VARCHAR(30))  SELECT*
FROM ngos 
WHERE name_ngo=nom$$

DROP PROCEDURE IF EXISTS `getProductbyId`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductbyId` (IN `id` INT)  SELECT * FROM products WHERE products.id_product = id$$

DROP PROCEDURE IF EXISTS `getProductByType`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductByType` (IN `type` VARCHAR(30))  SELECT products.id_product, products.name_product, products.type_product FROM products WHERE products.type_product = type$$

DROP PROCEDURE IF EXISTS `getReviewNgo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getReviewNgo` ()  SELECT reviewsong.rating, reviewsong.text_, ngos.name_ngo FROM reviewsong INNER JOIN ngos ON ngos.id_ngo = reviewsong.ngo$$

DROP PROCEDURE IF EXISTS `getReviewVol`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getReviewVol` ()  SELECT reviewsvolunteer.rating, reviewsvolunteer.text_, volunteers.name_volunteer FROM reviewsvolunteer INNER JOIN volunteers ON reviewsvolunteer.volunt = volunteers.id_volunteer$$

DROP PROCEDURE IF EXISTS `getTypeProducts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTypeProducts` ()  SELECT DISTINCT products.type_product FROM products$$

DROP PROCEDURE IF EXISTS `getVolunteerByUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getVolunteerByUser` (IN `nom` VARCHAR(20))  SELECT volunteers.id_volunteer, volunteers.user_, volunteers.password_volunteer
FROM volunteers
WHERE volunteers.user_ = nom$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerts`
--

DROP TABLE IF EXISTS `alerts`;
CREATE TABLE `alerts` (
  `id_alert` int(10) NOT NULL,
  `date_alert` date NOT NULL,
  `place_alert` varchar(150) NOT NULL,
  `allergens_alert` varchar(150) DEFAULT NULL,
  `annotation_alert` varchar(150) DEFAULT NULL,
  `product` int(10) NOT NULL,
  `ngo` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alerts`
--

INSERT INTO `alerts` (`id_alert`, `date_alert`, `place_alert`, `allergens_alert`, `annotation_alert`, `product`, `ngo`) VALUES
(14, '2022-06-03', 'C/Salado 8', 'NINGUNO', '3 LATAS DE ATÚN', 18, 19),
(15, '2022-06-02', 'C/Salado 8', 'No', 'Tampones maxi', 24, 19),
(45, '2022-06-25', 'Calle Cuenta 56, 28289, Madrid', '----', 'Talla M', 8, 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `name_user` varchar(30) NOT NULL,
  `id_alert` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comments`
--

INSERT INTO `comments` (`id`, `comment`, `name_user`, `id_alert`) VALUES
(26, 'llevaré 67', 'ana', 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ngos`
--

DROP TABLE IF EXISTS `ngos`;
CREATE TABLE `ngos` (
  `cif_ngo` varchar(10) NOT NULL,
  `id_ngo` int(10) NOT NULL,
  `phone_ngo` int(9) NOT NULL,
  `email_ngo` varchar(40) NOT NULL,
  `name_ngo` varchar(30) NOT NULL,
  `city_ngo` varchar(50) NOT NULL,
  `pc_ngo` int(5) NOT NULL,
  `direct_num_ngo` varchar(100) NOT NULL,
  `direc_street_ngo` varchar(100) NOT NULL,
  `coordinates_ngo` varchar(150) NOT NULL,
  `function_ngo` varchar(150) NOT NULL,
  `password_ngo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ngos`
--

INSERT INTO `ngos` (`cif_ngo`, `id_ngo`, `phone_ngo`, `email_ngo`, `name_ngo`, `city_ngo`, `pc_ngo`, `direct_num_ngo`, `direc_street_ngo`, `coordinates_ngo`, `function_ngo`, `password_ngo`) VALUES
('G82875253', 18, 914490690, 'fundacion@madrina.org', 'FUNDACIÓN MADRINA', 'Madrid', 28020, '26', 'C/ Limonero', '40.46264001014919, -3.69584294487826', 'Repartición ropa y comida', '$2a$10$AVObreChFCLt8BgsGBXoaefggjb49l2W3dYmEYCqRcAzlw1PMg8Vi'),
('G87795167', 19, 667398471, 'info@asociacionpatoamarillo.org', 'SUR- EL PATO AMARILLO ', 'Madrid', 28041, '8', 'C/Salado ', '40.37023935261017, -3.6981266295390305', 'Recogida ropa y comida', '$2a$10$x0rYZ/b.2gVF/QeEdi9lBeJ4Y7BqLzOgiaAo4tJ2ylPfM1AE9jOCK'),
('G28485779', 20, 913643940, 'info@mensajerosdelapaz.com ', 'MENSAJEROS DE LA PAZ', 'Madrid', 28005, '9', 'Plaza General Vara de Rey', '40.40936321175637, -3.708517429537785', 'Recogida de comida y ropa', '$2a$10$SZxEVGtbrlmO502SI9roWe72C6cZ87.14IV8wqfaU3z/4JYsb1Aee'),
('G86187069', 30, 913567400, 'comedorsocial@manosayudasocial.org', 'ASOC. MANOS DE AYUDA SOCIAL', 'MADRID', 28018, '10', 'LA REINA DE AFRICA', '40.38293917605815, -3.661138830909182', 'Repartición comida y ropa', '$2a$10$ah4LtXWMB5aznbp6oDCIV.057uBf99AV0pv2QfP2C.9fxsH.VnvOG'),
('G12866001', 31, 900104971, 'informa@cruzroja.es', 'CRUZ ROJA', 'Madrid', 28003, '26-28', 'Av. Reina Victoria', '40.44742081108939, -3.709669242329439', 'Recogida de ropa y comida', '$2a$10$nEwjQMZTVk4uAVN9wnB5me5kNKzS2D5zRD9TsCYMPQ2I9hDSCZGsG'),
('G86227105', 32, 913665156, 'info@fundacionpanypeces.org', 'FUNDACIÓN PAN Y PECES', 'Madrid', 28010, '12', 'C. de Medellín,', '40.43705922092263, -3.6997657656249587', 'Repartición comida y ropa', '$2a$10$K3jp0k.GXjcT0fnVreEAGucQpmPIDMa1U0iclpzeyyBWJa0t1E0eS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id_product` int(10) NOT NULL,
  `name_product` varchar(100) NOT NULL,
  `type_product` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id_product`, `name_product`, `type_product`) VALUES
(1, 'Verduras,hortalizas,frutas', 'Comida'),
(2, 'Lácteos y derivados', 'Comida'),
(8, 'Calzado Adulto', 'Ropa'),
(9, 'Calzado Niño', 'Ropa'),
(13, 'Potitos/Leche de fórmula', 'Comida'),
(14, 'Huevos y ovoproductos', 'Comida'),
(15, 'Harinas y derivados', 'Comida'),
(16, 'Cereales', 'Comida'),
(17, ' Café y demás alimentos estimulantes y derivados', 'Comida'),
(18, 'Conservas animales y vegetales', 'Comida'),
(19, 'Platos preparados, productos dietéticos y de régimen', 'Comida'),
(20, 'Bebidas no alcohólicas', 'Comida'),
(21, 'Agua', 'Comida'),
(24, 'Medicamentos y productos sanitarios', 'Productos no alimenticios'),
(25, 'Higiene personal', 'Productos no alimenticios'),
(26, 'Limpieza del hogar', 'Productos no alimenticios'),
(27, 'Pañales', 'Productos no alimenticios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `request`
--

DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `id_request` int(10) NOT NULL,
  `select_` tinyint(1) NOT NULL,
  `id_alert` int(10) NOT NULL,
  `product` int(10) NOT NULL,
  `volun` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reviewsong`
--

DROP TABLE IF EXISTS `reviewsong`;
CREATE TABLE `reviewsong` (
  `id_reviewONG` int(10) NOT NULL,
  `rating` int(100) NOT NULL,
  `text_` varchar(1000) DEFAULT NULL,
  `ngo` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reviewsvolunteer`
--

DROP TABLE IF EXISTS `reviewsvolunteer`;
CREATE TABLE `reviewsvolunteer` (
  `id_reviewVolunteer` int(10) NOT NULL,
  `rating` int(100) NOT NULL,
  `text_` varchar(1000) DEFAULT NULL,
  `volunt` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `volunteers`
--

DROP TABLE IF EXISTS `volunteers`;
CREATE TABLE `volunteers` (
  `id_volunteer` int(10) NOT NULL,
  `user_` varchar(20) NOT NULL,
  `name_volunteer` varchar(40) NOT NULL,
  `surname1_volunteer` varchar(40) NOT NULL,
  `surname2_volunteer` varchar(40) NOT NULL,
  `email_volunteer` varchar(40) NOT NULL,
  `region_volunteer` varchar(25) NOT NULL,
  `password_volunteer` varchar(255) NOT NULL,
  `request` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `volunteers`
--

INSERT INTO `volunteers` (`id_volunteer`, `user_`, `name_volunteer`, `surname1_volunteer`, `surname2_volunteer`, `email_volunteer`, `region_volunteer`, `password_volunteer`, `request`) VALUES
(29, 'juanandres23', 'JUAN', 'Ortiz', 'Valle', 'vallejortiz@gmail.com', 'Madrid', '$2a$10$qkzzJbj1V2CEe3lpT6e0mOZJd6e/AaWiElaGwjPoHhEcCgWOnabqO', 0),
(32, 'pedrorodrii89', 'PEDRO', 'Rodriguez', 'Lorens', 'lorenspedro@gmail.com', 'Madrid', '$2a$10$ahmo7PluRWUXW9ltQJSlCeaoC6FVtDEY5Y7Z5cuNUmmnrlNjvnGAG', 0),
(33, 'petraflores12', 'PETRA', 'Flores', 'Flores', 'floressecas@gmail.com', 'Madrid', '$2a$10$izJM79vqbjqVLAKRdoN.C.RGo6.Brd/cnv2FntM8dJy5UIB4o.DMi', 0),
(34, 'tinorem67', 'ANTONIO', 'Resines', 'Trigo', 'tinito@gmail.com', 'Toledo', '$2a$10$ViaIs7dB4xxTqYeJZBErou1oqshTH58NSMW0q0clr.YjY6H39yaxi', 0),
(35, 'cristina63tre', 'CRISTINA MARIA', 'Lopez', 'Hermosilla', 'Hermolop@gmail.com', 'Madrid', '$2a$10$L/ttZTYKKpjAilgLPVAI7.9Q6wQl0AZYu09.Ba.rRbWIbGzeb5Mbq', 0),
(36, 'castrop1998', 'LORENZO', 'Castro', 'Pérez', 'perezcas@gmail.com', 'Madrid', '$2a$10$FLwyeZ7odWAP9yLbMe4BWu8XUBPp1r.gHrk/Ha8Hmb7IIGGwK5lHe', 0),
(37, 'ARANTXA24', 'ARANTXA', 'ECHEGUI', 'GARCIA', 'ARANTXA24@GMAIL.COM', 'TOLEDO', '$2a$10$RY4dyMSId/dRz2ZlR1hfKuMKM0IKXAvEwQvvmDfRYx0lMy/Iu7wVi', 0),
(38, 'GLORIA56', 'GLORIA', 'LOPEZ', 'PEÑA', 'penyalopez@GMAIL.COM', 'TOLEDO', '$2a$10$Eaf7eRWU0Ez75rsDeeFJDOh6rRs.MSxKPicqqmxBZDbw8CcvORJAa', 0),
(39, 'damian98', 'DAMIAN', 'Malik', 'Muro', 'mmdamian@gmail.com', 'Madrid', '$2a$10$./JdHG92OgpXtRBTdJeQIuM7AxC2Si5KtdNDYgWEHYPOx3jFNk1/K', 0),
(40, 'juanpe874', 'JUAN PEDRO', 'Perez', 'Fisu', 'fisupe@gmail.com', 'Toledo', '$2a$10$daEXFVb0JRq/BvA2MtzA4.JaaDAmYJqRJD5FRlyc93CQL2aRaz0Na', 0),
(43, 'anasan', 'ANA', 'Ibarra', 'Cruz', 'anaibarracruz@hotmail.com', 'Madrid', '$2a$10$p5szw95tgAYXLbdRWWNjQuySJA65XWiyl0ZQvyAA3he6l1b8dFqaS', 1),
(44, 'irene', 'IRENE', 'Jimenez', 'Pozuelo', 'iremunlop@gmail.com', 'Madrid', '$2a$10$xSK7mpr8Dori9s6I4kHpL.ND5.r6jiykaksUCqIHwpUx3WcMMF41G', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id_alert`,`product`,`ngo`),
  ADD UNIQUE KEY `id_alert` (`id_alert`),
  ADD KEY `products_FK` (`product`),
  ADD KEY `NGOS2_FK` (`ngo`);

--
-- Indices de la tabla `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_alert` (`id_alert`);

--
-- Indices de la tabla `ngos`
--
ALTER TABLE `ngos`
  ADD PRIMARY KEY (`id_ngo`),
  ADD UNIQUE KEY `cif_ngo` (`cif_ngo`),
  ADD UNIQUE KEY `phone_ngo` (`phone_ngo`),
  ADD UNIQUE KEY `email_ngo` (`email_ngo`);

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id_product`);

--
-- Indices de la tabla `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`id_request`),
  ADD KEY `alert_FK` (`id_alert`),
  ADD KEY `product_FK` (`product`),
  ADD KEY `volunt_FK` (`volun`);

--
-- Indices de la tabla `reviewsong`
--
ALTER TABLE `reviewsong`
  ADD PRIMARY KEY (`id_reviewONG`,`ngo`),
  ADD KEY `NGOS22_FK` (`ngo`);

--
-- Indices de la tabla `reviewsvolunteer`
--
ALTER TABLE `reviewsvolunteer`
  ADD PRIMARY KEY (`id_reviewVolunteer`,`volunt`),
  ADD KEY `VOL_FK` (`volunt`);

--
-- Indices de la tabla `volunteers`
--
ALTER TABLE `volunteers`
  ADD PRIMARY KEY (`id_volunteer`),
  ADD UNIQUE KEY `id_volunteer` (`id_volunteer`),
  ADD UNIQUE KEY `user_` (`user_`),
  ADD UNIQUE KEY `email_volunteer` (`email_volunteer`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id_alert` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `ngos`
--
ALTER TABLE `ngos`
  MODIFY `id_ngo` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id_product` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `request`
--
ALTER TABLE `request`
  MODIFY `id_request` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reviewsong`
--
ALTER TABLE `reviewsong`
  MODIFY `id_reviewONG` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `reviewsvolunteer`
--
ALTER TABLE `reviewsvolunteer`
  MODIFY `id_reviewVolunteer` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `volunteers`
--
ALTER TABLE `volunteers`
  MODIFY `id_volunteer` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alerts`
--
ALTER TABLE `alerts`
  ADD CONSTRAINT `NGOS2_FK` FOREIGN KEY (`ngo`) REFERENCES `ngos` (`id_ngo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_FK` FOREIGN KEY (`product`) REFERENCES `products` (`id_product`);

--
-- Filtros para la tabla `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`id_alert`) REFERENCES `alerts` (`id_alert`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `alert_FK` FOREIGN KEY (`id_alert`) REFERENCES `alerts` (`id_alert`),
  ADD CONSTRAINT `product_FK` FOREIGN KEY (`product`) REFERENCES `products` (`id_product`),
  ADD CONSTRAINT `volunt_FK` FOREIGN KEY (`volun`) REFERENCES `volunteers` (`id_volunteer`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reviewsong`
--
ALTER TABLE `reviewsong`
  ADD CONSTRAINT `reviewsong_ibfk_1` FOREIGN KEY (`ngo`) REFERENCES `ngos` (`id_ngo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reviewsvolunteer`
--
ALTER TABLE `reviewsvolunteer`
  ADD CONSTRAINT `VOL_FK` FOREIGN KEY (`volunt`) REFERENCES `volunteers` (`id_volunteer`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
