-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: localhost    Database: tjt
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_id` int(11) NOT NULL COMMENT 'News article Id in the publisher system',
  `title` text NOT NULL,
  `url` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_id_UNIQUE` (`external_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2795 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (2794,1,'Primera Guerra Mundial','http://wordpress.tjt-wp-server/hello-world/');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articleversion`
--

DROP TABLE IF EXISTS `articleversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articleversion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_version_id` int(11) NOT NULL COMMENT 'Id of News article version in the publisher system',
  `title` text NOT NULL,
  `url` text,
  `content` text NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `external_version_id_UNIQUE` (`external_version_id`),
  KEY `fk_articleversion_parent_article_id` (`article_id`),
  CONSTRAINT `fk_articleversion_parent_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6689 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articleversion`
--

LOCK TABLES `articleversion` WRITE;
/*!40000 ALTER TABLE `articleversion` DISABLE KEYS */;
INSERT INTO `articleversion` VALUES (6682,1,'Primera Guerra Mundial','http://wordpress.tjt-wp-server/hello-world/','','2018-09-20 14:31:29',2794),(6683,10,'Articleversion #10','','','2018-09-20 14:34:31',2794),(6684,12,'Primera Guerra Mundial','http://wordpress.tjt-wp-server/hello-world/','','2018-09-21 07:10:19',2794),(6685,13,'Primera Guerra Mundial','http://wordpress.tjt-wp-server/hello-world/','','2018-09-21 07:31:03',2794),(6686,14,'Primera Guerra Mundial','http://wordpress.tjt-wp-server/hello-world/','','2018-09-21 09:19:41',2794),(6687,15,'Primera Guerra Mundial','http://wordpress.tjt-wp-server/hello-world/','','2018-09-21 09:29:05',2794),(6688,16,'Primera Guerra Mundial','http://wordpress.tjt-wp-server/hello-world/','','2018-09-21 09:36:06',2794);
/*!40000 ALTER TABLE `articleversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `externalId` varchar(255) DEFAULT NULL,
  `authorclassification_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_author_1_idx` (`authorclassification_id`),
  CONSTRAINT `fk_author_1` FOREIGN KEY (`authorclassification_id`) REFERENCES `classification` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (303,'Alice Smith',NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authoralias`
--

DROP TABLE IF EXISTS `authoralias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authoralias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `authoralias_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authoralias`
--

LOCK TABLES `authoralias` WRITE;
/*!40000 ALTER TABLE `authoralias` DISABLE KEYS */;
/*!40000 ALTER TABLE `authoralias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL COMMENT 'Used in order to show to end users',
  `valoration_id` int(11) NOT NULL,
  `isDefault` tinyint(1) DEFAULT '0',
  `order` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_classification_1_idx` (`valoration_id`),
  CONSTRAINT `fk_classification_1` FOREIGN KEY (`valoration_id`) REFERENCES `valoration` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classification`
--

LOCK TABLES `classification` WRITE;
/*!40000 ALTER TABLE `classification` DISABLE KEYS */;
INSERT INTO `classification` VALUES (1,'Colaborador','Periodista',1,0,0),(2,'Redactor','Periodista',2,1,0),(7,'Video','Vídeo',7,0,0),(8,'Image','Imagen',8,0,0),(9,'Localidad declarada','Se declara la ubicación donde se redacta la noticia',9,0,0),(10,'Identificador de transparencia encontrado	','Política editorial',10,0,0),(11,'Fecha actualización declarada','Fecha actualización',11,0,0),(12,'El editor declara porqué cubre esta noticia	','Motivo',12,0,0),(13,'Link','Enlace',13,0,0),(14,'Person','Persona',14,0,1),(15,'Organization','Institución u organización',15,0,0),(16,'Media','Otros medios',16,0,2),(17,'Anonymous','Fuentes anónimas o protegidas',17,0,3),(18,'Document','Documento (doc, pdf, xls,...)',18,0,0),(19,'Agencia','Agencia de noticias',19,0,0),(20,'Sin identificar','Autor sin especificar',20,0,0),(21,'Anónimo','Autor anónimo',21,0,0),(23,'Map','Mapas',23,0,0),(24,'Infographic','Infografía',24,0,0),(25,'SocialPost','Posts en redes sociales',25,0,0),(26,'Audio','Audio',26,0,0),(29,'Sin identificar','Fuentes sin identificar',30,0,0);
/*!40000 ALTER TABLE `classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `classification_valoration`
--

DROP TABLE IF EXISTS `classification_valoration`;
/*!50001 DROP VIEW IF EXISTS `classification_valoration`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `classification_valoration` AS SELECT 
 1 AS `indicator_id`,
 1 AS `indicator`,
 1 AS `classification_id`,
 1 AS `name`,
 1 AS `description`,
 1 AS `isDefault`,
 1 AS `order`,
 1 AS `valoration_id`,
 1 AS `transparency`,
 1 AS `economic`,
 1 AS `economic_metric`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `content_taxonomyterm`
--

DROP TABLE IF EXISTS `content_taxonomyterm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content_taxonomyterm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` enum('section','tag') NOT NULL DEFAULT 'section',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_taxonomyterm`
--

LOCK TABLES `content_taxonomyterm` WRITE;
/*!40000 ALTER TABLE `content_taxonomyterm` DISABLE KEYS */;
INSERT INTO `content_taxonomyterm` VALUES (131,'Historia','Historia','tag');
/*!40000 ALTER TABLE `content_taxonomyterm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `declaration2author`
--

DROP TABLE IF EXISTS `declaration2author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `declaration2author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `declaration_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_declaration2author_1_idx` (`author_id`),
  KEY `fk_declaration2author_2_idx` (`declaration_id`),
  CONSTRAINT `fk_declaration2author_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_declaration2author_2` FOREIGN KEY (`declaration_id`) REFERENCES `editordeclaration` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `declaration2author`
--

LOCK TABLES `declaration2author` WRITE;
/*!40000 ALTER TABLE `declaration2author` DISABLE KEYS */;
/*!40000 ALTER TABLE `declaration2author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `declaration2content_taxonomyterm`
--

DROP TABLE IF EXISTS `declaration2content_taxonomyterm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `declaration2content_taxonomyterm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `editordeclaration_id` int(11) NOT NULL,
  `content_taxonomyterm_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_declaration2content_taxonomyterm_1_idx` (`editordeclaration_id`),
  KEY `fk_declaration2content_taxonomyterm_2_idx` (`content_taxonomyterm_id`),
  CONSTRAINT `fk_declaration2content_taxonomyterm_1` FOREIGN KEY (`editordeclaration_id`) REFERENCES `editordeclaration` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_declaration2content_taxonomyterm_2` FOREIGN KEY (`content_taxonomyterm_id`) REFERENCES `content_taxonomyterm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `declaration2content_taxonomyterm`
--

LOCK TABLES `declaration2content_taxonomyterm` WRITE;
/*!40000 ALTER TABLE `declaration2content_taxonomyterm` DISABLE KEYS */;
INSERT INTO `declaration2content_taxonomyterm` VALUES (12,1,131);
/*!40000 ALTER TABLE `declaration2content_taxonomyterm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discard`
--

DROP TABLE IF EXISTS `discard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indicator_id` int(11) DEFAULT NULL,
  `external_id` int(11) NOT NULL,
  `externalVersion_id` int(11) NOT NULL,
  `data` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_444C34CA4402854A` (`indicator_id`),
  CONSTRAINT `FK_444C34CA4402854A` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2887 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discard`
--

LOCK TABLES `discard` WRITE;
/*!40000 ALTER TABLE `discard` DISABLE KEYS */;
INSERT INTO `discard` VALUES (2880,6,1,13,'Potencias'),(2881,6,1,13,'Imperio'),(2883,7,1,14,'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'),(2884,7,1,15,'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'),(2885,7,1,15,'http://wordpress.tjt-wp-serverdata:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'),(2886,7,1,16,'http://wordpress.tjt-wp-serverdata:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7');
/*!40000 ALTER TABLE `discard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editordeclaration`
--

DROP TABLE IF EXISTS `editordeclaration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `editordeclaration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isDefault` int(1) NOT NULL DEFAULT '0' COMMENT 'If 1, this is the default editor declaration',
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_editordeclaration_1_idx` (`parent_id`),
  CONSTRAINT `fk_editordeclaration_1` FOREIGN KEY (`parent_id`) REFERENCES `editordeclaration` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editordeclaration`
--

LOCK TABLES `editordeclaration` WRITE;
/*!40000 ALTER TABLE `editordeclaration` DISABLE KEYS */;
INSERT INTO `editordeclaration` VALUES (1,'Tema especial interés','Tema de especial interés para nuestro medio, WORDPRESS & TJ_TOOL TESTING WEBSITE',0,NULL,4),(2,'Actualidad','Actualidad informativa',1,NULL,2),(3,'Social','Tendencia en redes sociales',0,NULL,1),(5,'Branded','Contenido patrocinado',0,NULL,3);
/*!40000 ALTER TABLE `editordeclaration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation_result`
--

DROP TABLE IF EXISTS `evaluation_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  `ts` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `published` tinyint(1) DEFAULT NULL,
  `article_id` int(11) NOT NULL,
  `article_version_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_id_article_version_id` (`article_id`,`article_version_id`) COMMENT 'The table can only store an economic and transparency evaluation of a news article version at a time',
  KEY `fk_article_external_version_id` (`article_version_id`),
  CONSTRAINT `fk_article_external_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_article_external_version_id` FOREIGN KEY (`article_version_id`) REFERENCES `articleversion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6268 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation_result`
--

LOCK TABLES `evaluation_result` WRITE;
/*!40000 ALTER TABLE `evaluation_result` DISABLE KEYS */;
INSERT INTO `evaluation_result` VALUES (6264,'{\n    \"common\": {\n        \"journalist\": \"tjt (tjt)\",\n        \"articleId\": \"1\",\n        \"versionId\": \"13\",\n        \"publicUrl\": \"http:\\/\\/wordpress.tjt-wp-server\\/hello-world\\/\",\n        \"title\": \"Primera Guerra Mundial\",\n        \"isPublished\": \"true\"\n    },\n    \"transparentsite\": {\n        \"url\": \"http:\\/\\/wordpress.tjt-wp-server\\/transparency-policy\\/\",\n        \"title\": \"Transparency policy for WORDPRESS & TJ_TOOL TESTING WEBSITE\",\n        \"logo\": \"http:\\/\\/wordpress.tjt-wp-server\\/wp-content\\/uploads\\/2018\\/09\\/tjtlogo.png\"\n    },\n    \"why\": {\n        \"approach\": {\n            \"id\": \"1\"\n        }\n    },\n    \"location\": {\n        \"place\": \"Madrid (Spain)\",\n        \"expenses\": \"\"\n    },\n    \"datetime\": {\n        \"date\": \"2018-09-19 13:18:00\",\n        \"created\": \"\"\n    },\n    \"authors\": [\n        {\n            \"author\": \"Alice Smith\",\n            \"hours\": \"1\",\n            \"category\": {\n                \"id\": \"2\"\n            }\n        }\n    ],\n    \"sources\": [\n        {\n            \"source\": \"Triple Entente\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Reino\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Estados Unidos\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        }\n    ],\n    \"documents\": [\n        {\n            \"url\": \"https:\\/\\/twitter.com\\/publico_es\\/status\\/882965163367968769?ref_src=twsrc%5Etfw\",\n            \"title\": \"6 de julio de 2017\",\n            \"date\": \"06-07-2017\",\n            \"type\": {\n                \"id\": \"25\"\n            }\n        }\n    ],\n    \"references\": [\n        {\n            \"url\": \"https:\\/\\/es.wikipedia.org\\/wiki\\/Triple_Entente\",\n            \"title\": \"Triple Entente\",\n            \"date\": \"\",\n            \"type\": {\n                \"id\": \"13\"\n            }\n        }\n    ]\n}','2018-09-21 09:16:44',1,2794,6685),(6265,'{\n    \"common\": {\n        \"journalist\": \"tjt (tjt)\",\n        \"articleId\": \"1\",\n        \"versionId\": \"14\",\n        \"publicUrl\": \"http:\\/\\/wordpress.tjt-wp-server\\/hello-world\\/\",\n        \"title\": \"Primera Guerra Mundial\",\n        \"isPublished\": \"true\"\n    },\n    \"transparentsite\": {\n        \"url\": \"http:\\/\\/wordpress.tjt-wp-server\\/transparency-policy\\/\",\n        \"title\": \"Transparency policy for WORDPRESS & TJ_TOOL TESTING WEBSITE\",\n        \"logo\": \"http:\\/\\/wordpress.tjt-wp-server\\/wp-content\\/uploads\\/2018\\/09\\/tjtlogo.png\"\n    },\n    \"why\": {\n        \"approach\": {\n            \"id\": \"1\"\n        }\n    },\n    \"location\": {\n        \"place\": \"Madrid (Spain)\",\n        \"expenses\": \"\"\n    },\n    \"datetime\": {\n        \"date\": \"2018-09-19 13:18:00\",\n        \"created\": \"\"\n    },\n    \"authors\": [\n        {\n            \"author\": \"Alice Smith\",\n            \"hours\": \"1\",\n            \"category\": {\n                \"id\": \"2\"\n            }\n        }\n    ],\n    \"sources\": [\n        {\n            \"source\": \"Imperio\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Triple Entente\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Reino\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Potencias\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Estados Unidos\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        }\n    ],\n    \"documents\": [\n        {\n            \"url\": \"https:\\/\\/www.youtube.com\\/embed\\/xKLsJqtR_i4?feature=oembed\",\n            \"title\": \"JOHN COLTRANE - JAZZ CASUAL - YouTube\",\n            \"date\": \"\",\n            \"type\": {\n                \"id\": \"7\"\n            }\n        },\n        {\n            \"url\": \"https:\\/\\/twitter.com\\/publico_es\\/status\\/882965163367968769?ref_src=twsrc%5Etfw\",\n            \"title\": \"6 de julio de 2017\",\n            \"date\": \"06-07-2017\",\n            \"type\": {\n                \"id\": \"25\"\n            }\n        }\n    ],\n    \"references\": [\n        {\n            \"url\": \"https:\\/\\/es.wikipedia.org\\/wiki\\/Triple_Entente\",\n            \"title\": \"Triple Entente\",\n            \"date\": \"\",\n            \"type\": {\n                \"id\": \"13\"\n            }\n        }\n    ]\n}','2018-09-21 09:19:48',1,2794,6686),(6266,'{\n    \"common\": {\n        \"journalist\": \"tjt (tjt)\",\n        \"articleId\": \"1\",\n        \"versionId\": \"15\",\n        \"publicUrl\": \"http:\\/\\/wordpress.tjt-wp-server\\/hello-world\\/\",\n        \"title\": \"Primera Guerra Mundial\",\n        \"isPublished\": \"true\"\n    },\n    \"transparentsite\": {\n        \"url\": \"http:\\/\\/wordpress.tjt-wp-server\\/transparency-policy\\/\",\n        \"title\": \"Transparency policy for WORDPRESS & TJ_TOOL TESTING WEBSITE\",\n        \"logo\": \"http:\\/\\/wordpress.tjt-wp-server\\/wp-content\\/uploads\\/2018\\/09\\/tjtlogo.png\"\n    },\n    \"why\": {\n        \"approach\": {\n            \"id\": \"1\"\n        }\n    },\n    \"location\": {\n        \"place\": \"Madrid (Spain)\",\n        \"expenses\": \"\"\n    },\n    \"datetime\": {\n        \"date\": \"2018-09-19 13:18:00\",\n        \"created\": \"\"\n    },\n    \"authors\": [\n        {\n            \"author\": \"Alice Smith\",\n            \"hours\": \"1\",\n            \"category\": {\n                \"id\": \"2\"\n            }\n        }\n    ],\n    \"sources\": [\n        {\n            \"source\": \"Imperio\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Triple Entente\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Reino\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Potencias\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Estados Unidos\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        }\n    ],\n    \"documents\": [\n        {\n            \"url\": \"https:\\/\\/www.youtube.com\\/embed\\/xKLsJqtR_i4?feature=oembed\",\n            \"title\": \"JOHN COLTRANE - JAZZ CASUAL - YouTube\",\n            \"date\": \"\",\n            \"type\": {\n                \"id\": \"7\"\n            }\n        },\n        {\n            \"url\": \"http:\\/\\/wordpress.tjt-wp-server\\/wp-content\\/uploads\\/2018\\/09\\/998px-Map_Europe_alliances_1914-es.svg_.png\",\n            \"title\": \"998px-Map_Europe_alliances_1914-es.svg_.png\",\n            \"date\": \"\",\n            \"type\": {\n                \"id\": \"8\"\n            }\n        },\n        {\n            \"url\": \"https:\\/\\/twitter.com\\/publico_es\\/status\\/882965163367968769?ref_src=twsrc%5Etfw\",\n            \"title\": \"6 de julio de 2017\",\n            \"date\": \"06-07-2017\",\n            \"type\": {\n                \"id\": \"25\"\n            }\n        }\n    ],\n    \"references\": [\n        {\n            \"url\": \"https:\\/\\/es.wikipedia.org\\/wiki\\/Triple_Entente\",\n            \"title\": \"Triple Entente\",\n            \"date\": \"\",\n            \"type\": {\n                \"id\": \"13\"\n            }\n        }\n    ]\n}','2018-09-21 09:35:31',1,2794,6687),(6267,'{\n    \"common\": {\n        \"journalist\": \"tjt (tjt)\",\n        \"articleId\": \"1\",\n        \"versionId\": \"16\",\n        \"publicUrl\": \"http:\\/\\/wordpress.tjt-wp-server\\/hello-world\\/\",\n        \"title\": \"Primera Guerra Mundial\",\n        \"isPublished\": \"true\"\n    },\n    \"transparentsite\": {\n        \"url\": \"http:\\/\\/wordpress.tjt-wp-server\\/transparency-policy\\/\",\n        \"title\": \"Transparency policy for WORDPRESS & TJ_TOOL TESTING WEBSITE\",\n        \"logo\": \"http:\\/\\/wordpress.tjt-wp-server\\/wp-content\\/uploads\\/2018\\/09\\/tjtlogo.png\"\n    },\n    \"why\": {\n        \"approach\": {\n            \"id\": \"1\"\n        }\n    },\n    \"location\": {\n        \"place\": \"Madrid (Spain)\",\n        \"expenses\": \"\"\n    },\n    \"datetime\": {\n        \"date\": \"2018-09-19 13:18:00\",\n        \"created\": \"\"\n    },\n    \"authors\": [\n        {\n            \"author\": \"Alice Smith\",\n            \"hours\": \"1\",\n            \"category\": {\n                \"id\": \"2\"\n            }\n        }\n    ],\n    \"sources\": [\n        {\n            \"source\": \"Imperio\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Triple Entente\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Reino\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Potencias\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        },\n        {\n            \"source\": \"Estados Unidos\",\n            \"type\": {\n                \"id\": \"15\"\n            }\n        }\n    ],\n    \"documents\": [\n        {\n            \"url\": \"https:\\/\\/www.youtube.com\\/embed\\/xKLsJqtR_i4?feature=oembed\",\n            \"title\": \"JOHN COLTRANE - JAZZ CASUAL - YouTube\",\n            \"date\": \"ARCHIVO\",\n            \"type\": {\n                \"id\": \"7\"\n            }\n        },\n        {\n            \"url\": \"http:\\/\\/wordpress.tjt-wp-server\\/wp-content\\/uploads\\/2018\\/09\\/998px-Map_Europe_alliances_1914-es.svg_.png\",\n            \"title\": \"998px-Map_Europe_alliances_1914-es.svg_.png\",\n            \"date\": \"ARCHIVO\",\n            \"type\": {\n                \"id\": \"8\"\n            }\n        },\n        {\n            \"url\": \"https:\\/\\/twitter.com\\/publico_es\\/status\\/882965163367968769?ref_src=twsrc%5Etfw\",\n            \"title\": \"6 de julio de 2017\",\n            \"date\": \"06-07-2017\",\n            \"type\": {\n                \"id\": \"25\"\n            }\n        }\n    ],\n    \"references\": [\n        {\n            \"url\": \"https:\\/\\/es.wikipedia.org\\/wiki\\/Triple_Entente\",\n            \"title\": \"Triple Entente\",\n            \"date\": \"\",\n            \"type\": {\n                \"id\": \"13\"\n            }\n        }\n    ]\n}','2018-09-21 09:39:56',1,2794,6688);
/*!40000 ALTER TABLE `evaluation_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fos_user`
--

DROP TABLE IF EXISTS `fos_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fos_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(180) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(180) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(180) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(180) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `confirmation_token` varchar(180) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_957A647992FC23A8` (`username_canonical`),
  UNIQUE KEY `UNIQ_957A6479A0D96FBF` (`email_canonical`),
  UNIQUE KEY `UNIQ_957A6479C05FB297` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fos_user`
--

LOCK TABLES `fos_user` WRITE;
/*!40000 ALTER TABLE `fos_user` DISABLE KEYS */;
INSERT INTO `fos_user` VALUES (2,'admin','admin','webmaster@publico.es','webmaster@publico.es',1,NULL,'$2y$13$6br19Q4WJdE.8jv9AUa83OdDVqamneI1.fEIrcLmWhjJc3gdIthR.','2018-09-20 09:35:20',NULL,NULL,'a:2:{i:0;s:10:\"ROLE_ADMIN\";i:1;s:16:\"ROLE_SUPER_ADMIN\";}'),(5,'journalist','journalist','journalist@fake.com','journalist@fake.com',1,NULL,'$2y$13$t2eZK0zsJrexv7YESpjoSeROwwCyvWGOUG1xRPhqTsRv.I0phTomy','2018-01-27 10:56:06',NULL,NULL,'a:1:{i:0;s:15:\"ROLE_JOURNALIST\";}'),(11,'admin1','admin1','admin1','admin1',1,NULL,'$2y$13$WfzfopXY8aqEKKft.S7mZ.EYEmruxGB48r1w2WkgziSDmGzdKleMa',NULL,NULL,NULL,'a:1:{i:0;s:10:\"ROLE_ADMIN\";}'),(12,'admin2','admin2','admin2','admin2',1,NULL,'$2y$13$i.6eyjyaIZDdI3aXpPbbZ.vVgTuXyzWCxZYhOk.8sAiiBpDFJ1vDW',NULL,NULL,NULL,'a:1:{i:0;s:17:\"ROLE_AUTHOR_ADMIN\";}');
/*!40000 ALTER TABLE `fos_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indicator`
--

DROP TABLE IF EXISTS `indicator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indicator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL COMMENT 'Internal name, without spaces, ex: TransparentSite, Author\n',
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indicator`
--

LOCK TABLES `indicator` WRITE;
/*!40000 ALTER TABLE `indicator` DISABLE KEYS */;
INSERT INTO `indicator` VALUES (1,'TransparentSite','The publisher declares in its templates their'),(2,'Why','The publisher declares why they are covering '),(3,'Location','The publisher declares where the news article'),(4,'Datetime','The publisher declares the last updated date '),(5,'Author','The publisher declares the author and his/her'),(6,'Source','The publisher declares which sources have bee'),(7,'Document','The publisher declares which documents have b'),(8,'Reference','The publisher declares links to other article');
/*!40000 ALTER TABLE `indicator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `classification_id` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_unique` (`name`,`active`),
  KEY `fk_source_1_idx` (`classification_id`),
  CONSTRAINT `fk_source_1` FOREIGN KEY (`classification_id`) REFERENCES `classification` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This entity models sources (persons, corporations, other media)... someone who provides us information for our news articles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source_detection_taxonomyterm`
--

DROP TABLE IF EXISTS `source_detection_taxonomyterm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source_detection_taxonomyterm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term` varchar(45) NOT NULL,
  `type` enum('delimiter','literal','regexp') DEFAULT 'literal',
  `scope` enum('enclosed','parent') DEFAULT 'parent',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source_detection_taxonomyterm`
--

LOCK TABLES `source_detection_taxonomyterm` WRITE;
/*!40000 ALTER TABLE `source_detection_taxonomyterm` DISABLE KEYS */;
INSERT INTO `source_detection_taxonomyterm` VALUES (1,'/\\safirm[a|e|ó]\\s/','regexp','parent'),(3,'añade','literal','parent'),(4,'añadió','literal','parent'),(5,'dijo','literal','parent'),(6,'dijeron','literal','parent'),(7,'documento','literal','parent'),(8,'explica','literal','parent'),(9,'explicaba','literal','parent'),(10,'explicó','literal','parent'),(11,'grabación','literal','parent'),(12,'informe','literal','parent'),(13,'menciona','literal','parent'),(14,'mencionó','literal','parent'),(15,'según','literal','parent'),(16,'según fuentes','literal','parent'),(17,'sentencia','literal','parent'),(18,'/\\sargument[a|an|ó|aron]\\s/','regexp','parent'),(19,'/\\sasegur[a|ó]\\s/','regexp','parent'),(20,'/\\scit[a|ó]\\s/','regexp','parent'),(21,'/\\sdeclar[a|an|ó|aron]\\s/','regexp','parent'),(22,'/\\sdenunci[a|an|ó|aron]\\s/','regexp','parent'),(23,'/\\sdic[e|en]\\s/','regexp','parent'),(24,'/\\srevel[a|ó]\\s/','regexp','parent'),(25,'/\\sseñal[a|ó]\\s/','regexp','parent'),(26,'\" , \"','delimiter','enclosed'),(27,'\',\'','delimiter','enclosed'),(28,'“,”','delimiter','enclosed'),(29,'‘,’','delimiter','enclosed'),(30,'según añade','literal','parent'),(31,'avisó de que','literal','parent'),(32,'fuentes del','literal','parent'),(33,'según ha dicho','literal','parent'),(34,'ha mencionado','literal','parent'),(35,'reconoce','literal','parent'),(36,'considera','literal','parent'),(37,'el escrito del','literal','parent'),(38,'ha anunciado','literal','parent'),(39,'informado a','literal','parent'),(40,'/\\sfuentes [polic|judic]iales\\s/','regexp','parent');
/*!40000 ALTER TABLE `source_detection_taxonomyterm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valoration`
--

DROP TABLE IF EXISTS `valoration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valoration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transparency` int(11) NOT NULL DEFAULT '0',
  `economic` int(11) DEFAULT NULL,
  `economic_metric` enum('hour','item','data') COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Used in order to calculate economic costs',
  `indicator_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_valoration_1_idx` (`indicator_id`),
  CONSTRAINT `fk_valoration_1` FOREIGN KEY (`indicator_id`) REFERENCES `indicator` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valoration`
--

LOCK TABLES `valoration` WRITE;
/*!40000 ALTER TABLE `valoration` DISABLE KEYS */;
INSERT INTO `valoration` VALUES (1,15,60,'item',5),(2,15,50,'hour',5),(7,5,NULL,NULL,7),(8,2,NULL,NULL,7),(9,5,0,'data',3),(10,15,NULL,NULL,1),(11,2,NULL,NULL,4),(12,15,NULL,NULL,2),(13,3,NULL,NULL,8),(14,9,NULL,NULL,6),(15,9,NULL,NULL,6),(16,7,NULL,NULL,6),(17,0,NULL,NULL,6),(18,3,NULL,NULL,7),(19,8,20,'item',5),(20,3,0,'item',5),(21,0,0,'item',5),(23,2,NULL,NULL,7),(24,2,NULL,NULL,7),(25,2,NULL,NULL,7),(26,3,NULL,NULL,7),(30,3,NULL,NULL,6);
/*!40000 ALTER TABLE `valoration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `classification_valoration`
--

/*!50001 DROP VIEW IF EXISTS `classification_valoration`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`tjt`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `classification_valoration` AS select `i`.`id` AS `indicator_id`,`i`.`name` AS `indicator`,`c`.`id` AS `classification_id`,`c`.`name` AS `name`,`c`.`description` AS `description`,`c`.`isDefault` AS `isDefault`,`c`.`order` AS `order`,`v`.`id` AS `valoration_id`,`v`.`transparency` AS `transparency`,`v`.`economic` AS `economic`,`v`.`economic_metric` AS `economic_metric` from ((`classification` `c` join `valoration` `v`) join `indicator` `i`) where ((`c`.`valoration_id` = `v`.`id`) and (`v`.`indicator_id` = `i`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-24  4:15:43
