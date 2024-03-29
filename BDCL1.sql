USE MASTER 
GO 

if db_id('FUENTESODA') is not null
		drop database FUENTESODA
go	

CREATE DATABASE FUENTESODA
GO

USE FUENTESODA
go

--Creando las Tablas 
CREATE TABLE CATEGORIA(
	IDE_CAT		INT				NOT NULL	PRIMARY KEY IDENTITY(1,1),
	DES_CAT		VARCHAR(35)		NOT NULL
)
GO

CREATE TABLE PRODUCTO(
	IDE_PRO		INT			NOT NULL	PRIMARY KEY IDENTITY(100,1),
	DES_PRO		VARCHAR(40) NOT NULL,
	IDE_CAT		INT			NOT NULL REFERENCES CATEGORIA,
	PRE_PRO		MONEY		NOT NULL,
	STO_PRO		INT			NOT NULL,
	IMG_PRO		VARCHAR(100) NULL
)
GO

CREATE TABLE DISTRITO(
	IDE_DIS		INT			NOT NULL	PRIMARY KEY IDENTITY(1,1),
	DES_DIS		VARCHAR(50)
)
go

CREATE TABLE CLIENTE(
	IDE_CLI		INT			NOT NULL	PRIMARY KEY IDENTITY(1000,1),
	NOM_CLI		VARCHAR(50) NOT NULL,
	MOV_CLI		VARCHAR(15)		NULL,
	IDE_DIS		INT			NOT NULL REFERENCES DISTRITO,
	COR_CLI		VARCHAR(50) NULL
)
GO

CREATE TABLE VENDEDOR(
	IDE_VEN		INT		NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOM_VEN		VARCHAR(30) NOT NULL,
	APE_VEN		VARCHAR(30) NOT NULL,
	DIR_VEN		VARCHAR(50) NULL,
	TEL_VEN		VARCHAR(15)		NULL,
	IDE_DIS		INT			NOT NULL REFERENCES DISTRITO,
	COR_VEN		VARCHAR(50) NULL,
	SUE_VEN		MONEY		NOT NULL
)
GO

CREATE TABLE BOLETA(
	NUM_BOL		INT			NOT NULL PRIMARY KEY IDENTITY(1,1),
	FEC_BOL		DATE		NOT NULL,
	IDE_CLI		INT			NOT NULL REFERENCES CLIENTE,
	IDE_VEN		INT			NOT NULL REFERENCES VENDEDOR
)
GO

CREATE TABLE DETALLEBOLETA(
	NUM_BOL		INT			not null REFERENCES BOLETA,
	IDE_PRO		INT			NOT NULL REFERENCES PRODUCTO,
	CAN_ART		INT			NOT NULL
	PRIMARY KEY (NUM_BOL, IDE_PRO)
)
GO

--Insertando los registros a las Tablas
INSERT INTO DISTRITO(DES_DIS) VALUES
('CERCADO'),
('ANCON'),
('ATE'),
('BARRANCO'),
('BREÑA'),
('CARABAYLLO'),
('COMAS'),
('CHACLACAYO'),
('CHORRILLOS'),
('EL AGUSTINO'),
('JESUS MARIA'),
('LA MOLINA'),
('LA VICTORIA'),
('LINCE'),
('LURIGANCHO'),
('LURIN'),
('MAGDALENA'),
('MIRAFLORES'),
('PACHACAMAC'),
('PUCUSANA')
GO

INSERT INTO CATEGORIA(DES_CAT) VALUES
('JUGOS'),
('SANDWICHS'),
('POSTRES'),
('BEBIDAS CALIENTES'),
('BEBIDAS FRIAS')
GO
INSERT INTO PRODUCTO(DES_PRO,IDE_CAT,PRE_PRO,STO_PRO,IMG_PRO) VALUES 
('PYE DE MANZANA',3,5,50,'~/fotos/1.jpg'),
('TORTA DE CHOCOLATE',3,5,100,'~/fotos/2.jpg'),
('TORTA TRES LECHES',3,8,40,'~/fotos/3.jpg'),
('MOUSE DE MANZANA',3,7,70,'~/fotos/4.jpg'),
('ARROZ CON LECHE - ENVASE ESPECIAL',3,10.00,40,'~/fotos/5.jpg'),
('MAZAMORRA MORADA',3,4.50,70,'~/fotos/6.jpg'),
('YOGURT ARABE',3,9,100,'~/fotos/7.jpg'),
('PAN CON POLLO',2,4.50,500,'~/fotos/8.jpg'),
('BROWNIE',3,7,300,'~/fotos/9.jpg'),
('BESO DE MOZA',3,1,400,'~/fotos/10.jpg'),
('PYE DE LIMON',3,3.50,100,'~/fotos/11.jpg'),
('TORTA DE NARANJA',3,5,10,'~/fotos/12.jpg'),
('TORTA DE FRESA',3,4,100,'~/fotos/13.jpg'),
('ALFAJORES',3,1,400,'~/fotos/14.jpg'),
('CHOCOTEJAS',3,1.50,100,'~/fotos/15.jpg'),
('SUSPIRO A LA LIMEÑA',3,8.50,100,'~/fotos/16.jpg'),
('PAPAYA',1,5,100,'~/fotos/17.jpg'),
('SURTIDO',1,7.50,100,'~/fotos/18.jpg'),
('PIÑA',1,3.50,100,'~/fotos/19.jpg'),
('PLATANO CON LECHE',1,9.50,40,'~/fotos/20.jpg'),
('CAFE PASADO',4,2.50,30,'~/fotos/21.jpg'),
('CAFE CON LECHE',4,5.50,30,'~/fotos/22.jpg'),
('GASEOSA',5,3,100,'~/fotos/23.jpg'),
('REHIDRATANTE',5,7,100,'~/fotos/24.jpg')
GO

