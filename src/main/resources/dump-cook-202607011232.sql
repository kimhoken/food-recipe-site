-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: cook
-- ------------------------------------------------------
-- Server version	9.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '7770c118-4f45-11f1-8966-00a554d55a0b:1-7749';

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `board_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `view_count` int DEFAULT '0',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'ACTIVE',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL,
  `recipe_id` bigint NOT NULL,
  `img_id` int DEFAULT NULL,
  `board_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`board_id`),
  KEY `fk_board_member` (`member_id`),
  KEY `fk_board_recipe` (`recipe_id`),
  KEY `fk_board_img` (`img_id`),
  CONSTRAINT `fk_board_img` FOREIGN KEY (`img_id`) REFERENCES `img` (`img_id`),
  CONSTRAINT `fk_board_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_board_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'오늘 저녁으로 김치찌개 끓였는데 대성공입니다!','레시피 탭에 있는 대로 쌀뜨물 넣고 푹 끓였더니 깊은 맛이 예술이네요. 다들 꼭 해보세요!',36,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(2,1,'김치찌개 레시피 보고 따라 했는데 대성공이에요!','맨날 맛내기 실패했었는데 쌀뜨물 넣고 오래 끓이니까 진짜 깊은 맛 나네요 ㅠㅠ 감동입니다.',47,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(3,1,'오늘 저녁은 냉장고 털어서 만든 김치찌개랑 계란말이','재료 다 털어 넣고 한 냄비 끓였는데 밥 두 공기 순삭했습니다. 역시 이 레시피가 최고네요.',13,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(4,1,'초보 요리사분들 이 김치찌개는 꼭 필독하셔야 합니다','제가 요리 똥손인데도 맛이 납니다. 양념장 비율이 황금 비율이에요. 다들 두 번 해 드세요.',90,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(5,1,'남편이 먹어보고 파는 것보다 맛있대요 ㅋㅋ','칭찬 인색한 사람인데 국물 한 입 먹자마자 크어 소리 내면서 흡입하네요. 뿌듯합니다.',57,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(6,1,'자취생들에게 빛과 소금 같은 찌개 레시피 공유','재료 간단하고 20분이면 완성이라 퇴근하고 맨날 이것만 해 먹는 중입니다. 진짜 최고!',26,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(7,1,'집들이 음식으로 냈는데 인기 폭발이었습니다','거창한 요리보다 역시 한국인은 김치찌개인가 봐요. 다들 국물 비법이 뭐냐고 물어보네요.',106,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(8,1,'스팸이랑 두부 더 넣어서 끓여봤는데 더 맛있네요','기본 돼지고기 베이스에 스팸까지 으깨 넣으니까 부대찌개 느낌도 나고 국물이 걸쭉해요.',31,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(9,1,'이거 끓일 때 참기름에 고기 먼저 볶는 게 팁인가요?','레시피대로 고기 달달 볶다가 김치 넣으니까 잡내 하나도 안 나고 고소함이 장난 아닙니다.',68,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(10,1,'신김치가 신의 한 수네요. 진짜 맛있습니다.','마침 냉장고에 엄청 신 김치 있어서 처치 곤란이었는데 찌개로 끓이니까 완벽하게 해결됐어요.',21,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY'),(11,1,'국물 요리 유목민이었는데 드디어 정착합니다','인터넷에 도는 레시피 다 따라 해봐도 밍밍했는데 이건 간이 딱 맞아요. 인생 레시피 등극!',151,'ACTIVE','2026-05-29 10:12:59',NULL,1,1,'COMMUNITY');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmark`
--

DROP TABLE IF EXISTS `bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookmark` (
  `bookmark_id` bigint NOT NULL AUTO_INCREMENT,
  `recipe_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bookmark_id`),
  KEY `fk_bookmark_recipe` (`recipe_id`),
  KEY `fk_bookmark_member` (`member_id`),
  CONSTRAINT `fk_bookmark_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_bookmark_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmark`
--