INSERT INTO CLIENTE(NOM_CLI,MOV_CLI,IDE_DIS,COR_CLI) VALUES 
('JUAN GARCIA PEREZ','982360540','1','juan@peru.gob'),
('ROBERTO SALAS FUJIMORI','987456321','6','robertosalas@hotmail.com'),
('ALEJANDRO RAMIREZ MANRIQUE','914676732','4','alejandroramirez@gmail.com'),
('MELISSA BLANCO RUIZ','944867438','3','meli_87@hotmail.com'),
('ANA MENDOZA ALPEREZ','922548965','9','mendoza_ap@hotmail.com'),
('CRISTINA ESTARGIDIS CHUQUIN','984789658','3','celeste@gmail.com'),
('JOSE CUEVAS ALARCO','955698532','11','jose_el_santo@hotmail.com'),
('ANTUANE RODRIGUES ALARCON','934589732','15','i_live_ever@hotmail.com'),
('MADELINE SUAREZ ENRREDO','924576738','19','princesita@gmail.com'),
('LUIGUI MARQUEZ RONDO','984897421','14','piedrita@hotmail.com'),
('CARLOS COLAN BARDALES','933698574','19','bardales_56@hotmail.com'),
('MARTIN CARRILLO SALAS','988965952','18','carrillo@gmail.com'),
('PEDRO SAENZ KILLER','961258965','17','el_escamoso@hotmail.com'),
('KENJI ZANABRIA RODRIGUEZ','981547894','20','fujizan@hotmail.com'),
('LUIS RAMOS FLORES','924587964','13','luramos@gmail.com')
GO

INSERT INTO VENDEDOR(NOM_VEN,APE_VEN,DIR_VEN,TEL_VEN,IDE_DIS,COR_VEN,SUE_VEN) VALUES 
('JUAN JOSE','GARCIA PEREZ','Calle El Pino 346','984677352','1','jgarcia@peru.gob',1500),
('ROSA ANGELICA','GUERRERO SERNAQUE','Las Palmeras 4528','915263285','2','rguerrero@hotmail.com',1300),
('ROGER','ARRIETA SALAZAR','Carlos Izaguirre 685','925698522','14','rarrieta@gmail.com',1200),
('MARIA JULIA','ZORRILLA LOPEZ','Alisos 654','936247487','15','mzorrilla@hotmail.com',1300),
('JOSEFA ROSA','HURTADO JUAREZ','El Sol 6556','945852255','4','jhurtado@hotmail.com',1500),
('ROY MARK','KOLF JAFS','Los Olivos 686','956985216','1','rkolf@gmail.com',1300),
('JHON MICKY','FIGUEROA ROJAS','Sangarara 653','964546455','3','jfigueroa@hotmail.com',1500),
('ANA EMIKO','LUNA GUILLERMO','Santa Luisa 6586','975258585','1','aluna@hotmail.com',1300),
('MARIA LUISA','OROPEZA FUERTES','Amarontes 435','986955220','6','moropeza@gmail.com',1300),
('SUSAN','MOTOLA GUILLEN','Dora Mayer 683','996852202','10','smotola@gmail.com',1500)
GO
SELECT * FROM CLIENTE
INSERT INTO BOLETA(FEC_BOL,IDE_CLI,IDE_VEN) VALUES 
('2017/02/15','1014','9'),
('2017/02/25','1001','2'),
('2017/03/21','1006','1'),
('2017/05/26','1003','4'),
('2017/06/20','1002','5'),
('2017/08/22','1006','9'),
('2018/01/26','1005','2'),
('2018/02/20','1006','7'),
('2018/02/28','1013','1'),
('2018/01/16','1007','4'),
('2018/02/06','1008','9'),
('2018/02/15','1006','9'),
('2018/02/25','1001','2'),
('2018/03/21','1006','1'),
('2018/03/26','1003','4'),
('2018/04/20','1002','5'),
('2019/01/22','1006','9'),
('2019/01/26','1005','2'),
('2019/02/20','1006','7'),
('2019/03/28','1013','1'),
('2019/04/16','1007','4'),
('2019/04/06','1008','9'),
('2019/04/15','1006','9'),
('2019/05/25','1001','2'),
('2019/06/21','1006','1'),
('2019/06/26','1003','4'),
('2019/07/20','1002','5'),
('2019/08/22','1006','9'),
('2019/09/26','1005','2'),
('2019/10/20','1006','7'),
('2019/10/28','1013','1'),
('2019/11/16','1007','4'),
('2019/11/06','1008','9'),
('2019/12/15','1006','9'),
('2020/01/25','1001','2'),
('2020/01/21','1006','1'),
('2020/02/26','1003','4'),
('2020/02/20','1002','5'),
('2020/03/22','1006','9'),
('2020/03/26','1005','2'),
('2020/04/20','1006','7'),
('2020/05/28','1003','1'),
('2020/05/16','1007','4'),
('2020/06/06','1008','9'),
('2020/06/21','1001','4')
GO