LOCK TABLES `bookmark` WRITE;
/*!40000 ALTER TABLE `bookmark` DISABLE KEYS */;
INSERT INTO `bookmark` VALUES (1,1,1,'2026-05-29 10:12:59');
/*!40000 ALTER TABLE `bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `sub_category_name` varchar(50) NOT NULL,
  `sort_order` int DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'상황별추천','혼밥',1),(2,'상황별추천','홈파티',2),(3,'상황별추천','술안주',3),(4,'상황별추천','캠핑요리',4),(5,'상황별추천','아이간식',5),(6,'상황별추천','SNS 화제 음식',6),(7,'상황별추천','해장요리',7),(8,'상황별추천','비 오는 날 추천',8),(9,'상황별추천','홈 다이닝',9),(10,'한식','국/찌개',10),(11,'한식','볶음/조림',11),(12,'한식','밑반찬',12),(13,'한식','김치',13),(14,'한식','덮밥/비빔밥',14),(15,'한식','면요리',15),(16,'한식','전/튀김',16),(17,'한식','고기요리/구이',17),(18,'한식','해산물요리',18),(19,'한식','명절요리',19),(20,'양식','파스타',20),(21,'양식','피자',21),(22,'양식','스테이크/바비큐',22),(23,'양식','리조또/필라프',23),(24,'양식','샌드위치/버거',24),(25,'양식','커틀릿/튀김',25),(26,'양식','스프/스튜',26),(27,'양식','그라탕/오븐요리',27),(28,'양식','오일/팬요리',28),(29,'양식','브런치',29),(30,'중식','중식면',30),(31,'중식','중식밥',31),(32,'중식','고기튀김',32),(33,'중식','해물튀김',33),(34,'중식','볶음요리',34),(35,'중식','탕/스프',35),(36,'중식','만두/딤섬',36),(37,'중식','냉채',37),(38,'중식','두부/채소',38),(39,'중식','마라/퓨전',39),(40,'일식','초밥/롤',40),(41,'일식','돈부리/덮밥',41),(42,'일식','우동/소바',42),(43,'일식','라멘',43),(44,'일식','카레',44),(45,'일식','돈카츠/튀김',45),(46,'일식','구이요리',46),(47,'일식','나베/전골',47),(48,'일식','철판요리',48),(49,'일식','일식가정식',49),(50,'아시안','쌀국수',50),(51,'아시안','아시안밥',51),(52,'아시안','커리',52),(53,'아시안','스프/탕',53),(54,'아시안','고기요리',54),(55,'아시안','해물요리',55),(56,'아시안','볶음요리',56),(57,'아시안','사이드/튀김',57),(58,'아시안','아시안쌈',58),(59,'아시안','모닝글로리',59),(60,'건강식/다이어트','샐러드',60),(61,'건강식/다이어트','포케/웜볼',61),(62,'건강식/다이어트','닭가슴살',62),(63,'건강식/다이어트','두부/묵',63),(64,'건강식/다이어트','계란요리',64),(65,'건강식/다이어트','식단밥/죽',65),(66,'건강식/다이어트','샌드위치/랩',66),(67,'건강식/다이어트','야채/찜요리',67),(68,'건강식/다이어트','생선/해산물',68),(69,'건강식/다이어트','주스/스무디',69),(70,'초간단요리','원팬/원팟',70),(71,'초간단요리','전자레인지',71),(72,'초간단요리','에어프라이어',72),(73,'초간단요리','5분토스트',73),(74,'초간단요리','한그릇밥',74),(75,'초간단요리','간단면식',75),(76,'초간단요리','비빔/무침',76),(77,'초간단요리','밀키트/시판',77),(78,'초간단요리','노오븐디저트',78),(79,'초간단요리','남은재료처리',79),(80,'디저트','젤리/푸딩',80),(81,'디저트','샤베트/빙수',81),(82,'디저트','과일간식',82),(83,'디저트','떡/한과',83),(84,'디저트','초콜릿/사탕',84),(85,'디저트','노오븐디저트',85),(86,'디저트','요거트',86),(87,'디저트','샌드/영양바',87),(88,'디저트','튀김간식',88),(89,'디저트','구황작물',89),(90,'베이킹','식빵/모닝빵',90),(91,'베이킹','쿠키',91),(92,'베이킹','케이크',92),(93,'베이킹','타르트/파이',93),(94,'베이킹','머핀/컵케이크',94),(95,'베이킹','구움과자',95),(96,'베이킹','와플/팬케이크',96),(97,'베이킹','비건베이킹',97),(98,'베이킹','패스트리',98),(99,'베이킹','핑거푸드',99),(100,'음료/차','커피',100),(101,'음료/차','에이드',101),(102,'음료/차','과일주스',102),(103,'음료/차','전통차',103),(104,'음료/차','허브티/홍차',104),(105,'음료/차','라떼/밀크',105),(106,'음료/차','무알코올',106),(107,'음료/차','홈술/칵테일',107),(108,'음료/차','해독/건강차',108),(109,'음료/차','수제청',109);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot`
--

DROP TABLE IF EXISTS `chatbot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `question` varchar(255) NOT NULL,
  `answer` text,
  `depth` int NOT NULL,
  `sort_order` int DEFAULT '0',
  `use_yn` char(1) DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `fk_chatbot_parent` (`parent_id`),
  CONSTRAINT `fk_chatbot_parent` FOREIGN KEY (`parent_id`) REFERENCES `chatbot` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot`
--

LOCK TABLES `chatbot` WRITE;
/*!40000 ALTER TABLE `chatbot` DISABLE KEYS */;
INSERT INTO `chatbot` VALUES (1,NULL,'로그인 및 회원관리',NULL,1,1,'Y'),(2,NULL,'레시피 / 나만의 냉장고',NULL,1,2,'Y'),(3,NULL,'커뮤니티',NULL,1,3,'Y'),(4,NULL,'자주 묻는 질문',NULL,1,4,'Y'),(5,NULL,'문의하기',NULL,1,5,'Y'),(6,1,'로그인이 안 돼요','아이디와 비밀번호를 다시 확인해주세요. 계속 문제가 발생하면 비밀번호 찾기를 이용해주세요.',2,1,'Y'),(7,1,'비밀번호를 잊어버렸어요','로그인 페이지의 비밀번호 찾기 메뉴에서 이메일 인증 후 새 비밀번호를 설정할 수 있습니다.',2,2,'Y'),(8,1,'회원가입은 어떻게 하나요?','회원가입 페이지에서 아이디, 이메일, 비밀번호 입력 후 가입을 진행할 수 있습니다.',2,3,'Y'),(9,1,'회원정보를 수정하고 싶어요','마이페이지에서 닉네임, 비밀번호, 프로필 이미지 등의 정보를 수정할 수 있습니다.',2,4,'Y'),(10,2,'레시피는 어떻게 등록하나요?','로그인 후 레시피 등록 페이지에서 제목, 재료, 조리순서와 이미지를 입력해 등록할 수 있습니다.',2,1,'Y'),(11,2,'레시피 검색은 어떻게 하나요?','상단 검색창에서 음식명, 재료명 또는 카테고리를 입력해 검색할 수 있습니다.',2,2,'Y'),(12,2,'냉장고 재료로 레시피 추천을 받을 수 있나요?','등록된 재료를 기반으로 만들 수 있는 레시피를 추천받을 수 있습니다.',2,3,'Y'),(13,3,'게시글은 어떻게 작성하나요?','게시판 페이지에서 글쓰기 버튼을 눌러 게시글을 작성할 수 있습니다.',2,1,'Y'),(14,3,'댓글은 어떻게 작성하나요?','게시글 상세 페이지 하단 댓글 입력창에서 댓글을 작성할 수 있습니다.',2,2,'Y'),(15,3,'게시글 신고는 어떻게 하나요?','게시글 또는 댓글의 신고 버튼을 눌러 신고할 수 있습니다.',2,3,'Y'),(16,3,'내가 작성한 글은 어디서 보나요?','마이페이지 메뉴에서 확인할 수 있습니다.',2,4,'Y'),(17,4,'이메일 인증이 오지 않아요','이메일 주소를 다시 확인해주세요. 스팸 메일함도 함께 확인해주시기 바랍니다.',2,1,'Y'),(18,4,'관리자 문의 답변은 얼마나 걸리나요?','문의 접수 후 평균 1~3일 이내에 답변을 받을 수 있습니다.',2,2,'Y'),(19,4,'탈퇴 후 재가입이 가능한가요?','회원탈퇴 후 동일한 이메일로 다시 가입할 수 있습니다.',2,3,'Y'),(20,4,'신고당한 게시물은 어떻게 되나요?','신고된 게시물은 관리자 검토 후 숨김 또는 삭제 처리될 수 있습니다.',2,4,'Y'),(21,4,'서비스 점검은 언제 진행되나요?','서비스 점검 일정은 공지사항을 통해 사전 안내됩니다.',2,5,'Y'),(22,5,'관리자에게 문의하기',NULL,2,1,'Y');
/*!40000 ALTER TABLE `chatbot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT,
  `recipe_id` bigint DEFAULT NULL,
  `member_id` bigint NOT NULL,
  `content` text NOT NULL,
  `rating` float DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'ACTIVE',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `board_id` bigint DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `fk_comment_recipe` (`recipe_id`),
  KEY `fk_comment_member` (`member_id`),
  KEY `comment_board_FK` (`board_id`),
  CONSTRAINT `comment_board_FK` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_comment_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,'진짜 너무 맛있게 잘 먹었습니다! 요리 초보인데도 쉽게 따라했네요.',5,'ACTIVE','2026-05-29 10:12:59',NULL),(17,NULL,2,'정말 유용한 정보였습니다!',4,'HIDDEN','2026-06-25 10:34:06',1),(18,NULL,3,'덕분에 쉽게 따라 했어요.',2,'ACTIVE','2026-06-25 10:34:06',2),(19,NULL,1,'다음에도 좋은 글 부탁드립니다.',1,'ACTIVE','2026-06-25 10:34:06',3),(20,NULL,2,'사진도 보기 좋네요.',2,'ACTIVE','2026-06-25 10:34:06',4),(21,NULL,3,'좋은 팁 감사합니다.',3,'ACTIVE','2026-06-25 10:34:06',5),(22,1,2,'국물이 정말 맛있게 나왔어요.',5,'ACTIVE','2026-06-25 10:34:06',NULL),(23,2,3,'조금 매웠지만 맛있었습니다.',4,'ACTIVE','2026-06-25 10:34:06',NULL),(24,3,1,'가족들이 정말 좋아했어요.',5,'ACTIVE','2026-06-25 10:34:06',NULL),(25,4,1,'간단해서 자주 해먹을 것 같아요.',5,'ACTIVE','2026-06-25 10:34:06',NULL),(26,5,2,'구수하고 최고였습니다.',4,'ACTIVE','2026-06-25 10:34:06',NULL),(27,6,1,'매운맛 조절이 쉬워 좋네요.',5,'ACTIVE','2026-06-25 10:34:06',NULL),(28,7,2,'아이들이 정말 잘 먹었습니다.',5,'ACTIVE','2026-06-25 10:34:06',NULL),(29,8,3,'여름에 딱 어울리는 레시피입니다.',4,'ACTIVE','2026-06-25 10:34:06',NULL),(30,9,1,'양념이 정말 맛있어요.',5,'ACTIVE','2026-06-25 10:34:06',NULL),(31,10,2,'혼밥 메뉴로 최고입니다.',5,'ACTIVE','2026-06-25 10:34:06',NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content_view`
--

DROP TABLE IF EXISTS `content_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_view` (
  `content_type` varchar(20) NOT NULL,
  `content_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `viewed_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`content_type`,`content_id`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content_view`
--

LOCK TABLES `content_view` WRITE;
/*!40000 ALTER TABLE `content_view` DISABLE KEYS */;
INSERT INTO `content_view` VALUES ('NOTICE',1,2,'2026-06-30 09:17:32'),('NOTICE',2,2,'2026-06-30 09:17:50'),('NOTICE',3,2,'2026-06-30 09:19:07');
/*!40000 ALTER TABLE `content_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cook_order`
--

DROP TABLE IF EXISTS `cook_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cook_order` (
  `cook_order_id` bigint NOT NULL AUTO_INCREMENT,
  `cook_order` bigint DEFAULT NULL,
  `cook_image` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `recipe_id` bigint NOT NULL,
  PRIMARY KEY (`cook_order_id`),
  KEY `recipe_id` (`recipe_id`),
  CONSTRAINT `cook_order_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cook_order`
--

LOCK TABLES `cook_order` WRITE;
/*!40000 ALTER TABLE `cook_order` DISABLE KEYS */;
INSERT INTO `cook_order` VALUES (1,1,'step1.jpg','냄비에 고기를 먼저 볶아주세요.',1),(2,2,'step2.jpg','고기가 익으면 썰어둔 김치를 넣고 달달 볶습니다.',1),(3,3,'step3.jpg','물을 붓고 두부를 넣은 뒤 10분간 끓여 완성합니다.',1),(4,1,'step4.jpg','고기에 간장 양념을 넣고 20분간 재워둡니다.',2),(5,2,'step5.jpg','달군 팬에 고기와 양파를 넣고 강불에 빠르게 볶아냅니다.',2),(6,1,'step_spam_1.jpg','스팸을 먹기 좋은 크기로 작게 깍둑썰기 해줘.',3),(7,2,'step_spam_2.jpg','달군 팬에 스팸을 넣고 겉이 바삭해질 때까지 노릇하게 볶아내.',3),(8,3,'step_spam_3.jpg','계란 2개를 풀어 부드러운 스크램블 에그를 만들어.',3),(9,4,'step_spam_4.jpg','그릇에 밥을 담고 가장자리에 계란, 가운데에 스팸을 올린 뒤 마요네즈와 김가루를 뿌려 완성!',3),(10,1,'step_egg_1.jpg','팬에 기름을 두르고 계란 프라이를 반숙으로 구워.',4),(11,2,'step_egg_2.jpg','따뜻한 밥 위에 구워진 반숙 프라이를 얹어줘.',4),(12,3,'step_egg_3.jpg','간장 1스푼, 참기름 1스푼을 두르고 통깨를 뿌려 쓱쓱 비벼 먹으면 돼.',4),(13,1,'step_salmon_1.jpg','양상추는 한 입 크기로 뜯어 찬물에 헹군 뒤 물기를 탈탈 털어줘.',5),(14,2,'step_salmon_2.jpg','양파는 얇게 채 썰어서 매운맛을 빼기 위해 물에 10분 정도 담가둬.',5),(15,3,'step_salmon_3.jpg','연어는 도톰하게 썰고, 방울토마토는 반으로 잘라 준비해.',5),(16,4,'step_salmon_4.jpg','접시에 채소를 깔고 연어와 토마토를 예쁘게 올린 뒤 발사믹 드레싱을 뿌려.',5),(17,1,'step_chop_1.jpg','소고기는 한 입 크기로 깍둑썰기하고 소금, 후추로 밑간을 해둬.',6),(18,2,'step_chop_2.jpg','양파, 파프리카, 양송이버섯도 고기와 비슷한 크기로 썰어 준비해.',6),(19,3,'step_chop_3.jpg','달군 팬에 버터를 녹이고 강불에서 소고기를 빠르게 겉면만 익혀.',6),(20,4,'step_chop_4.jpg','썰어둔 채소를 넣고 1분간 더 볶다가 스테이크 소스를 넣고 윤기 나게 졸여내.',6),(21,1,'step_gambas_1.jpg','냉동 새우는 물에 담가 해동한 뒤, 키친타월로 물기를 완벽하게 닦아줘.',7),(22,2,'step_gambas_2.jpg','마늘은 두툼하게 편으로 썰어 준비해.',7),(23,3,'step_gambas_3.jpg','작은 팬에 올리브유를 듬뿍 붓고 마늘을 넣어 중약불에서 은근히 튀기듯 끓여.',7),(24,4,'step_gambas_4.jpg','마늘이 노릇해지면 페페론치노와 새우를 넣고 소금으로 간을 해.',7),(25,5,'step_gambas_5.jpg','새우가 붉게 익으면 불에서 내리고 구운 바게트와 함께 곁들여 먹어.',7);
/*!40000 ALTER TABLE `cook_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food`
--

DROP TABLE IF EXISTS `food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food` (
  `food_id` bigint NOT NULL AUTO_INCREMENT,
  `food_name` varchar(255) NOT NULL,
  `category_id` int NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL COMMENT '대표 이미지',
  PRIMARY KEY (`food_id`),
  KEY `fk_food_category` (`category_id`),
  CONSTRAINT `fk_food_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food`
--

LOCK TABLES `food` WRITE;
/*!40000 ALTER TABLE `food` DISABLE KEYS */;
INSERT INTO `food` VALUES (1,'달래된장비빔밥',1,'no_image'),(2,'김치볶음밥',1,'no_image'),(3,'스팸마요덮밥',1,'no_image'),(4,'간장계란밥',1,'no_image'),(5,'연어샐러드',2,'no_image'),(6,'찹스테이크',2,'no_image'),(7,'감바스',2,'no_image'),(8,'밀푀유나베',2,'no_image'),(9,'두부김치',3,'no_image'),(10,'바지락술찜',3,'no_image'),(11,'오뎅탕',3,'no_image'),(12,'콘치즈',3,'no_image'),(13,'매콤한 캠핑요리',4,'no_image'),(14,'특제 캠핑요리',4,'no_image'),(15,'초간단 캠핑요리',4,'no_image'),(16,'맛있는 캠핑요리',4,'no_image'),(17,'매콤한 아이간식',5,'no_image'),(18,'특제 아이간식',5,'no_image'),(19,'초간단 아이간식',5,'no_image'),(20,'맛있는 아이간식',5,'no_image'),(21,'매콤한 SNS 화제 음식',6,'no_image'),(22,'특제 SNS 화제 음식',6,'no_image'),(23,'초간단 SNS 화제 음식',6,'no_image'),(24,'맛있는 SNS 화제 음식',6,'no_image'),(25,'매콤한 해장요리',7,'no_image'),(26,'특제 해장요리',7,'no_image'),(27,'초간단 해장요리',7,'no_image'),(28,'맛있는 해장요리',7,'no_image'),(29,'매콤한 비 오는 날 추천',8,'no_image'),(30,'특제 비 오는 날 추천',8,'no_image'),(31,'초간단 비 오는 날 추천',8,'no_image'),(32,'맛있는 비 오는 날 추천',8,'no_image'),(33,'매콤한 홈 다이닝',9,'no_image'),(34,'특제 홈 다이닝',9,'no_image'),(35,'초간단 홈 다이닝',9,'no_image'),(36,'맛있는 홈 다이닝',9,'no_image'),(37,'무들깨탕',10,'no_image'),(38,'매생이굴국',10,'no_image'),(39,'오이냉국',10,'no_image'),(40,'냉이두부된장국',10,'no_image'),(41,'두부조림',11,'no_image'),(42,'감자조림',11,'no_image'),(43,'오징어볶음',11,'no_image'),(44,'제육볶음',11,'no_image'),(45,'과메기무침',12,'no_image'),(46,'특제 밑반찬',12,'no_image'),(47,'초간단 밑반찬',12,'no_image'),(48,'맛있는 밑반찬',12,'no_image'),(49,'열무김치',13,'no_image'),(50,'특제 김치',13,'no_image'),(51,'초간단 김치',13,'no_image'),(52,'맛있는 김치',13,'no_image'),(53,'불고기덮밥',14,'no_image'),(54,'낙지덮밥',14,'no_image'),(55,'육회비빔밥',14,'no_image'),(56,'비빔밥',14,'no_image'),(57,'매콤한 면요리',15,'no_image'),(58,'특제 면요리',15,'no_image'),(59,'초간단 면요리',15,'no_image'),(60,'맛있는 면요리',15,'no_image'),(61,'매콤한 전/튀김',16,'no_image'),(62,'특제 전/튀김',16,'no_image'),(63,'초간단 전/튀김',16,'no_image'),(64,'맛있는 전/튀김',16,'no_image'),(65,'떡갈비',17,'no_image'),(66,'소불고기',17,'no_image'),(67,'배숙성불고기',17,'no_image'),(68,'전어구이',17,'no_image'),(69,'매콤한 해산물요리',18,'no_image'),(70,'특제 해산물요리',18,'no_image'),(71,'초간단 해산물요리',18,'no_image'),(72,'맛있는 해산물요리',18,'no_image'),(73,'매콤한 명절요리',19,'no_image'),(74,'특제 명절요리',19,'no_image'),(75,'초간단 명절요리',19,'no_image'),(76,'맛있는 명절요리',19,'no_image'),(77,'로제파스타',20,'no_image'),(78,'토마토파스타',20,'no_image'),(79,'까르보나라',20,'no_image'),(80,'알리오올리오',20,'no_image'),(81,'하와이안피자',21,'no_image'),(82,'페퍼로니피자',21,'no_image'),(83,'고르곤졸라피자',21,'no_image'),(84,'마르게리따피자',21,'no_image'),(85,'바베큐폭립',22,'no_image'),(86,'티본스테이크',22,'no_image'),(87,'등심스테이크',22,'no_image'),(88,'안심스테이크',22,'no_image'),(89,'버섯 들깨리조또',23,'no_image'),(90,'특제 리조또/필라프',23,'no_image'),(91,'초간단 리조또/필라프',23,'no_image'),(92,'맛있는 리조또/필라프',23,'no_image'),(93,'매콤한 샌드위치/버거',24,'no_image'),(94,'특제 샌드위치/버거',24,'no_image'),(95,'초간단 샌드위치/버거',24,'no_image'),(96,'맛있는 샌드위치/버거',24,'no_image'),(97,'매콤한 커틀릿/튀김',25,'no_image'),(98,'특제 커틀릿/튀김',25,'no_image'),(99,'초간단 커틀릿/튀김',25,'no_image'),(100,'맛있는 커틀릿/튀김',25,'no_image'),(101,'매콤한 스프/스튜',26,'no_image'),(102,'특제 스프/스튜',26,'no_image'),(103,'초간단 스프/스튜',26,'no_image'),(104,'맛있는 스프/스튜',26,'no_image'),(105,'매콤한 그라탕/오븐요리',27,'no_image'),(106,'특제 그라탕/오븐요리',27,'no_image'),(107,'초간단 그라탕/오븐요리',27,'no_image'),(108,'맛있는 그라탕/오븐요리',27,'no_image'),(109,'매콤한 오일/팬요리',28,'no_image'),(110,'특제 오일/팬요리',28,'no_image'),(111,'초간단 오일/팬요리',28,'no_image'),(112,'맛있는 오일/팬요리',28,'no_image'),(113,'매콤한 브런치',29,'no_image'),(114,'특제 브런치',29,'no_image'),(115,'초간단 브런치',29,'no_image'),(116,'맛있는 브런치',29,'no_image'),(117,'울면',30,'no_image'),(118,'우동',30,'no_image'),(119,'짬뽕',30,'no_image'),(120,'짜장면',30,'no_image'),(121,'매콤한 중식밥',31,'no_image'),(122,'특제 중식밥',31,'no_image'),(123,'초간단 중식밥',31,'no_image'),(124,'맛있는 중식밥',31,'no_image'),(125,'유린기',32,'no_image'),(126,'깐풍기',32,'no_image'),(127,'꿔바로우',32,'no_image'),(128,'탕수육',32,'no_image'),(129,'매콤한 해물튀김',33,'no_image'),(130,'특제 해물튀김',33,'no_image'),(131,'초간단 해물튀김',33,'no_image'),(132,'맛있는 해물튀김',33,'no_image'),(133,'매콤한 볶음요리',34,'no_image'),(134,'특제 볶음요리',34,'no_image'),(135,'초간단 볶음요리',34,'no_image'),(136,'맛있는 볶음요리',34,'no_image'),(137,'매콤한 탕/스프',35,'no_image'),(138,'특제 탕/스프',35,'no_image'),(139,'초간단 탕/스프',35,'no_image'),(140,'맛있는 탕/스프',35,'no_image'),(141,'매콤한 만두/딤섬',36,'no_image'),(142,'특제 만두/딤섬',36,'no_image'),(143,'초간단 만두/딤섬',36,'no_image'),(144,'맛있는 만두/딤섬',36,'no_image'),(145,'매콤한 냉채',37,'no_image'),(146,'특제 냉채',37,'no_image'),(147,'초간단 냉채',37,'no_image'),(148,'맛있는 냉채',37,'no_image'),(149,'매콤한 두부/채소',38,'no_image'),(150,'특제 두부/채소',38,'no_image'),(151,'초간단 두부/채소',38,'no_image'),(152,'맛있는 두부/채소',38,'no_image'),(153,'매콤한 마라/퓨전',39,'no_image'),(154,'특제 마라/퓨전',39,'no_image'),(155,'초간단 마라/퓨전',39,'no_image'),(156,'맛있는 마라/퓨전',39,'no_image'),(157,'새우초밥',40,'no_image'),(158,'계란초밥',40,'no_image'),(159,'광어초밥',40,'no_image'),(160,'연어초밥',40,'no_image'),(161,'텐동',41,'no_image'),(162,'사케동',41,'no_image'),(163,'규동',41,'no_image'),(164,'가츠동',41,'no_image'),(165,'매콤한 우동/소바',42,'no_image'),(166,'특제 우동/소바',42,'no_image'),(167,'초간단 우동/소바',42,'no_image'),(168,'맛있는 우동/소바',42,'no_image'),(169,'탄탄멘',43,'no_image'),(170,'쇼유라멘',43,'no_image'),(171,'미소라멘',43,'no_image'),(172,'돈코츠라멘',43,'no_image'),(173,'매콤한 카레',44,'no_image'),(174,'특제 카레',44,'no_image'),(175,'초간단 카레',44,'no_image'),(176,'맛있는 카레',44,'no_image'),(177,'매콤한 돈카츠/튀김',45,'no_image'),(178,'특제 돈카츠/튀김',45,'no_image'),(179,'초간단 돈카츠/튀김',45,'no_image'),(180,'맛있는 돈카츠/튀김',45,'no_image'),(181,'매콤한 구이요리',46,'no_image'),(182,'특제 구이요리',46,'no_image'),(183,'초간단 구이요리',46,'no_image'),(184,'맛있는 구이요리',46,'no_image'),(185,'매콤한 나베/전골',47,'no_image'),(186,'특제 나베/전골',47,'no_image'),(187,'초간단 나베/전골',47,'no_image'),(188,'맛있는 나베/전골',47,'no_image'),(189,'매콤한 철판요리',48,'no_image'),(190,'특제 철판요리',48,'no_image'),(191,'초간단 철판요리',48,'no_image'),(192,'맛있는 철판요리',48,'no_image'),(193,'매콤한 일식가정식',49,'no_image'),(194,'특제 일식가정식',49,'no_image'),(195,'초간단 일식가정식',49,'no_image'),(196,'맛있는 일식가정식',49,'no_image'),(197,'분보후에',50,'no_image'),(198,'똠얌쌀국수',50,'no_image'),(199,'해물쌀국수',50,'no_image'),(200,'양지쌀국수',50,'no_image'),(201,'매콤한 아시안밥',51,'no_image'),(202,'특제 아시안밥',51,'no_image'),(203,'초간단 아시안밥',51,'no_image'),(204,'맛있는 아시안밥',51,'no_image'),(205,'마사만커리',52,'no_image'),(206,'레드커리',52,'no_image'),(207,'그린커리',52,'no_image'),(208,'푸팟퐁커리',52,'no_image'),(209,'매콤한 스프/탕',53,'no_image'),(210,'특제 스프/탕',53,'no_image'),(211,'초간단 스프/탕',53,'no_image'),(212,'맛있는 스프/탕',53,'no_image'),(213,'매콤한 고기요리',54,'no_image'),(214,'특제 고기요리',54,'no_image'),(215,'초간단 고기요리',54,'no_image'),(216,'맛있는 고기요리',54,'no_image'),(217,'매콤한 해물요리',55,'no_image'),(218,'특제 해물요리',55,'no_image'),(219,'초간단 해물요리',55,'no_image'),(220,'맛있는 해물요리',55,'no_image'),(221,'매콤한 볶음요리',56,'no_image'),(222,'특제 볶음요리',56,'no_image'),(223,'초간단 볶음요리',56,'no_image'),(224,'맛있는 볶음요리',56,'no_image'),(225,'매콤한 사이드/튀김',57,'no_image'),(226,'특제 사이드/튀김',57,'no_image'),(227,'초간단 사이드/튀김',57,'no_image'),(228,'맛있는 사이드/튀김',57,'no_image'),(229,'매콤한 아시안쌈',58,'no_image'),(230,'특제 아시안쌈',58,'no_image'),(231,'초간단 아시안쌈',58,'no_image'),(232,'맛있는 아시안쌈',58,'no_image'),(233,'매콤한 모닝글로리',59,'no_image'),(234,'특제 모닝글로리',59,'no_image'),(235,'초간단 모닝글로리',59,'no_image'),(236,'맛있는 모닝글로리',59,'no_image'),(237,'딸기요거트샐러드',60,'no_image'),(238,'연어샐러드',60,'no_image'),(239,'닭가슴살샐러드',60,'no_image'),(240,'리코타치즈샐러드',60,'no_image'),(241,'매콤한 포케/웜볼',61,'no_image'),(242,'특제 포케/웜볼',61,'no_image'),(243,'초간단 포케/웜볼',61,'no_image'),(244,'맛있는 포케/웜볼',61,'no_image'),(245,'매콤한 닭가슴살',62,'no_image'),(246,'특제 닭가슴살',62,'no_image'),(247,'초간단 닭가슴살',62,'no_image'),(248,'맛있는 닭가슴살',62,'no_image'),(249,'매콤한 두부/묵',63,'no_image'),(250,'특제 두부/묵',63,'no_image'),(251,'초간단 두부/묵',63,'no_image'),(252,'맛있는 두부/묵',63,'no_image'),(253,'매콤한 계란요리',64,'no_image'),(254,'특제 계란요리',64,'no_image'),(255,'초간단 계란요리',64,'no_image'),(256,'맛있는 계란요리',64,'no_image'),(257,'매콤한 식단밥/죽',65,'no_image'),(258,'특제 식단밥/죽',65,'no_image'),(259,'초간단 식단밥/죽',65,'no_image'),(260,'맛있는 식단밥/죽',65,'no_image'),(261,'매콤한 샌드위치/랩',66,'no_image'),(262,'특제 샌드위치/랩',66,'no_image'),(263,'초간단 샌드위치/랩',66,'no_image'),(264,'맛있는 샌드위치/랩',66,'no_image'),(265,'매콤한 야채/찜요리',67,'no_image'),(266,'특제 야채/찜요리',67,'no_image'),(267,'초간단 야채/찜요리',67,'no_image'),(268,'맛있는 야채/찜요리',67,'no_image'),(269,'매콤한 생선/해산물',68,'no_image'),(270,'특제 생선/해산물',68,'no_image'),(271,'초간단 생선/해산물',68,'no_image'),(272,'맛있는 생선/해산물',68,'no_image'),(273,'매콤한 주스/스무디',69,'no_image'),(274,'특제 주스/스무디',69,'no_image'),(275,'초간단 주스/스무디',69,'no_image'),(276,'맛있는 주스/스무디',69,'no_image'),(277,'원팬스테이크',70,'no_image'),(278,'원팟리조또',70,'no_image'),(279,'원팬토스트',70,'no_image'),(280,'원팬파스타',70,'no_image'),(281,'매콤한 전자레인지',71,'no_image'),(282,'특제 전자레인지',71,'no_image'),(283,'초간단 전자레인지',71,'no_image'),(284,'맛있는 전자레인지',71,'no_image'),(285,'매콤한 에어프라이어',72,'no_image'),(286,'특제 에어프라이어',72,'no_image'),(287,'초간단 에어프라이어',72,'no_image'),(288,'맛있는 에어프라이어',72,'no_image'),(289,'매콤한 5분토스트',73,'no_image'),(290,'특제 5분토스트',73,'no_image'),(291,'초간단 5분토스트',73,'no_image'),(292,'맛있는 5분토스트',73,'no_image'),(293,'매콤한 한그릇밥',74,'no_image'),(294,'특제 한그릇밥',74,'no_image'),(295,'초간단 한그릇밥',74,'no_image'),(296,'맛있는 한그릇밥',74,'no_image'),(297,'콩국수',75,'no_image'),(298,'특제 간단면식',75,'no_image'),(299,'초간단 간단면식',75,'no_image'),(300,'맛있는 간단면식',75,'no_image'),(301,'매콤한 비빔/무침',76,'no_image'),(302,'특제 비빔/무침',76,'no_image'),(303,'초간단 비빔/무침',76,'no_image'),(304,'맛있는 비빔/무침',76,'no_image'),(305,'매콤한 밀키트/시판',77,'no_image'),(306,'특제 밀키트/시판',77,'no_image'),(307,'초간단 밀키트/시판',77,'no_image'),(308,'맛있는 밀키트/시판',77,'no_image'),(309,'매콤한 노오븐디저트',78,'no_image'),(310,'특제 노오븐디저트',78,'no_image'),(311,'초간단 노오븐디저트',78,'no_image'),(312,'맛있는 노오븐디저트',78,'no_image'),(313,'매콤한 남은재료처리',79,'no_image'),(314,'특제 남은재료처리',79,'no_image'),(315,'초간단 남은재료처리',79,'no_image'),(316,'맛있는 남은재료처리',79,'no_image'),(317,'매콤한 젤리/푸딩',80,'no_image'),(318,'특제 젤리/푸딩',80,'no_image'),(319,'초간단 젤리/푸딩',80,'no_image'),(320,'맛있는 젤리/푸딩',80,'no_image'),(321,'녹차빙수',81,'no_image'),(322,'딸기빙수',81,'no_image'),(323,'망고빙수',81,'no_image'),(324,'팥빙수',81,'no_image'),(325,'매콤한 과일간식',82,'no_image'),(326,'특제 과일간식',82,'no_image'),(327,'초간단 과일간식',82,'no_image'),(328,'맛있는 과일간식',82,'no_image'),(329,'매콤한 떡/한과',83,'no_image'),(330,'특제 떡/한과',83,'no_image'),(331,'초간단 떡/한과',83,'no_image'),(332,'맛있는 떡/한과',83,'no_image'),(333,'매콤한 초콜릿/사탕',84,'no_image'),(334,'특제 초콜릿/사탕',84,'no_image'),(335,'초간단 초콜릿/사탕',84,'no_image'),(336,'맛있는 초콜릿/사탕',84,'no_image'),(337,'매콤한 노오븐디저트',85,'no_image'),(338,'특제 노오븐디저트',85,'no_image'),(339,'초간단 노오븐디저트',85,'no_image'),(340,'맛있는 노오븐디저트',85,'no_image'),(341,'복숭아요거트',86,'no_image'),(342,'특제 요거트',86,'no_image'),(343,'초간단 요거트',86,'no_image'),(344,'맛있는 요거트',86,'no_image'),(345,'매콤한 샌드/영양바',87,'no_image'),(346,'특제 샌드/영양바',87,'no_image'),(347,'초간단 샌드/영양바',87,'no_image'),(348,'맛있는 샌드/영양바',87,'no_image'),(349,'매콤한 튀김간식',88,'no_image'),(350,'특제 튀김간식',88,'no_image'),(351,'초간단 튀김간식',88,'no_image'),(352,'맛있는 튀김간식',88,'no_image'),(353,'매콤한 구황작물',89,'no_image'),(354,'특제 구황작물',89,'no_image'),(355,'초간단 구황작물',89,'no_image'),(356,'맛있는 구황작물',89,'no_image'),(357,'매콤한 식빵/모닝빵',90,'no_image'),(358,'특제 식빵/모닝빵',90,'no_image'),(359,'초간단 식빵/모닝빵',90,'no_image'),(360,'맛있는 식빵/모닝빵',90,'no_image'),(361,'매콤한 쿠키',91,'no_image'),(362,'특제 쿠키',91,'no_image'),(363,'초간단 쿠키',91,'no_image'),(364,'맛있는 쿠키',91,'no_image'),(365,'당근케이크',92,'no_image'),(366,'치즈케이크',92,'no_image'),(367,'초코케이크',92,'no_image'),(368,'생크림케이크',92,'no_image'),(369,'매콤한 타르트/파이',93,'no_image'),(370,'특제 타르트/파이',93,'no_image'),(371,'초간단 타르트/파이',93,'no_image'),(372,'맛있는 타르트/파이',93,'no_image'),(373,'매콤한 머핀/컵케이크',94,'no_image'),(374,'특제 머핀/컵케이크',94,'no_image'),(375,'초간단 머핀/컵케이크',94,'no_image'),(376,'맛있는 머핀/컵케이크',94,'no_image'),(377,'매콤한 구움과자',95,'no_image'),(378,'특제 구움과자',95,'no_image'),(379,'초간단 구움과자',95,'no_image'),(380,'맛있는 구움과자',95,'no_image'),(381,'매콤한 와플/팬케이크',96,'no_image'),(382,'특제 와플/팬케이크',96,'no_image'),(383,'초간단 와플/팬케이크',96,'no_image'),(384,'맛있는 와플/팬케이크',96,'no_image'),(385,'매콤한 비건베이킹',97,'no_image'),(386,'특제 비건베이킹',97,'no_image'),(387,'초간단 비건베이킹',97,'no_image'),(388,'맛있는 비건베이킹',97,'no_image'),(389,'매콤한 패스트리',98,'no_image'),(390,'특제 패스트리',98,'no_image'),(391,'초간단 패스트리',98,'no_image'),(392,'맛있는 패스트리',98,'no_image'),(393,'매콤한 핑거푸드',99,'no_image'),(394,'특제 핑거푸드',99,'no_image'),(395,'초간단 핑거푸드',99,'no_image'),(396,'맛있는 핑거푸드',99,'no_image'),(397,'콜드브루',100,'no_image'),(398,'바닐라라떼',100,'no_image'),(399,'카페라떼',100,'no_image'),(400,'아메리카노',100,'no_image'),(401,'매콤한 에이드',101,'no_image'),(402,'특제 에이드',101,'no_image'),(403,'초간단 에이드',101,'no_image'),(404,'맛있는 에이드',101,'no_image'),(405,'매콤한 과일주스',102,'no_image'),(406,'특제 과일주스',102,'no_image'),(407,'초간단 과일주스',102,'no_image'),(408,'맛있는 과일주스',102,'no_image'),(409,'매콤한 전통차',103,'no_image'),(410,'특제 전통차',103,'no_image'),(411,'초간단 전통차',103,'no_image'),(412,'맛있는 전통차',103,'no_image'),(413,'매콤한 허브티/홍차',104,'no_image'),(414,'특제 허브티/홍차',104,'no_image'),(415,'초간단 허브티/홍차',104,'no_image'),(416,'맛있는 허브티/홍차',104,'no_image'),(417,'매콤한 라떼/밀크',105,'no_image'),(418,'특제 라떼/밀크',105,'no_image'),(419,'초간단 라떼/밀크',105,'no_image'),(420,'맛있는 라떼/밀크',105,'no_image'),(421,'매콤한 무알코올',106,'no_image'),(422,'특제 무알코올',106,'no_image'),(423,'초간단 무알코올',106,'no_image'),(424,'맛있는 무알코올',106,'no_image'),(425,'매콤한 홈술/칵테일',107,'no_image'),(426,'특제 홈술/칵테일',107,'no_image'),(427,'초간단 홈술/칵테일',107,'no_image'),(428,'맛있는 홈술/칵테일',107,'no_image'),(429,'매콤한 해독/건강차',108,'no_image'),(430,'특제 해독/건강차',108,'no_image'),(431,'초간단 해독/건강차',108,'no_image'),(432,'맛있는 해독/건강차',108,'no_image'),(433,'매콤한 수제청',109,'no_image'),(434,'특제 수제청',109,'no_image'),(435,'초간단 수제청',109,'no_image'),(436,'맛있는 수제청',109,'no_image');
/*!40000 ALTER TABLE `food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fridge_item`
--

DROP TABLE IF EXISTS `fridge_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fridge_item` (
  `fridge_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `ingredient_name` varchar(100) NOT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `freezer` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`fridge_id`),
  KEY `fk_fridge_member` (`member_id`),
  CONSTRAINT `fk_fridge_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fridge_item`
--

LOCK TABLES `fridge_item` WRITE;
/*!40000 ALTER TABLE `fridge_item` DISABLE KEYS */;
INSERT INTO `fridge_item` VALUES (2,1,'돼지고기 앞다리살','300g','2026-06-05','2026-05-29 10:12:59',0),(3,1,'우유','1L','2026-06-05','2026-05-29 10:12:59',0),(4,1,'달걀','10알','2026-06-20','2026-05-29 10:12:59',0),(5,1,'두부','1모','2026-06-02','2026-05-29 10:12:59',0),(6,1,'체다 치즈','10장','2026-07-10','2026-05-29 10:12:59',0),(7,1,'양파','3개','2026-06-15','2026-05-29 10:12:59',0),(8,1,'당근','1개','2026-06-18','2026-05-29 10:12:59',0),(9,1,'배추김치','1포기','2026-09-30','2026-05-29 10:12:59',0),(10,1,'사과','5개','2026-06-25','2026-05-29 10:12:59',0),(11,1,'플레인 요거트','4개','2026-06-08','2026-05-29 10:12:59',0),(12,1,'대파','1단','2026-06-12','2026-05-29 10:12:59',0),(13,1,'콩나물','1봉지','2026-06-01','2026-05-29 10:12:59',0),(14,1,'팽이버섯','2봉지','2026-06-03','2026-05-29 10:12:59',0),(15,1,'다진 마늘','150g','2026-07-15','2026-05-29 10:12:59',0),(16,1,'슬라이스 햄','200g','2026-06-14','2026-05-29 10:12:59',0),(18,1,'어묵','1봉지','2026-06-07','2026-05-29 10:12:59',0),(19,1,'방울토마토','500g','2026-06-09','2026-05-29 10:12:59',0),(20,1,'오이','2개','2026-06-11','2026-05-29 10:12:59',0),(21,1,'청양고추','1봉지','2026-06-20','2026-05-29 10:12:59',0),(22,1,'상추','100g','2026-06-02','2026-05-29 10:12:59',0),(23,1,'깻잎','30장','2026-06-03','2026-05-29 10:12:59',0),(24,1,'파프리카','2개','2026-06-14','2026-05-29 10:12:59',0),(25,1,'버터','200g','2026-08-22','2026-05-29 10:12:59',0),(26,1,'쌈장','500g','2026-11-30','2026-05-29 10:12:59',0),(27,1,'고추장','1kg','2027-05-15','2026-05-29 10:12:59',0),(28,1,'단무지','1팩','2026-07-01','2026-05-29 10:12:59',0),(29,1,'새송이버섯','1봉지','2026-06-06','2026-05-29 10:12:59',0),(30,1,'무','1/2개','2026-06-22','2026-05-29 10:12:59',0),(31,1,'생강','50g','2026-07-20','2026-05-29 10:12:59',0),(32,1,'양배추','1/4통','2026-06-17','2026-05-29 10:12:59',0),(33,1,'냉동 삼겹살','500g','2026-12-31','2026-05-29 10:12:59',1),(34,1,'냉동 만두','1봉지','2026-11-15','2026-05-29 10:12:59',1),(35,1,'냉동 블루베리','1kg','2027-05-20','2026-05-29 10:12:59',1),(36,1,'냉동 닭가슴살','1kg','2026-09-10','2026-05-29 10:12:59',1),(37,1,'피자 치즈','300g','2026-08-05','2026-05-29 10:12:59',1),(38,1,'냉동 새우','20마리','2026-12-01','2026-05-29 10:12:59',1),(39,1,'떡볶이 떡','500g','2026-07-14','2026-05-29 10:12:59',1),(40,1,'돈가스','4장','2026-11-30','2026-05-29 10:12:59',1),(41,1,'얼린 대파','1통','2026-08-20','2026-05-29 10:12:59',1),(42,1,'차돌박이','400g','2026-10-15','2026-05-29 10:12:59',1),(43,1,'냉동 다진 생강','100g','2026-12-25','2026-05-29 10:12:59',1),(44,1,'멸치 육수팩','10개','2027-03-10','2026-05-29 10:12:59',1),(45,1,'베이킹용 생크림','500ml','2026-08-11','2026-05-29 10:12:59',1),(46,1,'손질 고등어','2마리','2026-09-05','2026-05-29 10:12:59',1),(47,1,'오징어 링','300g','2026-11-04','2026-05-29 10:12:59',1),(48,1,'냉동 볶음밥','3봉지','2026-08-30','2026-05-29 10:12:59',1),(49,1,'해물 모둠','500g','2026-12-15','2026-05-29 10:12:59',1),(50,1,'우삼겹','600g','2026-10-22','2026-05-29 10:12:59',1),(51,1,'냉동 감자튀김','1kg','2027-02-18','2026-05-29 10:12:59',1),(52,1,'얼린 청양고추','1통','2026-09-12','2026-05-29 10:12:59',1),(53,1,'가래떡','1팩','2026-08-01','2026-05-29 10:12:59',1),(54,1,'바닐라 아이스크림','1L','2026-11-20','2026-05-29 10:12:59',1),(55,1,'냉동 딸기','1kg','2027-04-05','2026-05-29 10:12:59',1),(56,1,'치킨 너겟','500g','2026-10-09','2026-05-29 10:12:59',1),(57,1,'손질 갈치','3 토막','2026-08-14','2026-05-29 10:12:59',1),(58,1,'피자 도우','2장','2026-07-25','2026-05-29 10:12:59',1),(59,1,'냉동 콘옥수수','1kg','2027-01-30','2026-05-29 10:12:59',1),(60,1,'얼린 마늘 박스','200g','2026-11-11','2026-05-29 10:12:59',1),(61,1,'대패 삼겹살','1kg','2026-11-05','2026-05-29 10:12:59',1),(62,1,'떡갈비','5장','2026-09-22','2026-05-29 10:12:59',1);
/*!40000 ALTER TABLE `fridge_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guide`
--

DROP TABLE IF EXISTS `guide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guide` (
  `guide_id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `tab` varchar(20) NOT NULL COMMENT 'storage:보관법, trim:손질법, tip:요리꿀팁, etc:기타정보',
  PRIMARY KEY (`guide_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guide`
--

LOCK TABLES `guide` WRITE;
/*!40000 ALTER TABLE `guide` DISABLE KEYS */;
INSERT INTO `guide` VALUES (1,'양파 오래 보관하는 법','신선한 양파 보관','onion.png','storage'),(2,'장어 손질법','깔끔한 손질로 더 맛있게','eel.png','trim'),(3,'삶은 계란 쉽게 까는 법','한 번에 깔끔하게','egg.png','tip'),(4,'칼 관리 방법','주방도구 관리','knife.png','etc'),(5,'대파 보관법','냉동 보관','green_onion.png','storage'),(6,'전복 손질법','신선함을 살리는','abalone.png','trim');
/*!40000 ALTER TABLE `guide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guide_step`
--

DROP TABLE IF EXISTS `guide_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guide_step` (
  `step_id` bigint NOT NULL AUTO_INCREMENT,
  `guide_id` bigint NOT NULL,
  `step_num` int NOT NULL,
  `step_image` varchar(255) DEFAULT NULL,
  `step_content` longtext NOT NULL,
  PRIMARY KEY (`step_id`),
  KEY `fk_guide_step_idx` (`guide_id`),
  CONSTRAINT `fk_guide_step` FOREIGN KEY (`guide_id`) REFERENCES `guide` (`guide_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guide_step`
--

LOCK TABLES `guide_step` WRITE;
/*!40000 ALTER TABLE `guide_step` DISABLE KEYS */;
INSERT INTO `guide_step` VALUES (1,1,1,'onion_step1.png','양파의 겉껍질과 흙을 가볍게 제거합니다.'),(2,1,2,'onion_step2.png','망이나 바구니에 담아 통풍이 잘되도록 합니다.'),(3,1,3,'onion_step3.png','직사광선을 피해 서늘한 곳에 보관합니다.'),(4,2,1,'eel_step1.png','장어를 흐르는 물에 씻은 뒤 밀가루를 뿌려 가볍게 문질러 주세요. 미끈한 점액과 비린내 제거에 효과적입니다.'),(5,2,2,'eel_step2.png','가위를 이용해 배를 갈라 내장과 핏물을 제거합니다. 검붉은 핏줄까지 깨끗이 씻어야 잡내를 줄일 수 있습니다.'),(6,2,3,'eel_step3.png','등지느러미와 꼬리 부분을 정리한 뒤 먹기 좋은 크기로 자릅니다. TIP. 키친타월로 물기를 제거하면 양념이 잘 배어듭니다.'),(7,3,1,'egg_step1.png','계란을 실온에 10~15분 두었다가 삶으면 껍질이 덜 깨집니다.'),(8,3,2,'egg_step2.png','끓는 물에 식초 한 큰술과 소금 약간을 넣고 계란을 삶아주세요.'),(9,3,3,'egg_step3.png','삶은 계란은 얼음물에 5분 이상 식힌 뒤 까면 껍질이 쉽게 벗겨집니다.'),(10,4,1,'knife_step1.png','식칼은 사용 후 바로 중성세제로 세척하고 물기를 완전히 닦아 녹이 생기지 않도록 합니다.'),(11,4,2,'knife_step2.png','칼날이 무뎌지면 칼갈이로 주기적으로 관리해 주세요.'),(12,4,3,'knife_step3.png','식칼은 칼꽂이나 칼집에 보관해 칼날 손상을 막고 안전하게 사용할 수 있도록 합니다.'),(13,5,1,'green_onion_step1.png','대파 뿌리를 잘라 물이 담긴 컵에 꽂아두면 며칠 동안 싱싱하게 보관할 수 있습니다.'),(14,5,2,'green_onion_step2.png','대파를 썰기 전 10분 정도 냉동실에 넣어두면 눈물이 덜 나옵니다.'),(15,5,3,'green_onion_step3.png','남은 대파는 식용유를 살짝 버무려 냉동하면 서로 달라붙지 않아 필요한 만큼만 꺼내 쓰기 좋습니다.'),(16,6,1,'abalone_step1.png','숟가락을 전복 껍데기 끝부분에 넣어 밀면 살이 깔끔하게 분리됩니다.'),(17,6,2,'abalone_step2.png','전복은 칫솔이나 솔로 검은 부분을 꼼꼼히 문질러야 비린내를 줄일 수 있습니다.'),(18,6,3,'abalone_step3.png','입과 내장을 제거한 뒤 칼집을 살짝 넣으면 양념이 잘 배고 식감도 더욱 부드러워집니다.');
/*!40000 ALTER TABLE `guide_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `img`
--

DROP TABLE IF EXISTS `img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `img` (
  `img_id` int NOT NULL AUTO_INCREMENT,
  `image_list` varchar(500) DEFAULT NULL,
  `inquiry_id` bigint DEFAULT NULL,
  `notice_id` bigint DEFAULT NULL,
  `review_id` bigint DEFAULT NULL,
  PRIMARY KEY (`img_id`),
  KEY `img_inquiry_FK` (`inquiry_id`),
  KEY `img_notice_FK` (`notice_id`),
  KEY `img_review_FK` (`review_id`),
  CONSTRAINT `img_inquiry_FK` FOREIGN KEY (`inquiry_id`) REFERENCES `inquiry` (`inquiry_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `img_notice_FK` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `img_review_FK` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img`
--

LOCK TABLES `img` WRITE;
/*!40000 ALTER TABLE `img` DISABLE KEYS */;
INSERT INTO `img` VALUES (1,'/images/recipe_kimchi_01.jpg',NULL,NULL,NULL),(2,'/images/recipe_kimchi_01.jpg',NULL,NULL,NULL),(6,'1782778048864_no_file.png',6,NULL,NULL),(8,'1782808630250_no_file.png,1782808630253_document2.png,1782808630255_chat.png,1782808630255_bookmark2.png',NULL,NULL,NULL),(9,'1782808792618_no_file.png,1782808792620_document2.png,1782808792621_chat.png,1782808792622_bookmark2.png,1782808792623_chat_bubble.png,help.png,delete_user.png,logout.png',NULL,NULL,NULL);
/*!40000 ALTER TABLE `img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `ingredient_id` bigint NOT NULL AUTO_INCREMENT,
  `ingredient_name` varchar(255) DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `recipe_id` bigint NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `recipe_id` (`recipe_id`),
  CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (1,NULL,1,'포기','채소',1),(2,NULL,300,'g','육류',1),(3,NULL,1,'모','기타',1),(4,NULL,2,'스푼','양념-장류',1),(5,NULL,600,'g','육류',2),(6,NULL,1,'개','채소',2),(7,NULL,3,'스푼','양념-장류',2),(8,'스팸',200,'g','육류',3),(9,'밥',1,'공기','곡류',3),(10,'계란',2,'개','축산물',3),(11,'마요네즈',2,'스푼','소스류',3),(12,'김가루',1,'줌','해조류',3),(13,'밥',1,'공기','곡류',4),(14,'계란',1,'개','축산물',4),(15,'진간장',1,'스푼','소스류',4),(16,'참기름',1,'스푼','소스류',4),(17,'참깨',1,'티스푼','기타',4),(18,'생연어',150,'g','수산물',5),(19,'양상추',100,'g','채소',5),(20,'방울토마토',5,'개','과일/채소',5),(21,'양파',30,'g','채소',5),(22,'발사믹 드레싱',2,'스푼','소스류',5),(23,'소고기 안심',300,'g','육류',6),(24,'양파',1,'개','채소',6),(25,'파프리카',1,'개','채소',6),(26,'양송이버섯',3,'개','버섯류',6),(27,'스테이크 소스',3,'스푼','소스류',6),(28,'버터',1,'조각','유제품',6),(29,'냉동 새우',15,'마리','수산물',7),(30,'통마늘',10,'알','채소',7),(31,'올리브유',150,'ml','유지류',7),(32,'페페론치노',4,'개','향신료',7),(33,'바게트',3,'조각','빵류',7),(34,'소금',1,'꼬집','조미료',7);
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inquiry`
--

DROP TABLE IF EXISTS `inquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquiry` (
  `inquiry_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `admin_id` bigint DEFAULT NULL,
  `answer_content` varchar(100) DEFAULT NULL,
  `answered_date` datetime DEFAULT NULL,
  `guest_name` varchar(50) DEFAULT NULL,
  `guest_email` varchar(100) DEFAULT NULL,
  `guest_password` varchar(255) DEFAULT NULL,
  `inquiry_code` varchar(50) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`inquiry_id`),
  UNIQUE KEY `inquiry_code` (`inquiry_code`),
  KEY `fk_inquiry_member` (`member_id`),
  KEY `fk_inquiry_admin` (`admin_id`),
  CONSTRAINT `fk_inquiry_admin` FOREIGN KEY (`admin_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_inquiry_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inquiry`
--

LOCK TABLES `inquiry` WRITE;
/*!40000 ALTER TABLE `inquiry` DISABLE KEYS */;
INSERT INTO `inquiry` VALUES (1,1,'탈퇴한 계정의 게시글 처리는 어떻게 되나요?','회원 탈퇴를 하게 되면 예전에 썼던 게시글들도 같이 지워지는지 궁금합니다.','n','2026-05-29 10:12:59',2,'탈퇴 시 본인 게시글은 자동 삭제되지 않으니 미리 삭제 후 탈퇴 바랍니다.','2026-06-30 09:05:44',NULL,NULL,NULL,NULL,'계정'),(6,3,'sada','dsadasd','y','2026-06-30 09:07:28',2,'아......','2026-06-30 09:11:19',NULL,NULL,NULL,'INQ-20260630-6-3s3iMRPpM2UNeVBTQYirbA','레시피 문의');
/*!40000 ALTER TABLE `inquiry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `member_id` bigint NOT NULL AUTO_INCREMENT,
  `login_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nickname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'USER',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'ACTIVE',
  `report_count` int DEFAULT '0',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `profile_img` varchar(100) DEFAULT NULL,
  `login_type` varchar(20) DEFAULT 'LOCAL',
  `provider` varchar(20) DEFAULT NULL,
  `provider_id` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `member_intro` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `nickname` (`nickname`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `login_id` (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'chef_gildong','$2a$10$WRBKSJUzg01GoAZFS8XYaeRqeeeSxOvJltS7Hbin56JLDKd6wz2W6','요리왕길동','gildong@example.com','USER','ACTIVE',0,'2026-05-29 10:10:34','no_file.png','LOCAL',NULL,NULL,'홍길동','안녕하세요'),(2,'admin','$2a$10$umWJ/KkwKumBTjqaCqC2NeIAX1LnytfeHbcXmiNkE.YtPe9NX6vwu','관리자','admin@example.com','ADMIN',NULL,0,'2026-05-29 14:32:08','에멩.png','LOCAL',NULL,NULL,'관리자','관리자 입니다.'),(3,NULL,NULL,'김호근','kimhk441@naver.com','USER',NULL,0,'2026-06-23 23:21:33','1782750930289_양양.png','SOCIAL','naver','p2nl0l_QQcTLs-zTrphPA32aTKwc7TWNHTM2DyqDL8A','김호근','음 어떻하지'),(4,NULL,NULL,'20_41_07_김호근','kimhk408@gmail.com','USER','ACTIVE',0,'2026-06-29 22:51:05','google_null.png','SOCIAL','google','100272746934515043398','20_41_07_김호근',NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `notice_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `view_count` int DEFAULT '0',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notice_id`),
  KEY `fk_notice_member` (`member_id`),
  CONSTRAINT `fk_notice_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,1,'[공지] 냉장고 파먹기 서비스 정기 점검 안내 (5/30)','더 안정적인 서비스 제공을 위해 정기 점검이 진행될 예정입니다. 점검 시간에는 서비스 이용이 제한됩니다.',253,'2026-05-29 10:12:59');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice_view`
--

DROP TABLE IF EXISTS `notice_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_view` (
  `notice_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `viewed_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notice_id`,`member_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `notice_view_ibfk_1` FOREIGN KEY (`notice_id`) REFERENCES `notice` (`notice_id`) ON DELETE CASCADE,
  CONSTRAINT `notice_view_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_view`
--

LOCK TABLES `notice_view` WRITE;
/*!40000 ALTER TABLE `notice_view` DISABLE KEYS */;
INSERT INTO `notice_view` VALUES (1,1,'2026-06-02 10:52:44'),(1,2,'2026-06-02 10:51:30');
/*!40000 ALTER TABLE `notice_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nutrition`
--

DROP TABLE IF EXISTS `nutrition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nutrition` (
  `nutrition_id` bigint NOT NULL AUTO_INCREMENT,
  `calories` varchar(50) NOT NULL,
  `fat` varchar(50) NOT NULL,
  `sugar` varchar(50) NOT NULL,
  `protein` varchar(50) NOT NULL,
  `carbohydrates` varchar(50) NOT NULL,
  `sodium` varchar(50) NOT NULL,
  PRIMARY KEY (`nutrition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nutrition`
--

LOCK TABLES `nutrition` WRITE;
/*!40000 ALTER TABLE `nutrition` DISABLE KEYS */;
/*!40000 ALTER TABLE `nutrition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_token`
--

DROP TABLE IF EXISTS `password_reset_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_token` (
  `token_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expire_date` datetime NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `used` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `token` (`token`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `password_reset_token_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_token`
--

LOCK TABLES `password_reset_token` WRITE;
/*!40000 ALTER TABLE `password_reset_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `recipe_id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `cooking_time` varchar(30) DEFAULT NULL,
  `difficulty` varchar(255) DEFAULT NULL,
  `view_count` int DEFAULT '0',
  `like_count` int DEFAULT '0',
  `member_id` bigint NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'ACTIVE',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL,
  `food_id` bigint NOT NULL,
  `recommend` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`recipe_id`),
  KEY `member_id` (`member_id`),
  KEY `recipe_ibfk_4` (`food_id`),
  CONSTRAINT `recipe_food_FK` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,'달래된장비빔밥 레시피','dalrae.png','15~20분','쉬움',191,3,1,'public','2026-06-16 12:24:06',NULL,1,0),(2,'김치볶음밥 레시피','kimchi_bokum_bap.jpg','20분','어려움',22,11,1,'public','2026-06-16 12:24:06',NULL,2,0),(3,'스팸마요덮밥 레시피','spam_mayo_dupbap.jpg','15분','쉬움',210,76,1,'public','2026-06-16 12:24:06',NULL,3,0),(4,'간장계란밥 레시피','ganjang_egg_bap.jpg','10분','보통',283,54,1,'public','2026-06-16 12:24:06',NULL,4,0),(5,'연어샐러드 레시피','salmon_salad.jpg','30분','어려움',1,38,1,'public','2026-06-16 12:24:06',NULL,5,0),(6,'찹스테이크 레시피','/no_image','20분','쉬움',466,50,1,'public','2026-06-16 12:24:06',NULL,6,0),(7,'감바스 레시피','/no_image','15분','보통',353,3,1,'public','2026-06-16 12:24:06',NULL,7,0),(8,'밀푀유나베 레시피','/no_image','10분','어려움',21,11,1,'public','2026-06-16 12:24:06',NULL,8,0),(9,'두부김치 레시피','/no_image','30분','쉬움',228,93,1,'public','2026-06-16 12:24:06',NULL,9,0),(10,'바지락술찜 레시피','/no_image','20분','보통',142,63,1,'public','2026-06-16 12:24:06',NULL,10,0),(11,'오뎅탕 레시피','/no_image','15분','어려움',153,63,1,'public','2026-06-16 12:24:06',NULL,11,0),(12,'콘치즈 레시피','/no_image','10분','쉬움',132,41,1,'public','2026-06-16 12:24:06',NULL,12,0),(13,'매콤한 캠핑요리 레시피','/no_image','30분','보통',133,9,1,'public','2026-06-16 12:24:06',NULL,13,0),(14,'특제 캠핑요리 레시피','/no_image','20분','어려움',347,17,1,'public','2026-06-16 12:24:06',NULL,14,0),(15,'초간단 캠핑요리 레시피','/no_image','15분','쉬움',401,48,1,'public','2026-06-16 12:24:06',NULL,15,0),(16,'맛있는 캠핑요리 레시피','camping_yori.jpg','10분','보통',498,54,1,'public','2026-06-16 12:24:06',NULL,16,0),(17,'매콤한 아이간식 레시피','/no_image','30분','어려움',363,0,1,'public','2026-06-16 12:24:06',NULL,17,0),(18,'특제 아이간식 레시피','/no_image','20분','쉬움',424,22,1,'public','2026-06-16 12:24:06',NULL,18,0),(19,'초간단 아이간식 레시피','/no_image','15분','보통',287,20,1,'public','2026-06-16 12:24:06',NULL,19,0),(20,'맛있는 아이간식 레시피','/no_image','10분','어려움',143,83,1,'public','2026-06-16 12:24:06',NULL,20,0),(21,'매콤한 SNS 화제 음식 레시피','/no_image','30분','쉬움',145,95,1,'public','2026-06-16 12:24:06',NULL,21,0),(22,'특제 SNS 화제 음식 레시피','/no_image','20분','보통',463,75,1,'public','2026-06-16 12:24:06',NULL,22,0),(23,'초간단 SNS 화제 음식 레시피','/no_image','15분','어려움',3,76,1,'public','2026-06-16 12:24:06',NULL,23,0),(24,'맛있는 SNS 화제 음식 레시피','/no_image','10분','쉬움',396,67,1,'public','2026-06-16 12:24:06',NULL,24,0),(25,'매콤한 해장요리 레시피','/no_image','30분','보통',8,4,1,'public','2026-06-16 12:24:06',NULL,25,0),(26,'특제 해장요리 레시피','/no_image','20분','어려움',88,74,1,'public','2026-06-16 12:24:06',NULL,26,0),(27,'초간단 해장요리 레시피','/no_image','15분','쉬움',97,74,1,'public','2026-06-16 12:24:06',NULL,27,0),(28,'맛있는 해장요리 레시피','/no_image','10분','보통',65,42,1,'public','2026-06-16 12:24:06',NULL,28,0),(29,'매콤한 비 오는 날 추천 레시피','/no_image','30분','어려움',364,37,1,'public','2026-06-16 12:24:06',NULL,29,0),(30,'특제 비 오는 날 추천 레시피','/no_image','20분','쉬움',332,21,1,'public','2026-06-16 12:24:06',NULL,30,0),(31,'초간단 비 오는 날 추천 레시피','/no_image','15분','보통',45,80,1,'public','2026-06-16 12:24:06',NULL,31,0),(32,'맛있는 비 오는 날 추천 레시피','/no_image','10분','어려움',369,29,1,'public','2026-06-16 12:24:06',NULL,32,0),(33,'매콤한 홈 다이닝 레시피','/no_image','30분','쉬움',118,31,1,'public','2026-06-16 12:24:06',NULL,33,0),(34,'특제 홈 다이닝 레시피','/no_image','20분','보통',423,29,1,'public','2026-06-16 12:24:06',NULL,34,0),(35,'초간단 홈 다이닝 레시피','/no_image','15분','어려움',471,82,1,'public','2026-06-16 12:24:06',NULL,35,0),(36,'맛있는 홈 다이닝 레시피','/no_image','10분','쉬움',146,99,1,'public','2026-06-16 12:24:06',NULL,36,0),(37,'무들깨탕 레시피','deulkkae.png','25분','쉬움',39,41,1,'public','2026-06-16 12:24:06',NULL,37,0),(38,'매생이굴국 레시피','maesaengi.png','15~20분','보통',428,2,1,'public','2026-06-16 12:24:06',NULL,38,0),(39,'오이냉국 레시피','cucumber.png','10~15분','쉬움',286,77,1,'public','2026-06-16 12:24:06',NULL,39,0),(40,'냉이두부된장국 레시피','naengi.png','20~25분','보통',87,53,1,'public','2026-06-16 12:24:06',NULL,40,0),(41,'두부조림 레시피','/no_image','30분','어려움',79,18,1,'public','2026-06-16 12:24:06',NULL,41,0),(42,'감자조림 레시피','/no_image','20분','쉬움',217,63,1,'public','2026-06-16 12:24:06',NULL,42,0),(43,'오징어볶음 레시피','/no_image','15분','보통',427,38,1,'public','2026-06-16 12:24:06',NULL,43,0),(44,'제육볶음 레시피','/no_image','10분','어려움',170,56,1,'public','2026-06-16 12:24:06',NULL,44,0),(45,'과메기무침 레시피','gwamegi.png','15~20분','쉬움',392,24,1,'public','2026-06-16 12:24:06',NULL,45,0),(46,'특제 밑반찬 레시피','/no_image','20분','보통',426,53,1,'public','2026-06-16 12:24:06',NULL,46,0),(47,'초간단 밑반찬 레시피','/no_image','15분','어려움',61,1,1,'public','2026-06-16 12:24:06',NULL,47,0),(48,'맛있는 밑반찬 레시피','/no_image','10분','쉬움',340,37,1,'public','2026-06-16 12:24:06',NULL,48,0),(49,'매콤한 김치 레시피','/no_image','30분','보통',418,5,1,'public','2026-06-16 12:24:06',NULL,49,0),(50,'특제 김치 레시피','/no_image','20분','어려움',382,66,1,'public','2026-06-16 12:24:06',NULL,50,0),(51,'초간단 김치 레시피','/no_image','15분','쉬움',2,4,1,'public','2026-06-16 12:24:06',NULL,51,0),(52,'맛있는 김치 레시피','/no_image','10분','보통',104,91,1,'public','2026-06-16 12:24:06',NULL,52,0),(53,'불고기덮밥 레시피','/no_image','30분','어려움',471,97,1,'public','2026-06-16 12:24:06',NULL,53,0),(54,'낙지덮밥 레시피','/no_image','20분','쉬움',18,26,1,'public','2026-06-16 12:24:06',NULL,54,0),(55,'육회비빔밥 레시피','/no_image','15분','보통',114,33,1,'public','2026-06-16 12:24:06',NULL,55,0),(56,'비빔밥 레시피','bibimbap.jpg','10분','어려움',497,96,1,'public','2026-06-16 12:24:06',NULL,56,0),(57,'매콤한 면요리 레시피','/no_image','30분','쉬움',421,32,1,'public','2026-06-16 12:24:06',NULL,57,0),(58,'특제 면요리 레시피','/no_image','20분','보통',39,42,1,'public','2026-06-16 12:24:06',NULL,58,0),(59,'초간단 면요리 레시피','/no_image','15분','어려움',447,19,1,'public','2026-06-16 12:24:06',NULL,59,0),(60,'맛있는 면요리 레시피','/no_image','10분','쉬움',148,89,1,'public','2026-06-16 12:24:06',NULL,60,0),(61,'매콤한 전/튀김 레시피','/no_image','30분','보통',288,20,1,'public','2026-06-16 12:24:06',NULL,61,0),(62,'특제 전/튀김 레시피','/no_image','20분','어려움',156,93,1,'public','2026-06-16 12:24:06',NULL,62,0),(63,'초간단 전/튀김 레시피','/no_image','15분','쉬움',371,90,1,'public','2026-06-16 12:24:06',NULL,63,0),(64,'맛있는 전/튀김 레시피','/no_image','10분','보통',158,85,1,'public','2026-06-16 12:24:06',NULL,64,0),(65,'떡갈비 레시피','/no_image','30분','어려움',157,1,1,'public','2026-06-16 12:24:06',NULL,65,0),(66,'소불고기 레시피','/no_image','20분','쉬움',75,69,1,'public','2026-06-16 12:24:06',NULL,66,0),(67,'배숙성불고기 레시피','pear_bulgogi.png','1시간30분','보통',18,8,1,'public','2026-06-16 12:24:06',NULL,67,0),(68,'전어구이 레시피','gizzard.png','20~25분','보통',161,35,1,'public','2026-06-16 12:24:06',NULL,68,0),(69,'매콤한 해산물요리 레시피','/no_image','30분','쉬움',402,96,1,'public','2026-06-16 12:24:06',NULL,69,0),(70,'특제 해산물요리 레시피','/no_image','20분','보통',197,9,1,'public','2026-06-16 12:24:06',NULL,70,0),(71,'초간단 해산물요리 레시피','/no_image','15분','어려움',134,7,1,'public','2026-06-16 12:24:06',NULL,71,0),(72,'맛있는 해산물요리 레시피','/no_image','10분','쉬움',272,51,1,'public','2026-06-16 12:24:06',NULL,72,0),(73,'매콤한 명절요리 레시피','/no_image','30분','보통',474,19,1,'public','2026-06-16 12:24:06',NULL,73,0),(74,'특제 명절요리 레시피','/no_image','20분','어려움',57,99,1,'public','2026-06-16 12:24:06',NULL,74,0),(75,'초간단 명절요리 레시피','/no_image','15분','쉬움',323,23,1,'public','2026-06-16 12:24:06',NULL,75,0),(76,'맛있는 명절요리 레시피','/no_image','10분','보통',128,56,1,'public','2026-06-16 12:24:06',NULL,76,0),(77,'로제파스타 레시피','/no_image','30분','어려움',23,54,1,'public','2026-06-16 12:24:06',NULL,77,0),(78,'토마토파스타 레시피','/no_image','20분','쉬움',295,31,1,'public','2026-06-16 12:24:06',NULL,78,0),(79,'까르보나라 레시피','/no_image','15분','보통',409,13,1,'public','2026-06-16 12:24:06',NULL,79,0),(80,'알리오올리오 레시피','/no_image','10분','어려움',114,73,1,'public','2026-06-16 12:24:06',NULL,80,0),(81,'하와이안피자 레시피','/no_image','30분','쉬움',496,75,1,'public','2026-06-16 12:24:06',NULL,81,0),(82,'페퍼로니피자 레시피','/no_image','20분','보통',391,66,1,'public','2026-06-16 12:24:06',NULL,82,0),(83,'고르곤졸라피자 레시피','/no_image','15분','어려움',478,79,1,'public','2026-06-16 12:24:06',NULL,83,0),(84,'마르게리따피자 레시피','/no_image','10분','쉬움',57,18,1,'public','2026-06-16 12:24:06',NULL,84,0),(85,'바베큐폭립 레시피','/no_image','30분','보통',281,27,1,'public','2026-06-16 12:24:06',NULL,85,0),(86,'티본스테이크 레시피','/no_image','20분','어려움',344,61,1,'public','2026-06-16 12:24:06',NULL,86,0),(87,'등심스테이크 레시피','/no_image','15분','쉬움',3,18,1,'public','2026-06-16 12:24:06',NULL,87,0),(88,'안심스테이크 레시피','/no_image','10분','보통',461,4,1,'public','2026-06-16 12:24:06',NULL,88,0),(89,'버섯 들깨리조또 레시피','mushroom_risotto.png','30분','보통',238,23,1,'public','2026-06-16 12:24:06',NULL,89,0),(90,'특제 리조또/필라프 레시피','/no_image','20분','쉬움',369,99,1,'public','2026-06-16 12:24:06',NULL,90,0),(91,'초간단 리조또/필라프 레시피','/no_image','15분','보통',383,84,1,'public','2026-06-16 12:24:06',NULL,91,0),(92,'맛있는 리조또/필라프 레시피','/no_image','10분','어려움',452,0,1,'public','2026-06-16 12:24:06',NULL,92,0),(93,'매콤한 샌드위치/버거 레시피','/no_image','30분','쉬움',156,54,1,'public','2026-06-16 12:24:06',NULL,93,0),(94,'특제 샌드위치/버거 레시피','/no_image','20분','보통',390,27,1,'public','2026-06-16 12:24:06',NULL,94,0),(95,'초간단 샌드위치/버거 레시피','/no_image','15분','어려움',6,25,1,'public','2026-06-16 12:24:06',NULL,95,0),(96,'맛있는 샌드위치/버거 레시피','/no_image','10분','쉬움',113,37,1,'public','2026-06-16 12:24:06',NULL,96,0),(97,'매콤한 커틀릿/튀김 레시피','/no_image','30분','보통',92,80,1,'public','2026-06-16 12:24:06',NULL,97,0),(98,'특제 커틀릿/튀김 레시피','/no_image','20분','어려움',230,89,1,'public','2026-06-16 12:24:06',NULL,98,0),(99,'초간단 커틀릿/튀김 레시피','/no_image','15분','쉬움',43,75,1,'public','2026-06-16 12:24:06',NULL,99,0),(100,'맛있는 커틀릿/튀김 레시피','/no_image','10분','보통',264,36,1,'public','2026-06-16 12:24:06',NULL,100,0),(101,'매콤한 스프/스튜 레시피','/no_image','30분','어려움',122,12,1,'public','2026-06-16 12:24:06',NULL,101,0),(102,'특제 스프/스튜 레시피','/no_image','20분','쉬움',445,7,1,'public','2026-06-16 12:24:06',NULL,102,0),(103,'초간단 스프/스튜 레시피','/no_image','15분','보통',361,37,1,'public','2026-06-16 12:24:06',NULL,103,0),(104,'맛있는 스프/스튜 레시피','/no_image','10분','어려움',364,50,1,'public','2026-06-16 12:24:06',NULL,104,0),(105,'매콤한 그라탕/오븐요리 레시피','/no_image','30분','쉬움',161,10,1,'public','2026-06-16 12:24:06',NULL,105,0),(106,'특제 그라탕/오븐요리 레시피','/no_image','20분','보통',286,54,1,'public','2026-06-16 12:24:06',NULL,106,0),(107,'초간단 그라탕/오븐요리 레시피','/no_image','15분','어려움',493,31,1,'public','2026-06-16 12:24:06',NULL,107,0),(108,'맛있는 그라탕/오븐요리 레시피','/no_image','10분','쉬움',306,11,1,'public','2026-06-16 12:24:06',NULL,108,0),(109,'매콤한 오일/팬요리 레시피','/no_image','30분','보통',376,40,1,'public','2026-06-16 12:24:06',NULL,109,0),(110,'특제 오일/팬요리 레시피','/no_image','20분','어려움',394,71,1,'public','2026-06-16 12:24:06',NULL,110,0),(111,'초간단 오일/팬요리 레시피','/no_image','15분','쉬움',113,97,1,'public','2026-06-16 12:24:06',NULL,111,0),(112,'맛있는 오일/팬요리 레시피','/no_image','10분','보통',94,2,1,'public','2026-06-16 12:24:06',NULL,112,0),(113,'매콤한 브런치 레시피','/no_image','30분','어려움',272,66,1,'public','2026-06-16 12:24:06',NULL,113,0),(114,'특제 브런치 레시피','/no_image','20분','쉬움',338,39,1,'public','2026-06-16 12:24:06',NULL,114,0),(115,'초간단 브런치 레시피','/no_image','15분','보통',467,49,1,'public','2026-06-16 12:24:06',NULL,115,0),(116,'맛있는 브런치 레시피','/no_image','10분','어려움',338,89,1,'public','2026-06-16 12:24:06',NULL,116,0),(117,'울면 레시피','/no_image','30분','쉬움',223,54,1,'public','2026-06-16 12:24:06',NULL,117,0),(118,'우동 레시피','/no_image','20분','보통',196,32,1,'public','2026-06-16 12:24:06',NULL,118,0),(119,'짬뽕 레시피','/no_image','15분','어려움',232,33,1,'public','2026-06-16 12:24:06',NULL,119,0),(120,'짜장면 레시피','/no_image','10분','쉬움',136,36,1,'public','2026-06-16 12:24:06',NULL,120,0),(121,'매콤한 중식밥 레시피','/no_image','30분','보통',3,94,1,'public','2026-06-16 12:24:06',NULL,121,0),(122,'특제 중식밥 레시피','/no_image','20분','어려움',347,64,1,'public','2026-06-16 12:24:06',NULL,122,0),(123,'초간단 중식밥 레시피','/no_image','15분','쉬움',75,81,1,'public','2026-06-16 12:24:06',NULL,123,0),(124,'맛있는 중식밥 레시피','/no_image','10분','보통',300,57,1,'public','2026-06-16 12:24:06',NULL,124,0),(125,'유린기 레시피','/no_image','30분','어려움',33,60,1,'public','2026-06-16 12:24:06',NULL,125,0),(126,'깐풍기 레시피','/no_image','20분','쉬움',423,40,1,'public','2026-06-16 12:24:06',NULL,126,0),(127,'꿔바로우 레시피','/no_image','15분','보통',242,21,1,'public','2026-06-16 12:24:06',NULL,127,0),(128,'탕수육 레시피','/no_image','10분','어려움',299,36,1,'public','2026-06-16 12:24:06',NULL,128,0),(129,'매콤한 해물튀김 레시피','/no_image','30분','쉬움',15,5,1,'public','2026-06-16 12:24:06',NULL,129,0),(130,'특제 해물튀김 레시피','/no_image','20분','보통',86,70,1,'public','2026-06-16 12:24:06',NULL,130,0),(131,'초간단 해물튀김 레시피','Crispy_Fried_Calamari.jpg','15분','어려움',499,88,1,'public','2026-06-16 12:24:06',NULL,131,0),(132,'맛있는 해물튀김 레시피','Crispy_Fried_Calamari.jpg','10분','쉬움',209,44,1,'public','2026-06-16 12:24:06',NULL,132,0),(133,'매콤한 볶음요리 레시피','/no_image','30분','보통',480,47,1,'public','2026-06-16 12:24:06',NULL,133,0),(134,'특제 볶음요리 레시피','/no_image','20분','어려움',245,3,1,'public','2026-06-16 12:24:06',NULL,134,0),(135,'초간단 볶음요리 레시피','/no_image','15분','쉬움',347,37,1,'public','2026-06-16 12:24:06',NULL,135,0),(136,'맛있는 볶음요리 레시피','/no_image','10분','보통',386,75,1,'public','2026-06-16 12:24:06',NULL,136,0),(137,'매콤한 탕/스프 레시피','/no_image','30분','어려움',220,94,1,'public','2026-06-16 12:24:06',NULL,137,0),(138,'특제 탕/스프 레시피','/no_image','20분','쉬움',201,17,1,'public','2026-06-16 12:24:06',NULL,138,0),(139,'초간단 탕/스프 레시피','/no_image','15분','보통',339,86,1,'public','2026-06-16 12:24:06',NULL,139,0),(140,'맛있는 탕/스프 레시피','/no_image','10분','어려움',149,89,1,'public','2026-06-16 12:24:06',NULL,140,0),(141,'매콤한 만두/딤섬 레시피','/no_image','30분','쉬움',284,16,1,'public','2026-06-16 12:24:06',NULL,141,0),(142,'특제 만두/딤섬 레시피','/no_image','20분','보통',55,6,1,'public','2026-06-16 12:24:06',NULL,142,0),(143,'초간단 만두/딤섬 레시피','/no_image','15분','어려움',488,70,1,'public','2026-06-16 12:24:06',NULL,143,0),(144,'맛있는 만두/딤섬 레시피','/no_image','10분','쉬움',285,75,1,'public','2026-06-16 12:24:06',NULL,144,0),(145,'매콤한 냉채 레시피','/no_image','30분','보통',34,7,1,'public','2026-06-16 12:24:06',NULL,145,0),(146,'특제 냉채 레시피','/no_image','20분','어려움',81,59,1,'public','2026-06-16 12:24:06',NULL,146,0),(147,'초간단 냉채 레시피','/no_image','15분','쉬움',238,60,1,'public','2026-06-16 12:24:06',NULL,147,0),(148,'맛있는 냉채 레시피','/no_image','10분','보통',290,9,1,'public','2026-06-16 12:24:06',NULL,148,0),(149,'매콤한 두부/채소 레시피','/no_image','30분','어려움',372,43,1,'public','2026-06-16 12:24:06',NULL,149,0),(150,'특제 두부/채소 레시피','/no_image','20분','쉬움',473,42,1,'public','2026-06-16 12:24:06',NULL,150,0),(151,'초간단 두부/채소 레시피','/no_image','15분','보통',146,17,1,'public','2026-06-16 12:24:06',NULL,151,0),(152,'맛있는 두부/채소 레시피','/no_image','10분','어려움',11,57,1,'public','2026-06-16 12:24:06',NULL,152,0),(153,'매콤한 마라/퓨전 레시피','/no_image','30분','쉬움',402,30,1,'public','2026-06-16 12:24:06',NULL,153,0),(154,'특제 마라/퓨전 레시피','/no_image','20분','보통',53,62,1,'public','2026-06-16 12:24:06',NULL,154,0),(155,'초간단 마라/퓨전 레시피','/no_image','15분','어려움',391,4,1,'public','2026-06-16 12:24:06',NULL,155,0),(156,'맛있는 마라/퓨전 레시피','/no_image','10분','쉬움',449,35,1,'public','2026-06-16 12:24:06',NULL,156,0),(157,'새우초밥 레시피','/no_image','30분','보통',27,22,1,'public','2026-06-16 12:24:06',NULL,157,0),(158,'계란초밥 레시피','/no_image','20분','어려움',473,6,1,'public','2026-06-16 12:24:06',NULL,158,0),(159,'광어초밥 레시피','/no_image','15분','쉬움',239,20,1,'public','2026-06-16 12:24:06',NULL,159,0),(160,'연어초밥 레시피','/no_image','10분','보통',299,37,1,'public','2026-06-16 12:24:06',NULL,160,0),(161,'텐동 레시피','/no_image','30분','어려움',28,17,1,'public','2026-06-16 12:24:06',NULL,161,0),(162,'사케동 레시피','/no_image','20분','쉬움',348,96,1,'public','2026-06-16 12:24:06',NULL,162,0),(163,'규동 레시피','/no_image','15분','보통',357,69,1,'public','2026-06-16 12:24:06',NULL,163,0),(164,'가츠동 레시피','/no_image','10분','어려움',157,50,1,'public','2026-06-16 12:24:06',NULL,164,0),(165,'매콤한 우동/소바 레시피','/no_image','30분','쉬움',280,30,1,'public','2026-06-16 12:24:06',NULL,165,0),(166,'특제 우동/소바 레시피','/no_image','20분','보통',409,19,1,'public','2026-06-16 12:24:06',NULL,166,0),(167,'초간단 우동/소바 레시피','/no_image','15분','어려움',249,92,1,'public','2026-06-16 12:24:06',NULL,167,0),(168,'맛있는 우동/소바 레시피','/no_image','10분','쉬움',57,80,1,'public','2026-06-16 12:24:06',NULL,168,0),(169,'탄탄멘 레시피','/no_image','30분','보통',349,6,1,'public','2026-06-16 12:24:06',NULL,169,0),(170,'쇼유라멘 레시피','/no_image','20분','어려움',114,94,1,'public','2026-06-16 12:24:06',NULL,170,0),(171,'미소라멘 레시피','/no_image','15분','쉬움',31,46,1,'public','2026-06-16 12:24:06',NULL,171,0),(172,'돈코츠라멘 레시피','/no_image','10분','보통',67,27,1,'public','2026-06-16 12:24:06',NULL,172,0),(173,'매콤한 카레 레시피','/no_image','30분','어려움',493,10,1,'public','2026-06-16 12:24:06',NULL,173,0),(174,'특제 카레 레시피','/no_image','20분','쉬움',278,47,1,'public','2026-06-16 12:24:06',NULL,174,0),(175,'초간단 카레 레시피','/no_image','15분','보통',347,5,1,'public','2026-06-16 12:24:06',NULL,175,0),(176,'맛있는 카레 레시피','/no_image','10분','어려움',87,72,1,'public','2026-06-16 12:24:06',NULL,176,0),(177,'매콤한 돈카츠/튀김 레시피','/no_image','30분','쉬움',46,29,1,'public','2026-06-16 12:24:06',NULL,177,0),(178,'특제 돈카츠/튀김 레시피','/no_image','20분','보통',87,0,1,'public','2026-06-16 12:24:06',NULL,178,0),(179,'초간단 돈카츠/튀김 레시피','/no_image','15분','어려움',240,40,1,'public','2026-06-16 12:24:06',NULL,179,0),(180,'맛있는 돈카츠/튀김 레시피','/no_image','10분','쉬움',291,69,1,'public','2026-06-16 12:24:06',NULL,180,0),(181,'매콤한 구이요리 레시피','/no_image','30분','보통',365,57,1,'public','2026-06-16 12:24:06',NULL,181,0),(182,'특제 구이요리 레시피','/no_image','20분','어려움',330,59,1,'public','2026-06-16 12:24:06',NULL,182,0),(183,'초간단 구이요리 레시피','/no_image','15분','쉬움',487,10,1,'public','2026-06-16 12:24:06',NULL,183,0),(184,'맛있는 구이요리 레시피','/no_image','10분','보통',290,60,1,'public','2026-06-16 12:24:06',NULL,184,0),(185,'매콤한 나베/전골 레시피','/no_image','30분','어려움',129,49,1,'public','2026-06-16 12:24:06',NULL,185,0),(186,'특제 나베/전골 레시피','/no_image','20분','쉬움',338,91,1,'public','2026-06-16 12:24:06',NULL,186,0),(187,'초간단 나베/전골 레시피','/no_image','15분','보통',270,95,1,'public','2026-06-16 12:24:06',NULL,187,0),(188,'맛있는 나베/전골 레시피','/no_image','10분','어려움',86,98,1,'public','2026-06-16 12:24:06',NULL,188,0),(189,'매콤한 철판요리 레시피','/no_image','30분','쉬움',204,8,1,'public','2026-06-16 12:24:06',NULL,189,0),(190,'특제 철판요리 레시피','/no_image','20분','보통',103,77,1,'public','2026-06-16 12:24:06',NULL,190,0),(191,'초간단 철판요리 레시피','/no_image','15분','어려움',135,2,1,'public','2026-06-16 12:24:06',NULL,191,0),(192,'맛있는 철판요리 레시피','/no_image','10분','쉬움',147,40,1,'public','2026-06-16 12:24:06',NULL,192,0),(193,'매콤한 일식가정식 레시피','/no_image','30분','보통',75,53,1,'public','2026-06-16 12:24:06',NULL,193,0),(194,'특제 일식가정식 레시피','/no_image','20분','어려움',113,52,1,'public','2026-06-16 12:24:06',NULL,194,0),(195,'초간단 일식가정식 레시피','/no_image','15분','쉬움',469,12,1,'public','2026-06-16 12:24:06',NULL,195,0),(196,'맛있는 일식가정식 레시피','/no_image','10분','보통',398,61,1,'public','2026-06-16 12:24:06',NULL,196,0),(197,'분보후에 레시피','/no_image','30분','어려움',343,58,1,'public','2026-06-16 12:24:06',NULL,197,0),(198,'똠얌쌀국수 레시피','/no_image','20분','쉬움',438,62,1,'public','2026-06-16 12:24:06',NULL,198,0),(199,'해물쌀국수 레시피','/no_image','15분','보통',250,62,1,'public','2026-06-16 12:24:06',NULL,199,0),(200,'양지쌀국수 레시피','/no_image','10분','어려움',304,17,1,'public','2026-06-16 12:24:06',NULL,200,0),(201,'매콤한 아시안밥 레시피','/no_image','30분','쉬움',34,81,1,'public','2026-06-16 12:24:06',NULL,201,0),(202,'특제 아시안밥 레시피','/no_image','20분','보통',420,77,1,'public','2026-06-16 12:24:06',NULL,202,0),(203,'초간단 아시안밥 레시피','/no_image','15분','어려움',176,43,1,'public','2026-06-16 12:24:06',NULL,203,0),(204,'맛있는 아시안밥 레시피','/no_image','10분','쉬움',64,33,1,'public','2026-06-16 12:24:06',NULL,204,0),(205,'마사만커리 레시피','/no_image','30분','보통',143,43,1,'public','2026-06-16 12:24:06',NULL,205,0),(206,'레드커리 레시피','/no_image','20분','어려움',149,19,1,'public','2026-06-16 12:24:06',NULL,206,0),(207,'그린커리 레시피','/no_image','15분','쉬움',42,84,1,'public','2026-06-16 12:24:06',NULL,207,0),(208,'푸팟퐁커리 레시피','/no_image','10분','보통',471,19,1,'public','2026-06-16 12:24:06',NULL,208,0),(209,'매콤한 스프/탕 레시피','/no_image','30분','어려움',80,20,1,'public','2026-06-16 12:24:06',NULL,209,0),(210,'특제 스프/탕 레시피','/no_image','20분','쉬움',275,13,1,'public','2026-06-16 12:24:06',NULL,210,0),(211,'초간단 스프/탕 레시피','/no_image','15분','보통',8,68,1,'public','2026-06-16 12:24:06',NULL,211,0),(212,'맛있는 스프/탕 레시피','/no_image','10분','어려움',179,75,1,'public','2026-06-16 12:24:06',NULL,212,0),(213,'매콤한 고기요리 레시피','/no_image','30분','쉬움',342,16,1,'public','2026-06-16 12:24:06',NULL,213,0),(214,'특제 고기요리 레시피','/no_image','20분','보통',381,32,1,'public','2026-06-16 12:24:06',NULL,214,0),(215,'초간단 고기요리 레시피','/no_image','15분','어려움',168,71,1,'public','2026-06-16 12:24:06',NULL,215,0),(216,'맛있는 고기요리 레시피','/no_image','10분','쉬움',272,58,1,'public','2026-06-16 12:24:06',NULL,216,0),(217,'매콤한 해물요리 레시피','/no_image','30분','보통',151,75,1,'public','2026-06-16 12:24:06',NULL,217,0),(218,'특제 해물요리 레시피','/no_image','20분','어려움',438,11,1,'public','2026-06-16 12:24:06',NULL,218,0),(219,'초간단 해물요리 레시피','/no_image','15분','쉬움',462,28,1,'public','2026-06-16 12:24:06',NULL,219,0),(220,'맛있는 해물요리 레시피','/no_image','10분','보통',333,47,1,'public','2026-06-16 12:24:06',NULL,220,0),(221,'매콤한 볶음요리 레시피','/no_image','30분','어려움',177,36,1,'public','2026-06-16 12:24:06',NULL,221,0),(222,'특제 볶음요리 레시피','/no_image','20분','쉬움',379,69,1,'public','2026-06-16 12:24:06',NULL,222,0),(223,'초간단 볶음요리 레시피','/no_image','15분','보통',109,99,1,'public','2026-06-16 12:24:06',NULL,223,0),(224,'맛있는 볶음요리 레시피','/no_image','10분','어려움',163,64,1,'public','2026-06-16 12:24:06',NULL,224,0),(225,'매콤한 사이드/튀김 레시피','/no_image','30분','쉬움',119,26,1,'public','2026-06-16 12:24:06',NULL,225,0),(226,'특제 사이드/튀김 레시피','/no_image','20분','보통',302,22,1,'public','2026-06-16 12:24:06',NULL,226,0),(227,'초간단 사이드/튀김 레시피','/no_image','15분','어려움',166,97,1,'public','2026-06-16 12:24:06',NULL,227,0),(228,'맛있는 사이드/튀김 레시피','/no_image','10분','쉬움',446,53,1,'public','2026-06-16 12:24:06',NULL,228,0),(229,'매콤한 아시안쌈 레시피','/no_image','30분','보통',488,28,1,'public','2026-06-16 12:24:06',NULL,229,0),(230,'특제 아시안쌈 레시피','/no_image','20분','어려움',259,72,1,'public','2026-06-16 12:24:06',NULL,230,0),(231,'초간단 아시안쌈 레시피','/no_image','15분','쉬움',29,12,1,'public','2026-06-16 12:24:06',NULL,231,0),(232,'맛있는 아시안쌈 레시피','/no_image','10분','보통',221,84,1,'public','2026-06-16 12:24:06',NULL,232,0),(233,'매콤한 모닝글로리 레시피','/no_image','30분','어려움',454,0,1,'public','2026-06-16 12:24:06',NULL,233,0),(234,'특제 모닝글로리 레시피','/no_image','20분','쉬움',146,45,1,'public','2026-06-16 12:24:06',NULL,234,0),(235,'초간단 모닝글로리 레시피','/no_image','15분','보통',197,60,1,'private','2026-06-16 12:24:06',NULL,235,0),(236,'맛있는 모닝글로리 레시피','/no_image','10분','어려움',422,41,1,'public','2026-06-16 12:24:06',NULL,236,0),(237,'딸기요거트샐러드 레시피','strawberry_yogurt','5~10분','쉬움',258,35,1,'public','2026-06-16 12:24:06',NULL,237,0),(238,'연어샐러드 레시피','salmon_salad.jpg','20분','보통',109,3,1,'public','2026-06-16 12:24:06',NULL,238,0),(239,'닭가슴살샐러드 레시피','/no_image','15분','어려움',259,48,1,'public','2026-06-16 12:24:06',NULL,239,0),(240,'리코타치즈샐러드 레시피','/no_image','10분','쉬움',439,93,1,'public','2026-06-16 12:24:06',NULL,240,0),(241,'매콤한 포케/웜볼 레시피','/no_image','30분','보통',8,29,1,'public','2026-06-16 12:24:06',NULL,241,0),(242,'특제 포케/웜볼 레시피','/no_image','20분','어려움',206,18,1,'public','2026-06-16 12:24:06',NULL,242,0),(243,'초간단 포케/웜볼 레시피','/no_image','15분','쉬움',354,97,1,'public','2026-06-16 12:24:06',NULL,243,0),(244,'맛있는 포케/웜볼 레시피','/no_image','10분','보통',366,75,1,'public','2026-06-16 12:24:06',NULL,244,0),(245,'매콤한 닭가슴살 레시피','/no_image','30분','어려움',285,58,1,'public','2026-06-16 12:24:06',NULL,245,0),(246,'특제 닭가슴살 레시피','/no_image','20분','쉬움',118,41,1,'public','2026-06-16 12:24:06',NULL,246,0),(247,'초간단 닭가슴살 레시피','/no_image','15분','보통',189,64,1,'public','2026-06-16 12:24:06',NULL,247,0),(248,'맛있는 닭가슴살 레시피','/no_image','10분','어려움',37,44,1,'public','2026-06-16 12:24:06',NULL,248,0),(249,'매콤한 두부/묵 레시피','/no_image','30분','쉬움',0,67,1,'public','2026-06-16 12:24:06',NULL,249,0),(250,'특제 두부/묵 레시피','/no_image','20분','보통',175,74,1,'public','2026-06-16 12:24:06',NULL,250,0),(251,'초간단 두부/묵 레시피','/no_image','15분','어려움',325,3,1,'public','2026-06-16 12:24:06',NULL,251,0),(252,'맛있는 두부/묵 레시피','/no_image','10분','쉬움',100,91,1,'public','2026-06-16 12:24:06',NULL,252,0),(253,'매콤한 계란요리 레시피','/no_image','30분','보통',475,2,1,'public','2026-06-16 12:24:06',NULL,253,0),(254,'특제 계란요리 레시피','/no_image','20분','어려움',130,23,1,'public','2026-06-16 12:24:06',NULL,254,0),(255,'초간단 계란요리 레시피','/no_image','15분','쉬움',201,30,1,'public','2026-06-16 12:24:06',NULL,255,0),(256,'맛있는 계란요리 레시피','/no_image','10분','보통',156,65,1,'public','2026-06-16 12:24:06',NULL,256,0),(257,'매콤한 식단밥/죽 레시피','/no_image','30분','어려움',162,66,1,'public','2026-06-16 12:24:06',NULL,257,0),(258,'특제 식단밥/죽 레시피','/no_image','20분','쉬움',170,71,1,'public','2026-06-16 12:24:06',NULL,258,0),(259,'초간단 식단밥/죽 레시피','/no_image','15분','보통',282,67,1,'public','2026-06-16 12:24:06',NULL,259,0),(260,'맛있는 식단밥/죽 레시피','/no_image','10분','어려움',332,30,1,'public','2026-06-16 12:24:06',NULL,260,0),(261,'매콤한 샌드위치/랩 레시피','/no_image','30분','쉬움',272,79,1,'public','2026-06-16 12:24:06',NULL,261,0),(262,'특제 샌드위치/랩 레시피','/no_image','20분','보통',177,38,1,'public','2026-06-16 12:24:06',NULL,262,0),(263,'초간단 샌드위치/랩 레시피','/no_image','15분','어려움',429,13,1,'public','2026-06-16 12:24:06',NULL,263,0),(264,'맛있는 샌드위치/랩 레시피','/no_image','10분','쉬움',59,17,1,'public','2026-06-16 12:24:06',NULL,264,0),(265,'매콤한 야채/찜요리 레시피','/no_image','30분','보통',268,14,1,'public','2026-06-16 12:24:06',NULL,265,0),(266,'특제 야채/찜요리 레시피','/no_image','20분','어려움',56,12,1,'public','2026-06-16 12:24:06',NULL,266,0),(267,'초간단 야채/찜요리 레시피','/no_image','15분','쉬움',155,16,1,'public','2026-06-16 12:24:06',NULL,267,0),(268,'맛있는 야채/찜요리 레시피','/no_image','10분','보통',451,1,1,'public','2026-06-16 12:24:06',NULL,268,0),(269,'매콤한 생선/해산물 레시피','/no_image','30분','어려움',172,69,1,'public','2026-06-16 12:24:06',NULL,269,0),(270,'특제 생선/해산물 레시피','/no_image','20분','쉬움',212,5,1,'public','2026-06-16 12:24:06',NULL,270,0),(271,'초간단 생선/해산물 레시피','/no_image','15분','보통',495,78,1,'public','2026-06-16 12:24:06',NULL,271,0),(272,'맛있는 생선/해산물 레시피','/no_image','10분','어려움',489,52,1,'public','2026-06-16 12:24:06',NULL,272,0),(273,'매콤한 주스/스무디 레시피','/no_image','30분','쉬움',346,88,1,'public','2026-06-16 12:24:06',NULL,273,0),(274,'특제 주스/스무디 레시피','/no_image','20분','보통',177,11,1,'public','2026-06-16 12:24:06',NULL,274,0),(275,'초간단 주스/스무디 레시피','/no_image','15분','어려움',261,26,1,'public','2026-06-16 12:24:06',NULL,275,0),(276,'맛있는 주스/스무디 레시피','/no_image','10분','쉬움',372,93,1,'public','2026-06-16 12:24:06',NULL,276,0),(277,'원팬스테이크 레시피','/no_image','30분','보통',222,41,1,'public','2026-06-16 12:24:06',NULL,277,0),(278,'원팟리조또 레시피','/no_image','20분','어려움',376,51,1,'public','2026-06-16 12:24:06',NULL,278,0),(279,'원팬토스트 레시피','/no_image','15분','쉬움',149,96,1,'public','2026-06-16 12:24:06',NULL,279,0),(280,'원팬파스타 레시피','/no_image','10분','보통',458,69,1,'public','2026-06-16 12:24:06',NULL,280,0),(281,'매콤한 전자레인지 레시피','/no_image','30분','어려움',360,52,1,'public','2026-06-16 12:24:06',NULL,281,0),(282,'특제 전자레인지 레시피','/no_image','20분','쉬움',232,74,1,'public','2026-06-16 12:24:06',NULL,282,0),(283,'초간단 전자레인지 레시피','/no_image','15분','보통',165,42,1,'public','2026-06-16 12:24:06',NULL,283,0),(284,'맛있는 전자레인지 레시피','/no_image','10분','어려움',60,33,1,'public','2026-06-16 12:24:06',NULL,284,0),(285,'매콤한 에어프라이어 레시피','/no_image','30분','쉬움',149,49,1,'public','2026-06-16 12:24:06',NULL,285,0),(286,'특제 에어프라이어 레시피','/no_image','20분','보통',290,41,1,'public','2026-06-16 12:24:06',NULL,286,0),(287,'초간단 에어프라이어 레시피','/no_image','15분','어려움',174,49,1,'public','2026-06-16 12:24:06',NULL,287,0),(288,'맛있는 에어프라이어 레시피','/no_image','10분','쉬움',202,55,1,'public','2026-06-16 12:24:06',NULL,288,0),(289,'매콤한 5분토스트 레시피','/no_image','30분','보통',272,7,1,'public','2026-06-16 12:24:06',NULL,289,0),(290,'특제 5분토스트 레시피','/no_image','20분','어려움',362,41,1,'public','2026-06-16 12:24:06',NULL,290,0),(291,'초간단 5분토스트 레시피','/no_image','15분','쉬움',437,14,1,'public','2026-06-16 12:24:06',NULL,291,0),(292,'맛있는 5분토스트 레시피','/no_image','10분','보통',50,6,1,'public','2026-06-16 12:24:06',NULL,292,0),(293,'매콤한 한그릇밥 레시피','/no_image','30분','어려움',19,99,1,'public','2026-06-16 12:24:06',NULL,293,0),(294,'특제 한그릇밥 레시피','/no_image','20분','쉬움',425,27,1,'public','2026-06-16 12:24:06',NULL,294,0),(295,'초간단 한그릇밥 레시피','/no_image','15분','보통',403,21,1,'public','2026-06-16 12:24:06',NULL,295,0),(296,'맛있는 한그릇밥 레시피','/no_image','10분','어려움',338,72,1,'public','2026-06-16 12:24:06',NULL,296,0),(297,'콩국수 레시피','kongguksu.png','20분','쉬움',300,82,1,'public','2026-06-16 12:24:06',NULL,297,0),(298,'특제 간단면식 레시피','/no_image','20분','보통',159,12,1,'public','2026-06-16 12:24:06',NULL,298,0),(299,'초간단 간단면식 레시피','/no_image','15분','어려움',326,89,1,'public','2026-06-16 12:24:06',NULL,299,0),(300,'맛있는 간단면식 레시피','/no_image','10분','쉬움',262,93,1,'public','2026-06-16 12:24:06',NULL,300,0),(301,'매콤한 비빔/무침 레시피','/no_image','30분','보통',47,67,1,'public','2026-06-16 12:24:06',NULL,301,0),(302,'특제 비빔/무침 레시피','/no_image','20분','어려움',34,33,1,'public','2026-06-16 12:24:06',NULL,302,0),(303,'초간단 비빔/무침 레시피','/no_image','15분','쉬움',239,38,1,'public','2026-06-16 12:24:06',NULL,303,0),(304,'맛있는 비빔/무침 레시피','/no_image','10분','보통',242,26,1,'public','2026-06-16 12:24:06',NULL,304,0),(305,'매콤한 밀키트/시판 레시피','/no_image','30분','어려움',441,61,1,'public','2026-06-16 12:24:06',NULL,305,0),(306,'특제 밀키트/시판 레시피','/no_image','20분','쉬움',207,23,1,'public','2026-06-16 12:24:06',NULL,306,0),(307,'초간단 밀키트/시판 레시피','/no_image','15분','보통',475,3,1,'public','2026-06-16 12:24:06',NULL,307,0),(308,'맛있는 밀키트/시판 레시피','/no_image','10분','어려움',170,58,1,'public','2026-06-16 12:24:06',NULL,308,0),(309,'매콤한 노오븐디저트 레시피','/no_image','30분','쉬움',452,76,1,'public','2026-06-16 12:24:06',NULL,309,0),(310,'특제 노오븐디저트 레시피','/no_image','20분','보통',64,34,1,'public','2026-06-16 12:24:06',NULL,310,0),(311,'초간단 노오븐디저트 레시피','/no_image','15분','어려움',160,57,1,'public','2026-06-16 12:24:06',NULL,311,0),(312,'맛있는 노오븐디저트 레시피','/no_image','10분','쉬움',464,90,1,'public','2026-06-16 12:24:06',NULL,312,0),(313,'매콤한 남은재료처리 레시피','/no_image','30분','보통',376,3,1,'public','2026-06-16 12:24:06',NULL,313,0),(314,'특제 남은재료처리 레시피','/no_image','20분','어려움',469,57,1,'public','2026-06-16 12:24:06',NULL,314,0),(315,'초간단 남은재료처리 레시피','/no_image','15분','쉬움',30,58,1,'public','2026-06-16 12:24:06',NULL,315,0),(316,'맛있는 남은재료처리 레시피','/no_image','10분','보통',361,87,1,'public','2026-06-16 12:24:06',NULL,316,0),(317,'매콤한 젤리/푸딩 레시피','/no_image','30분','어려움',96,34,1,'public','2026-06-16 12:24:06',NULL,317,0),(318,'특제 젤리/푸딩 레시피','/no_image','20분','쉬움',68,65,1,'public','2026-06-16 12:24:06',NULL,318,0),(319,'초간단 젤리/푸딩 레시피','/no_image','15분','보통',442,44,1,'public','2026-06-16 12:24:06',NULL,319,0),(320,'맛있는 젤리/푸딩 레시피','/no_image','10분','어려움',288,54,1,'public','2026-06-16 12:24:06',NULL,320,0),(321,'녹차빙수 레시피','/no_image','30분','쉬움',7,42,1,'public','2026-06-16 12:24:06',NULL,321,0),(322,'딸기빙수 레시피','/no_image','20분','보통',48,19,1,'public','2026-06-16 12:24:06',NULL,322,0),(323,'망고빙수 레시피','/no_image','15분','어려움',353,93,1,'public','2026-06-16 12:24:06',NULL,323,0),(324,'팥빙수 레시피','/no_image','10분','쉬움',273,93,1,'public','2026-06-16 12:24:06',NULL,324,0),(325,'매콤한 과일간식 레시피','/no_image','30분','보통',24,42,1,'public','2026-06-16 12:24:06',NULL,325,0),(326,'특제 과일간식 레시피','fruit_anju.jpg','20분','어려움',499,70,1,'public','2026-06-16 12:24:06',NULL,326,0),(327,'초간단 과일간식 레시피','/no_image','15분','쉬움',270,58,1,'public','2026-06-16 12:24:06',NULL,327,0),(328,'맛있는 과일간식 레시피','/no_image','10분','보통',147,72,1,'public','2026-06-16 12:24:06',NULL,328,0),(329,'매콤한 떡/한과 레시피','/no_image','30분','어려움',371,53,1,'public','2026-06-16 12:24:06',NULL,329,0),(330,'특제 떡/한과 레시피','/no_image','20분','쉬움',228,67,1,'public','2026-06-16 12:24:06',NULL,330,0),(331,'초간단 떡/한과 레시피','/no_image','15분','보통',493,91,1,'public','2026-06-16 12:24:06',NULL,331,0),(332,'맛있는 떡/한과 레시피','/no_image','10분','어려움',316,41,1,'public','2026-06-16 12:24:06',NULL,332,0),(333,'매콤한 초콜릿/사탕 레시피','/no_image','30분','쉬움',79,55,1,'public','2026-06-16 12:24:06',NULL,333,0),(334,'특제 초콜릿/사탕 레시피','/no_image','20분','보통',153,86,1,'public','2026-06-16 12:24:06',NULL,334,0),(335,'초간단 초콜릿/사탕 레시피','/no_image','15분','어려움',212,51,1,'public','2026-06-16 12:24:06',NULL,335,0),(336,'맛있는 초콜릿/사탕 레시피','/no_image','10분','쉬움',153,98,1,'public','2026-06-16 12:24:06',NULL,336,0),(337,'매콤한 노오븐디저트 레시피','/no_image','30분','보통',1,5,1,'public','2026-06-16 12:24:06',NULL,337,0),(338,'특제 노오븐디저트 레시피','/no_image','20분','어려움',139,22,1,'public','2026-06-16 12:24:06',NULL,338,0),(339,'초간단 노오븐디저트 레시피','/no_image','15분','쉬움',145,77,1,'public','2026-06-16 12:24:06',NULL,339,0),(340,'맛있는 노오븐디저트 레시피','/no_image','10분','보통',0,68,1,'public','2026-06-16 12:24:06',NULL,340,0),(341,'복숭아요거트 레시피','peach_yogurt.png','5~10분','쉬움',200,96,1,'public','2026-06-16 12:24:06',NULL,341,0),(342,'특제 요거트 레시피','/no_image','20분','쉬움',303,14,1,'public','2026-06-16 12:24:06',NULL,342,0),(343,'초간단 요거트 레시피','/no_image','15분','보통',455,11,1,'public','2026-06-16 12:24:06',NULL,343,0),(344,'맛있는 요거트 레시피','/no_image','10분','어려움',428,92,1,'public','2026-06-16 12:24:06',NULL,344,0),(345,'매콤한 샌드/영양바 레시피','/no_image','30분','쉬움',32,54,1,'public','2026-06-16 12:24:06',NULL,345,0),(346,'특제 샌드/영양바 레시피','/no_image','20분','보통',264,0,1,'public','2026-06-16 12:24:06',NULL,346,0),(347,'초간단 샌드/영양바 레시피','/no_image','15분','어려움',224,22,1,'public','2026-06-16 12:24:06',NULL,347,0),(348,'맛있는 샌드/영양바 레시피','/no_image','10분','쉬움',384,17,1,'public','2026-06-16 12:24:06',NULL,348,0),(349,'매콤한 튀김간식 레시피','/no_image','30분','보통',279,27,1,'public','2026-06-16 12:24:06',NULL,349,0),(350,'특제 튀김간식 레시피','/no_image','20분','어려움',353,70,1,'public','2026-06-16 12:24:06',NULL,350,0),(351,'초간단 튀김간식 레시피','/no_image','15분','쉬움',205,93,1,'public','2026-06-16 12:24:06',NULL,351,0),(352,'맛있는 튀김간식 레시피','/no_image','10분','보통',213,33,1,'public','2026-06-16 12:24:06',NULL,352,0),(353,'매콤한 구황작물 레시피','/no_image','30분','어려움',207,5,1,'public','2026-06-16 12:24:06',NULL,353,0),(354,'특제 구황작물 레시피','/no_image','20분','쉬움',17,0,1,'public','2026-06-16 12:24:06',NULL,354,0),(355,'초간단 구황작물 레시피','/no_image','15분','보통',468,66,1,'public','2026-06-16 12:24:06',NULL,355,0),(356,'맛있는 구황작물 레시피','/no_image','10분','어려움',249,50,1,'public','2026-06-16 12:24:06',NULL,356,0),(357,'매콤한 식빵/모닝빵 레시피','/no_image','30분','쉬움',15,63,1,'public','2026-06-16 12:24:06',NULL,357,0),(358,'특제 식빵/모닝빵 레시피','/no_image','20분','보통',42,52,1,'public','2026-06-16 12:24:06',NULL,358,0),(359,'초간단 식빵/모닝빵 레시피','/no_image','15분','어려움',181,23,1,'public','2026-06-16 12:24:06',NULL,359,0),(360,'맛있는 식빵/모닝빵 레시피','/no_image','10분','쉬움',53,82,1,'public','2026-06-16 12:24:06',NULL,360,0),(361,'매콤한 쿠키 레시피','/no_image','30분','보통',391,44,1,'public','2026-06-16 12:24:06',NULL,361,0),(362,'특제 쿠키 레시피','/no_image','20분','어려움',446,11,1,'public','2026-06-16 12:24:06',NULL,362,0),(363,'초간단 쿠키 레시피','/no_image','15분','쉬움',455,20,1,'public','2026-06-16 12:24:06',NULL,363,0),(364,'맛있는 쿠키 레시피','/no_image','10분','보통',143,82,1,'public','2026-06-16 12:24:06',NULL,364,0),(365,'당근케이크 레시피','/no_image','30분','어려움',129,82,1,'public','2026-06-16 12:24:06',NULL,365,0),(366,'치즈케이크 레시피','/no_image','20분','쉬움',168,22,1,'public','2026-06-16 12:24:06',NULL,366,0),(367,'초코케이크 레시피','/no_image','15분','보통',43,77,1,'public','2026-06-16 12:24:06',NULL,367,0),(368,'생크림케이크 레시피','/no_image','10분','어려움',302,70,1,'public','2026-06-16 12:24:06',NULL,368,0),(369,'매콤한 타르트/파이 레시피','/no_image','30분','쉬움',351,40,1,'public','2026-06-16 12:24:06',NULL,369,0),(370,'특제 타르트/파이 레시피','/no_image','20분','보통',457,36,1,'public','2026-06-16 12:24:06',NULL,370,0),(371,'초간단 타르트/파이 레시피','/no_image','15분','어려움',31,23,1,'public','2026-06-16 12:24:06',NULL,371,0),(372,'맛있는 타르트/파이 레시피','/no_image','10분','쉬움',485,15,1,'public','2026-06-16 12:24:06',NULL,372,0),(373,'매콤한 머핀/컵케이크 레시피','/no_image','30분','보통',439,91,1,'public','2026-06-16 12:24:06',NULL,373,0),(374,'특제 머핀/컵케이크 레시피','/no_image','20분','어려움',478,2,1,'public','2026-06-16 12:24:06',NULL,374,0),(375,'초간단 머핀/컵케이크 레시피','/no_image','15분','쉬움',137,28,1,'public','2026-06-16 12:24:06',NULL,375,0),(376,'맛있는 머핀/컵케이크 레시피','/no_image','10분','보통',298,13,1,'public','2026-06-16 12:24:06',NULL,376,0),(377,'매콤한 구움과자 레시피','/no_image','30분','어려움',438,98,1,'public','2026-06-16 12:24:06',NULL,377,0),(378,'특제 구움과자 레시피','/no_image','20분','쉬움',151,55,1,'public','2026-06-16 12:24:06',NULL,378,0),(379,'초간단 구움과자 레시피','/no_image','15분','보통',423,58,1,'public','2026-06-16 12:24:06',NULL,379,0),(380,'맛있는 구움과자 레시피','/no_image','10분','어려움',186,12,1,'public','2026-06-16 12:24:06',NULL,380,0),(381,'매콤한 와플/팬케이크 레시피','/no_image','30분','쉬움',239,3,1,'public','2026-06-16 12:24:06',NULL,381,0),(382,'특제 와플/팬케이크 레시피','/no_image','20분','보통',371,60,1,'public','2026-06-16 12:24:06',NULL,382,0),(383,'초간단 와플/팬케이크 레시피','/no_image','15분','어려움',393,12,1,'public','2026-06-16 12:24:06',NULL,383,0),(384,'맛있는 와플/팬케이크 레시피','/no_image','10분','쉬움',130,93,1,'public','2026-06-16 12:24:06',NULL,384,0),(385,'매콤한 비건베이킹 레시피','/no_image','30분','보통',436,56,1,'public','2026-06-16 12:24:06',NULL,385,0),(386,'특제 비건베이킹 레시피','/no_image','20분','어려움',114,44,1,'public','2026-06-16 12:24:06',NULL,386,0),(387,'초간단 비건베이킹 레시피','/no_image','15분','쉬움',259,26,1,'public','2026-06-16 12:24:06',NULL,387,0),(388,'맛있는 비건베이킹 레시피','/no_image','10분','보통',393,12,1,'public','2026-06-16 12:24:06',NULL,388,0),(389,'매콤한 패스트리 레시피','/no_image','30분','어려움',135,97,1,'public','2026-06-16 12:24:06',NULL,389,0),(390,'특제 패스트리 레시피','/no_image','20분','쉬움',27,35,1,'public','2026-06-16 12:24:06',NULL,390,0),(391,'초간단 패스트리 레시피','/no_image','15분','보통',299,93,1,'public','2026-06-16 12:24:06',NULL,391,0),(392,'맛있는 패스트리 레시피','/no_image','10분','어려움',448,67,1,'public','2026-06-16 12:24:06',NULL,392,0),(393,'매콤한 핑거푸드 레시피','/no_image','30분','쉬움',330,29,1,'public','2026-06-16 12:24:06',NULL,393,0),(394,'특제 핑거푸드 레시피','/no_image','20분','보통',246,58,1,'public','2026-06-16 12:24:06',NULL,394,0),(395,'초간단 핑거푸드 레시피','/no_image','15분','어려움',211,37,1,'public','2026-06-16 12:24:06',NULL,395,0),(396,'맛있는 핑거푸드 레시피','/no_image','10분','쉬움',292,81,1,'public','2026-06-16 12:24:06',NULL,396,0),(397,'콜드브루 레시피','/no_image','30분','보통',159,14,1,'public','2026-06-16 12:24:06',NULL,397,0),(398,'바닐라라떼 레시피','/no_image','20분','어려움',396,51,1,'public','2026-06-16 12:24:06',NULL,398,0),(399,'카페라떼 레시피','/no_image','15분','쉬움',90,37,1,'public','2026-06-16 12:24:06',NULL,399,0),(400,'아메리카노 레시피','/no_image','10분','보통',159,47,1,'public','2026-06-16 12:24:06',NULL,400,0),(401,'매콤한 에이드 레시피','/no_image','30분','어려움',208,66,1,'public','2026-06-16 12:24:06',NULL,401,0),(402,'특제 에이드 레시피','/no_image','20분','쉬움',30,31,1,'public','2026-06-16 12:24:06',NULL,402,0),(403,'초간단 에이드 레시피','/no_image','15분','보통',200,5,1,'public','2026-06-16 12:24:06',NULL,403,0),(404,'맛있는 에이드 레시피','/no_image','10분','어려움',41,24,1,'public','2026-06-16 12:24:06',NULL,404,0),(405,'매콤한 과일주스 레시피','/no_image','30분','쉬움',482,9,1,'public','2026-06-16 12:24:06',NULL,405,0),(406,'특제 과일주스 레시피','/no_image','20분','보통',287,59,1,'public','2026-06-16 12:24:06',NULL,406,0),(407,'초간단 과일주스 레시피','/no_image','15분','어려움',121,43,1,'public','2026-06-16 12:24:06',NULL,407,0),(408,'맛있는 과일주스 레시피','/no_image','10분','쉬움',213,84,1,'public','2026-06-16 12:24:06',NULL,408,0),(409,'매콤한 전통차 레시피','/no_image','30분','보통',470,17,1,'public','2026-06-16 12:24:06',NULL,409,0),(410,'특제 전통차 레시피','/no_image','20분','어려움',25,72,1,'public','2026-06-16 12:24:06',NULL,410,0),(411,'초간단 전통차 레시피','/no_image','15분','쉬움',240,22,1,'public','2026-06-16 12:24:06',NULL,411,0),(412,'맛있는 전통차 레시피','/no_image','10분','보통',339,72,1,'public','2026-06-16 12:24:06',NULL,412,0),(413,'매콤한 허브티/홍차 레시피','/no_image','30분','어려움',294,76,1,'public','2026-06-16 12:24:06',NULL,413,0),(414,'특제 허브티/홍차 레시피','/no_image','20분','쉬움',33,3,1,'public','2026-06-16 12:24:06',NULL,414,0),(415,'초간단 허브티/홍차 레시피','/no_image','15분','보통',485,74,1,'public','2026-06-16 12:24:06',NULL,415,0),(416,'맛있는 허브티/홍차 레시피','/no_image','10분','어려움',416,91,1,'public','2026-06-16 12:24:06',NULL,416,0),(417,'매콤한 라떼/밀크 레시피','/no_image','30분','쉬움',39,64,1,'public','2026-06-16 12:24:06',NULL,417,0),(418,'특제 라떼/밀크 레시피','latte_is_horse.jpg','20분','보통',497,3,1,'public','2026-06-16 12:24:06',NULL,418,0),(419,'초간단 라떼/밀크 레시피','/no_image','15분','어려움',100,89,1,'public','2026-06-16 12:24:06',NULL,419,0),(420,'맛있는 라떼/밀크 레시피','/no_image','10분','쉬움',439,70,1,'public','2026-06-16 12:24:06',NULL,420,0),(421,'매콤한 무알코올 레시피','/no_image','30분','보통',433,23,1,'public','2026-06-16 12:24:06',NULL,421,0),(422,'특제 무알코올 레시피','/no_image','20분','어려움',281,11,1,'public','2026-06-16 12:24:06',NULL,422,0),(423,'초간단 무알코올 레시피','/no_image','15분','쉬움',449,14,1,'public','2026-06-16 12:24:06',NULL,423,0),(424,'맛있는 무알코올 레시피','/no_image','10분','보통',8,65,1,'public','2026-06-16 12:24:06',NULL,424,0),(425,'매콤한 홈술/칵테일 레시피','/no_image','30분','어려움',116,19,1,'public','2026-06-16 12:24:06',NULL,425,0),(426,'특제 홈술/칵테일 레시피','/no_image','20분','쉬움',139,80,1,'public','2026-06-16 12:24:06',NULL,426,0),(427,'초간단 홈술/칵테일 레시피','/no_image','15분','보통',96,54,1,'public','2026-06-16 12:24:06',NULL,427,0),(428,'맛있는 홈술/칵테일 레시피','/no_image','10분','어려움',82,17,1,'public','2026-06-16 12:24:06',NULL,428,0),(429,'매콤한 해독/건강차 레시피','/no_image','30분','쉬움',198,45,1,'public','2026-06-16 12:24:06',NULL,429,0),(430,'특제 해독/건강차 레시피','/no_image','20분','보통',30,95,1,'public','2026-06-16 12:24:06',NULL,430,1),(431,'초간단 해독/건강차 레시피','/no_image','15분','어려움',285,0,1,'public','2026-06-16 12:24:06',NULL,431,0),(432,'맛있는 해독/건강차 레시피','/no_image','10분','쉬움',148,48,1,'public','2026-06-16 12:24:06',NULL,432,1),(433,'매콤한 수제청 레시피','/no_image','30분','보통',255,11,1,'public','2026-06-16 12:24:06',NULL,433,0),(434,'특제 수제청 레시피','/no_image','20분','어려움',10,76,1,'public','2026-06-16 12:24:06',NULL,434,0),(435,'초간단 수제청 레시피','/no_image','15분','쉬움',394,63,1,'public','2026-06-16 12:24:06',NULL,435,1),(436,'맛있는 수제청 레시피','/no_image','10분','보통',405,14,1,'public','2026-06-16 12:24:06',NULL,436,0);
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_comment`
--

DROP TABLE IF EXISTS `recipe_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT,
  `recipe_id` bigint NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT '0',
  `member_id` bigint DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `recipe_id` (`recipe_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `recipe_comment_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`),
  CONSTRAINT `recipe_comment_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_comment`
--

LOCK TABLES `recipe_comment` WRITE;
/*!40000 ALTER TABLE `recipe_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `recipe_view`
--

DROP TABLE IF EXISTS `recipe_view`;
/*!50001 DROP VIEW IF EXISTS `recipe_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `recipe_view` AS SELECT 
 1 AS `recipe_id`,
 1 AS `title`,
 1 AS `thumbnail`,
 1 AS `cooking_time`,
 1 AS `difficulty`,
 1 AS `view_count`,
 1 AS `like_count`,
 1 AS `status`,
 1 AS `created_date`,
 1 AS `updated_date`,
 1 AS `food_id`,
 1 AS `recommend`,
 1 AS `member_id`,
 1 AS `nickname`,
 1 AS `rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `report_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `target_type` varchar(20) NOT NULL,
  `board_id` bigint DEFAULT NULL,
  `reason` varchar(100) NOT NULL,
  `detail` text,
  `status` varchar(20) DEFAULT NULL,
  `admin_id` bigint DEFAULT NULL,
  `admin_memo` text,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `processed_date` datetime DEFAULT NULL,
  `comment_id` bigint DEFAULT NULL,
  `recipe_id` bigint DEFAULT NULL,
  `report_count` int DEFAULT '0',
  `reported_count` int DEFAULT '0',
  `report_title` varchar(50) DEFAULT NULL,
  `review_id` bigint DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `fk_report_member` (`member_id`),
  KEY `fk_report_board` (`board_id`),
  KEY `fk_report_admin` (`admin_id`),
  KEY `report_comment_FK` (`comment_id`),
  KEY `report_recipe_FK` (`recipe_id`),
  KEY `report_review_FK` (`review_id`),
  CONSTRAINT `fk_report_admin` FOREIGN KEY (`admin_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_report_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`),
  CONSTRAINT `fk_report_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `report_comment_FK` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `report_recipe_FK` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `report_review_FK` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,1,'게시글',1,'광고성 글','댓글 유도 링크가 포함되어 있어 신고합니다.','처리완료',1,'해당 링크 확인 후 게시글 정상 판단하여 기각 처리함.','2026-05-29 10:12:59',NULL,NULL,NULL,0,0,NULL,NULL);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` bigint NOT NULL AUTO_INCREMENT,
  `recipe_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `rating` decimal(3,1) NOT NULL DEFAULT '0.0',
  `view_count` int NOT NULL DEFAULT '0',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `fk_review_recipe` (`recipe_id`),
  KEY `fk_review_member` (`member_id`),
  CONSTRAINT `fk_review_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,1,'참치비빔밥 레시피 후기','집에 있는 참치캔으로 간단하게 만들었는데 생각보다 훨씬 맛있네요. 다음에도 또 해먹을 예정입니다.','review_1.jpg',4.8,191,'ACTIVE','2026-06-20 09:12:00',NULL),(2,2,1,'김치볶음밥 레시피 후기','매콤한 김치와 밥의 조합이 최고였습니다. 계란후라이까지 올리니 완벽하네요.','review_2.jpg',4.5,87,'ACTIVE','2026-06-20 10:20:00',NULL),(3,3,1,'스팸마요덮밥 레시피 후기','재료도 간단하고 조리시간도 짧아서 자취생에게 딱입니다.','review_3.jpg',5.0,230,'ACTIVE','2026-06-20 11:30:00',NULL),(4,4,1,'간장계란밥 레시피 후기','아침에 빠르게 만들어 먹기 좋았습니다. 간장 비율이 딱 좋네요.','review_4.jpg',4.6,154,'ACTIVE','2026-06-20 13:15:00',NULL),(5,7,1,'감바스 레시피 후기','새우가 탱글탱글하고 빵이랑 먹으니 정말 맛있었어요.','review_5.jpg',4.9,278,'ACTIVE','2026-06-20 15:10:00',NULL),(6,37,1,'순두부찌개 레시피 후기','국물이 얼큰해서 밥 한 공기 순식간에 비웠습니다.','review_6.jpg',4.7,120,'ACTIVE','2026-06-20 16:40:00',NULL),(7,38,1,'부대찌개 레시피 후기','햄과 소시지가 푸짐하게 들어가서 가족들이 좋아했습니다.','review_7.jpg',4.8,203,'ACTIVE','2026-06-21 09:20:00',NULL),(8,39,1,'된장찌개 레시피 후기','구수한 맛이 살아있고 집밥 느낌이 제대로 납니다.','review_8.jpg',4.4,95,'ACTIVE','2026-06-21 10:50:00',NULL),(9,40,1,'김치찌개 레시피 후기','칼칼하고 시원한 국물 맛이 좋았습니다.','review_9.jpg',4.9,312,'ACTIVE','2026-06-21 12:10:00',NULL),(10,44,1,'제육볶음 레시피 후기','매콤달콤해서 밥도둑이네요. 가족들도 만족했습니다.','review_10.jpg',5.0,267,'ACTIVE','2026-06-21 14:00:00',NULL),(11,56,1,'비빔밥 레시피 후기','나물 조합이 좋아서 건강하게 한 끼 해결했습니다.','review_11.jpg',4.6,134,'ACTIVE','2026-06-21 15:30:00',NULL),(12,66,1,'소불고기 레시피 후기','양념 비율이 좋아서 고기가 정말 부드러웠습니다.','review_12.jpg',4.8,176,'ACTIVE','2026-06-21 17:20:00',NULL),(13,68,1,'삼겹살구이 레시피 후기','겉바속촉으로 잘 구워졌어요. 가족들과 맛있게 먹었습니다.','review_13.jpg',4.7,111,'ACTIVE','2026-06-22 09:40:00',NULL),(14,77,1,'로제파스타 레시피 후기','크림과 토마토 소스의 조화가 정말 좋네요.','review_14.jpg',4.9,289,'ACTIVE','2026-06-22 11:00:00',NULL),(15,79,1,'까르보나라 레시피 후기','생각보다 어렵지 않았고 맛도 전문점 수준이었습니다.','review_15.jpg',4.8,198,'ACTIVE','2026-06-22 12:30:00',NULL),(16,80,1,'알리오올리오 레시피 후기','재료가 간단한데도 맛이 훌륭했습니다.','review_16.jpg',4.3,77,'ACTIVE','2026-06-22 13:50:00',NULL),(17,82,1,'페퍼로니피자 레시피 후기','짭짤한 페퍼로니가 매력적이네요.','review_17.jpg',4.7,143,'ACTIVE','2026-06-22 15:00:00',NULL),(18,86,1,'티본스테이크 레시피 후기','고기 굽는 시간까지 자세히 나와 있어서 좋았습니다.','review_18.jpg',5.0,356,'ACTIVE','2026-06-22 16:30:00',NULL),(19,94,1,'특제 샌드위치/버거 레시피 후기','아이들이 정말 좋아했습니다. 주말 메뉴로 추천합니다.','review_19.jpg',4.5,109,'ACTIVE','2026-06-22 18:00:00',NULL),(20,100,1,'맛있는 커틀릿/튀김 레시피 후기','겉은 바삭하고 속은 촉촉해서 만족스러웠습니다.','review_20.jpg',4.8,184,'ACTIVE','2026-06-23 09:00:00',NULL),(21,208,3,'이거 진짜','안녕하세요','1782808630250_no_file.png',0.0,0,'ACTIVE','2026-06-30 08:37:10','2026-06-30 08:37:10'),(22,326,3,'이거 진짜 맛있음','아라라라랄','1782808792618_no_file.png',4.0,0,'ACTIVE','2026-06-30 08:39:52','2026-06-30 08:39:52');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_log`
--

DROP TABLE IF EXISTS `search_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_log` (
  `search_id` bigint NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`search_id`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_log`
--

LOCK TABLES `search_log` WRITE;
/*!40000 ALTER TABLE `search_log` DISABLE KEYS */;
INSERT INTO `search_log` VALUES (90,'치킨','2026-06-15 12:32:44'),(91,'피자','2026-06-15 12:32:47'),(92,'햄버거','2026-06-15 12:32:49'),(93,'올리브영','2026-06-15 12:32:51'),(94,'다이소','2026-06-15 12:32:53'),(95,'시장','2026-06-15 12:32:54'),(96,'올리브','2026-06-15 12:32:56'),(97,'후라이드치킨','2026-06-15 12:33:01'),(98,'삼겹살','2026-06-15 12:33:04'),(99,'소주','2026-06-15 12:33:06'),(100,'위스키','2026-06-15 12:33:10'),(101,'양념','2026-06-15 12:33:12'),(102,'양념치킨','2026-06-15 12:33:14'),(103,'된장찌개','2026-06-15 12:33:18'),(104,'김치찌개','2026-06-15 12:33:21'),(105,'clzls','2026-06-15 12:33:29'),(106,'치킨','2026-06-15 12:33:31'),(107,'후라이드치킨','2026-06-15 12:33:35'),(108,'양념치킨','2026-06-15 12:33:37'),(109,'된장찌개','2026-06-15 12:33:41'),(110,'피자','2026-06-15 12:33:45'),(111,'위스크','2026-06-15 12:34:15'),(112,'위스키','2026-06-15 12:34:18'),(113,'위스키','2026-06-15 12:34:30'),(114,'파스타','2026-06-15 12:34:32'),(115,'로제파스타','2026-06-15 12:34:35'),(116,'치킨','2026-06-15 12:34:37'),(117,'피자','2026-06-15 12:34:39'),(118,'햄버거','2026-06-15 12:34:40'),(119,'돈까스','2026-06-15 12:34:44'),(120,'치즈돈까스','2026-06-15 12:34:50'),(121,'치킨','2026-06-15 12:35:05'),(122,'올리브영','2026-06-15 12:35:08'),(123,'올리브','2026-06-15 12:35:10'),(124,'다이소','2026-06-15 12:35:12'),(125,'올리브','2026-06-15 12:38:02'),(126,'올리브','2026-06-15 12:38:09'),(127,'올리브','2026-06-15 12:39:43'),(128,'위스키','2026-06-15 12:39:46'),(129,'피자','2026-06-15 12:39:48'),(130,'피자','2026-06-17 11:37:46'),(131,'치킨','2026-06-17 11:56:23'),(132,'햄버거','2026-06-17 12:07:36'),(133,'올리브','2026-06-17 12:08:49'),(134,'양갈비','2026-06-17 12:41:32'),(135,'김치','2026-06-17 12:43:19'),(136,'치킨','2026-06-17 12:43:33'),(137,'그팸','2026-06-17 15:43:35'),(138,'스팸','2026-06-17 15:43:37'),(139,'스팸','2026-06-17 15:44:38'),(140,'감바스','2026-06-17 15:48:55'),(141,'스팸','2026-06-17 15:49:21'),(142,'스팸','2026-06-17 15:51:20'),(143,'스팸','2026-06-17 15:54:24'),(144,'스팸마요','2026-06-17 16:08:00'),(145,'tmvoa','2026-06-17 17:34:12'),(146,'스팸','2026-06-17 17:34:16'),(147,'간장','2026-06-17 17:37:50'),(148,'tmvoa','2026-06-18 09:19:48'),(149,'스팸','2026-06-18 09:19:50'),(150,'간장계란밥','2026-06-18 09:31:30'),(151,'감바스','2026-06-18 09:31:49'),(152,'치킨','2026-06-18 10:20:41'),(153,'스팸','2026-06-18 10:20:50'),(154,'스팸','2026-06-18 10:24:31'),(155,'스팸','2026-06-18 10:49:28'),(159,'스팸','2026-06-18 12:49:24'),(161,'tmvoia','2026-06-18 14:04:39'),(162,'스팸','2026-06-18 14:04:45'),(163,'스팸','2026-06-18 14:10:18'),(164,'스팸','2026-06-18 14:15:25'),(165,'스팸','2026-06-18 14:21:31'),(169,'스팸','2026-06-18 14:51:13'),(170,'간장계란밥','2026-06-18 14:58:10'),(171,'간장계란밥','2026-06-18 14:59:08'),(172,'간장계란밥','2026-06-18 15:00:29'),(173,'간장계란밥','2026-06-18 15:00:30'),(174,'간장계란밥','2026-06-18 15:01:27'),(175,'스팸','2026-06-18 15:01:29'),(176,'간장계란밥','2026-06-18 15:02:53'),(177,'스팸','2026-06-18 15:02:56'),(178,'','2026-06-18 15:03:00'),(179,'스팸','2026-06-18 16:52:27'),(180,'매콤한','2026-06-18 17:25:42'),(181,' 스팸','2026-06-18 17:26:04'),(182,'찌개','2026-06-23 23:47:37'),(183,'','2026-06-23 23:47:40'),(184,'음...','2026-06-23 23:47:57'),(185,'돼지','2026-06-23 23:51:31'),(186,'청','2026-06-23 23:51:36'),(187,'덮밥','2026-06-23 23:51:44'),(188,'아라라랄','2026-06-23 23:52:11'),(189,'아라랄','2026-06-23 23:52:13'),(190,'아라','2026-06-23 23:52:16'),(191,'','2026-06-24 00:18:52'),(192,'찌개','2026-06-25 09:44:49'),(193,'양양','2026-06-29 10:12:18'),(194,'에이메스','2026-06-29 10:17:24'),(195,'에미','2026-06-29 10:17:37'),(196,'에이메','2026-06-29 10:25:54'),(197,'테스트','2026-06-29 10:27:19'),(198,'에이','2026-06-29 14:07:13'),(199,'테스트','2026-06-29 14:11:48'),(200,'에이메스','2026-06-30 08:49:23'),(201,'푸팟퐁','2026-06-30 09:40:30'),(202,'스무디','2026-06-30 09:42:13'),(203,'푸팟퐁','2026-06-30 10:26:37'),(204,'참치','2026-06-30 14:28:50'),(205,'참치','2026-06-30 14:31:03'),(206,'참치','2026-06-30 14:31:48'),(207,'참치','2026-06-30 22:09:13'),(208,'찌개','2026-06-30 22:09:19'),(209,'초간단 구이요리','2026-06-30 22:10:51'),(210,'똠얌쌀국수','2026-06-30 23:15:56'),(211,'복숭아','2026-07-01 12:30:24'),(212,'버섯','2026-07-01 12:30:42'),(213,'전어','2026-07-01 12:30:54'),(214,'배숙성','2026-07-01 12:31:06'),(215,'매생이','2026-07-01 12:31:18'),(216,'무','2026-07-01 12:31:28'),(217,'과멕;','2026-07-01 12:31:39'),(218,'과메','2026-07-01 12:31:42');
/*!40000 ALTER TABLE `search_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seasons`
--

DROP TABLE IF EXISTS `seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seasons` (
  `season_id` int NOT NULL AUTO_INCREMENT,
  `season_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '봄, 여름, 가을, 겨울',
  `banner_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '배너 메인 타이틀',
  `banner_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '배너 서브 설명',
  `food_id` bigint NOT NULL COMMENT '음식 ID (food 테이블 참조)',
  `sub_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '음식 한 줄 설명',
  `custom_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'no_image' COMMENT '관련 음식 이미지',
  PRIMARY KEY (`season_id`),
  KEY `fk_seasons_food` (`food_id`) USING BTREE,
  CONSTRAINT `seasons_food_FK` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seasons`
--

LOCK TABLES `seasons` WRITE;
/*!40000 ALTER TABLE `seasons` DISABLE KEYS */;
INSERT INTO `seasons` VALUES (1,'봄','산뜻하게 시작하는 봄 제철요리','향긋한 채소와 가벼운 식감이 살아 있는 봄 메뉴를 모았습니다.',1,'향긋한 봄나물로 입맛을 살리는 한 끼','dalrae.png'),(2,'봄','산뜻하게 시작하는 봄 제철요리','향긋한 채소와 가벼운 식감이 살아 있는 봄 메뉴를 모았습니다.',40,'부드럽고 구수한 집밥 국물 메뉴','naengi.png'),(3,'봄','산뜻하게 시작하는 봄 제철요리','향긋한 채소와 가벼운 식감이 살아 있는 봄 메뉴를 모았습니다.',237,'가볍고 상큼한 브런치 스타일','strawberry_yogurt.png'),(4,'여름','시원하고 가볍게 즐기는 여름 제철요리','더운 날씨에도 부담 없이 먹기 좋은 산뜻한 레시피입니다.',39,'짧은 시간에 완성하는 대표 여름 반찬','cucumber.png'),(5,'여름','시원하고 가볍게 즐기는 여름 제철요리','더운 날씨에도 부담 없이 먹기 좋은 산뜻한 레시피입니다.',297,'고소함과 시원함이 가득한 여름 한 끼','kongguksu.png'),(6,'여름','시원하고 가볍게 즐기는 여름 제철요리','더운 날씨에도 부담 없이 먹기 좋은 산뜻한 레시피입니다.',341,'상큼한 과일 풍미를 살린 간단 디저트','peach_yogurt.png'),(7,'가을','풍미를 깊게 즐기는 가을 제철요리','버섯과 뿌리채소의 고소한 맛을 살린 든든한 메뉴입니다.',89,'부드럽고 진한 가을 감성 한 그릇','mushroom_risotto.png'),(8,'가을','풍미를 깊게 즐기는 가을 제철요리','버섯과 뿌리채소의 고소한 맛을 살린 든든한 메뉴입니다.',68,'가을에 가장 맛있는 전어의 고소한 풍미를 담은 메뉴','gizzard.png'),(9,'가을','풍미를 깊게 즐기는 가을 제철요리','버섯과 뿌리채소의 고소한 맛을 살린 든든한 메뉴입니다.',67,'가을 과일의 단맛을 살린 메인 요리','pear_bulgogi.png'),(10,'겨울','따뜻하고 진하게 즐기는 겨울 제철요리','포근한 국물과 묵직한 풍미가 잘 어울리는 계절 메뉴입니다.',38,'겨울 바다의 맛을 담은 국물 메뉴','maesaengi.png'),(11,'겨울','따뜻하고 진하게 즐기는 겨울 제철요리','포근한 국물과 묵직한 풍미가 잘 어울리는 계절 메뉴입니다.',37,'부드럽고 편안한 집밥 스타일','deulkkae.png'),(12,'겨울','따뜻하고 진하게 즐기는 겨울 제철요리','포근한 국물과 묵직한 풍미가 잘 어울리는 계절 메뉴입니다.',45,'매콤새콤하게 즐기는 겨울 별미','gwamegi.png');
/*!40000 ALTER TABLE `seasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_keyword_ranking`
--

DROP TABLE IF EXISTS `v_keyword_ranking`;
/*!50001 DROP VIEW IF EXISTS `v_keyword_ranking`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_keyword_ranking` AS SELECT 
 1 AS `keyword`,
 1 AS `search_count`,
 1 AS `elapsed_hours`,
 1 AS `score`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_member_activity`
--

DROP TABLE IF EXISTS `v_member_activity`;
/*!50001 DROP VIEW IF EXISTS `v_member_activity`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_member_activity` AS SELECT 
 1 AS `member_id`,
 1 AS `activity_type`,
 1 AS `target_id`,
 1 AS `activity_title`,
 1 AS `created_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `web_push_subscription`
--

DROP TABLE IF EXISTS `web_push_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_push_subscription` (
  `endpoint` varchar(500) NOT NULL,
  `member_id` bigint NOT NULL,
  `p256dh` varchar(200) NOT NULL,
  `auth` varchar(200) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`endpoint`),
  KEY `fk_subscription_member` (`member_id`),
  CONSTRAINT `fk_subscription_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_push_subscription`
--

LOCK TABLES `web_push_subscription` WRITE;
/*!40000 ALTER TABLE `web_push_subscription` DISABLE KEYS */;
INSERT INTO `web_push_subscription` VALUES ('https://fcm.googleapis.com/fcm/send/cUK3qttIy7Q:APA91bGyuHIYBTlQZLeDgyoPmLlC0Fm2SDbIlhmmuzldsZqdTE4W-HfUxOwwrQQdJxZyNaY3EruVDQV2k1m2Ui75jnZmAcBDohsGAueuni70enxJsS6ILQbgxw3s4byaeCSc-upgJxfa',3,'BDH8CrVBpuFQwsw7EqbjvlAXfsbAbVRDSOLeJVo2RsMz3biWvwxKI7DF2ject1iUowu_pEvRcPJFa304h2wWxr0','tdkcy6QbFfeFidNMpzL6Jg','2026-06-25 00:11:59'),('https://fcm.googleapis.com/fcm/send/fXZ8tA56fuI:APA91bEVW5Ojsm9lPIxD5bkBTntUOoVfYRsxIOMWNQmrqotEfHm_ePSGYPa9MjiZgAHqZ-77IrwYccxnwclM48VzKegYgHsQDufwLBfQ3FfQd0Q_UTjs09IvdFa9ZvK6ngpOwxox_qCK',2,'BEA-fGyWy6TkSAc-gZkuPqpX5tOb0h7mheHu59ZaaQGaxa5i9D4LCrubNPUD1FI44vVG7qvQUmVtrvs3bPftURE','kQw8pWYfAfmlnhw_5DI_vQ','2026-06-23 15:21:18');
/*!40000 ALTER TABLE `web_push_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cook'
--

--
-- Final view structure for view `recipe_view`
--

/*!50001 DROP VIEW IF EXISTS `recipe_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `recipe_view` AS select `r`.`recipe_id` AS `recipe_id`,`r`.`title` AS `title`,`r`.`thumbnail` AS `thumbnail`,`r`.`cooking_time` AS `cooking_time`,`r`.`difficulty` AS `difficulty`,`r`.`view_count` AS `view_count`,`r`.`like_count` AS `like_count`,`r`.`status` AS `status`,`r`.`created_date` AS `created_date`,`r`.`updated_date` AS `updated_date`,`r`.`food_id` AS `food_id`,`r`.`recommend` AS `recommend`,`r`.`member_id` AS `member_id`,`m`.`nickname` AS `nickname`,ifnull(`rc`.`avg_rating`,0) AS `rating` from ((`recipe` `r` join `member` `m` on((`r`.`member_id` = `m`.`member_id`))) left join (select `comment`.`recipe_id` AS `recipe_id`,round(avg(`comment`.`rating`),1) AS `avg_rating` from `comment` group by `comment`.`recipe_id`) `rc` on((`r`.`recipe_id` = `rc`.`recipe_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_keyword_ranking`
--

/*!50001 DROP VIEW IF EXISTS `v_keyword_ranking`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_keyword_ranking` AS select `search_log`.`keyword` AS `keyword`,count(`search_log`.`search_id`) AS `search_count`,timestampdiff(HOUR,min(`search_log`.`created_at`),now()) AS `elapsed_hours`,(count(`search_log`.`search_id`) / pow((timestampdiff(HOUR,min(`search_log`.`created_at`),now()) + 2),1.8)) AS `score` from `search_log` where (`search_log`.`created_at` >= (now() - interval 3 day)) group by `search_log`.`keyword` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_member_activity`
--

/*!50001 DROP VIEW IF EXISTS `v_member_activity`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_member_activity` AS select `recipe`.`member_id` AS `member_id`,'RECIPE' AS `activity_type`,`recipe`.`recipe_id` AS `target_id`,`recipe`.`title` AS `activity_title`,`recipe`.`created_date` AS `created_date` from `recipe` union all select `comment`.`member_id` AS `member_id`,'COMMENT' AS `activity_type`,`comment`.`comment_id` AS `target_id`,`comment`.`content` AS `activity_title`,`comment`.`created_date` AS `created_date` from `comment` union all select `bookmark`.`member_id` AS `member_id`,'BOOKMARK' AS `activity_type`,`bookmark`.`recipe_id` AS `target_id`,'레시피를 북마크했습니다' AS `activity_title`,`bookmark`.`created_date` AS `created_date` from `bookmark` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-01 12:32:29