INSERT INTO DETALLEBOLETA VALUES ('1','100',11)
INSERT INTO DETALLEBOLETA VALUES ('1','120',11)
INSERT INTO DETALLEBOLETA VALUES ('2','104',6)
INSERT INTO DETALLEBOLETA VALUES ('2','110',12)
INSERT INTO DETALLEBOLETA VALUES ('2','108',34)
INSERT INTO DETALLEBOLETA VALUES ('3','104',12)
INSERT INTO DETALLEBOLETA VALUES ('3','122',5)
INSERT INTO DETALLEBOLETA VALUES ('3','105',45)
INSERT INTO DETALLEBOLETA VALUES ('4','111',24)
INSERT INTO DETALLEBOLETA VALUES ('4','116',22)
INSERT INTO DETALLEBOLETA VALUES ('5','116',34)
INSERT INTO DETALLEBOLETA VALUES ('5','115',56)
INSERT INTO DETALLEBOLETA VALUES ('6','107',8)
INSERT INTO DETALLEBOLETA VALUES ('6','109',66)
INSERT INTO DETALLEBOLETA VALUES ('7','102',24)
INSERT INTO DETALLEBOLETA VALUES ('7','101',11)
INSERT INTO DETALLEBOLETA VALUES ('7','112',11)
INSERT INTO DETALLEBOLETA VALUES ('8','104',6)
INSERT INTO DETALLEBOLETA VALUES ('9','111',12)
INSERT INTO DETALLEBOLETA VALUES ('10','108',34)
INSERT INTO DETALLEBOLETA VALUES ('10','104',12)
INSERT INTO DETALLEBOLETA VALUES ('11','112',5)
INSERT INTO DETALLEBOLETA VALUES ('11','105',45)
INSERT INTO DETALLEBOLETA VALUES ('12','111',24)
INSERT INTO DETALLEBOLETA VALUES ('13','106',22)
INSERT INTO DETALLEBOLETA VALUES ('14','116',34)
INSERT INTO DETALLEBOLETA VALUES ('15','115',56)
INSERT INTO DETALLEBOLETA VALUES ('16','107',8)
INSERT INTO DETALLEBOLETA VALUES ('17','109',66)
INSERT INTO DETALLEBOLETA VALUES ('17','102',24)
INSERT INTO DETALLEBOLETA VALUES ('18','111',11)
INSERT INTO DETALLEBOLETA VALUES ('18','112',11)
INSERT INTO DETALLEBOLETA VALUES ('19','104',6)
INSERT INTO DETALLEBOLETA VALUES ('19','121',12)
INSERT INTO DETALLEBOLETA VALUES ('20','108',34)
INSERT INTO DETALLEBOLETA VALUES ('20','104',12)
INSERT INTO DETALLEBOLETA VALUES ('21','112',5)
INSERT INTO DETALLEBOLETA VALUES ('21','115',45)
INSERT INTO DETALLEBOLETA VALUES ('22','101',24)
INSERT INTO DETALLEBOLETA VALUES ('23','106',22)
INSERT INTO DETALLEBOLETA VALUES ('24','116',34)
INSERT INTO DETALLEBOLETA VALUES ('25','115',56)
INSERT INTO DETALLEBOLETA VALUES ('26','117',8)
INSERT INTO DETALLEBOLETA VALUES ('26','119',66)
INSERT INTO DETALLEBOLETA VALUES ('27','112',24)
INSERT INTO DETALLEBOLETA VALUES ('28','101',11)
INSERT INTO DETALLEBOLETA VALUES ('29','112',11)
INSERT INTO DETALLEBOLETA VALUES ('29','104',6)
INSERT INTO DETALLEBOLETA VALUES ('30','101',12)
INSERT INTO DETALLEBOLETA VALUES ('30','108',34)
INSERT INTO DETALLEBOLETA VALUES ('31','104',12)
INSERT INTO DETALLEBOLETA VALUES ('31','112',5)
INSERT INTO DETALLEBOLETA VALUES ('32','105',45)
INSERT INTO DETALLEBOLETA VALUES ('33','101',24)
INSERT INTO DETALLEBOLETA VALUES ('33','106',22)
INSERT INTO DETALLEBOLETA VALUES ('34','116',34)
INSERT INTO DETALLEBOLETA VALUES ('35','115',56)
GO

--Consultando las tablas creadas
SELECT * FROM CLIENTE
SELECT * FROM DISTRITO
SELECT * FROM PRODUCTO
SELECT * FROM CATEGORIA
SELECT * FROM DETALLEBOLETA
SELECT * FROM BOLETA
SELECT * FROM VENDEDOR

