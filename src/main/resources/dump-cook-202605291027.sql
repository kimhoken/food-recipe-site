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
  `status` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL,
  `recipe_id` bigint NOT NULL,
  `img_id` int DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  KEY `fk_board_member` (`member_id`),
  KEY `fk_board_recipe` (`recipe_id`),
  KEY `fk_board_img` (`img_id`),
  CONSTRAINT `fk_board_img` FOREIGN KEY (`img_id`) REFERENCES `img` (`img_id`),
  CONSTRAINT `fk_board_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_board_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'오늘 저녁으로 김치찌개 끓였는데 대성공입니다!','레시피 탭에 있는 대로 쌀뜨물 넣고 푹 끓였더니 깊은 맛이 예술이네요. 다들 꼭 해보세요!',35,'정상','2026-05-29 10:12:59',NULL,1,1),(2,1,'김치찌개 레시피 보고 따라 했는데 대성공이에요!','맨날 맛내기 실패했었는데 쌀뜨물 넣고 오래 끓이니까 진짜 깊은 맛 나네요 ㅠㅠ 감동입니다.',45,'정상','2026-05-29 10:12:59',NULL,1,1),(3,1,'오늘 저녁은 냉장고 털어서 만든 김치찌개랑 계란말이','재료 다 털어 넣고 한 냄비 끓였는데 밥 두 공기 순삭했습니다. 역시 이 레시피가 최고네요.',12,'정상','2026-05-29 10:12:59',NULL,1,1),(4,1,'초보 요리사분들 이 김치찌개는 꼭 필독하셔야 합니다','제가 요리 똥손인데도 맛이 납니다. 양념장 비율이 황금 비율이에요. 다들 두 번 해 드세요.',88,'정상','2026-05-29 10:12:59',NULL,1,1),(5,1,'남편이 먹어보고 파는 것보다 맛있대요 ㅋㅋ','칭찬 인색한 사람인데 국물 한 입 먹자마자 크어 소리 내면서 흡입하네요. 뿌듯합니다.',56,'정상','2026-05-29 10:12:59',NULL,1,1),(6,1,'자취생들에게 빛과 소금 같은 찌개 레시피 공유','재료 간단하고 20분이면 완성이라 퇴근하고 맨날 이것만 해 먹는 중입니다. 진짜 최고!',23,'정상','2026-05-29 10:12:59',NULL,1,1),(7,1,'집들이 음식으로 냈는데 인기 폭발이었습니다','거창한 요리보다 역시 한국인은 김치찌개인가 봐요. 다들 국물 비법이 뭐냐고 물어보네요.',104,'정상','2026-05-29 10:12:59',NULL,1,1),(8,1,'스팸이랑 두부 더 넣어서 끓여봤는데 더 맛있네요','기본 돼지고기 베이스에 스팸까지 으깨 넣으니까 부대찌개 느낌도 나고 국물이 걸쭉해요.',31,'정상','2026-05-29 10:12:59',NULL,1,1),(9,1,'이거 끓일 때 참기름에 고기 먼저 볶는 게 팁인가요?','레시피대로 고기 달달 볶다가 김치 넣으니까 잡내 하나도 안 나고 고소함이 장난 아닙니다.',67,'정상','2026-05-29 10:12:59',NULL,1,1),(10,1,'신김치가 신의 한 수네요. 진짜 맛있습니다.','마침 냉장고에 엄청 신 김치 있어서 처치 곤란이었는데 찌개로 끓이니까 완벽하게 해결됐어요.',19,'정상','2026-05-29 10:12:59',NULL,1,1),(11,1,'국물 요리 유목민이었는데 드디어 정착합니다','인터넷에 도는 레시피 다 따라 해봐도 밍밍했는데 이건 간이 딱 맞아요. 인생 레시피 등극!',150,'정상','2026-05-29 10:12:59',NULL,1,1);
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
  `recipe_id` bigint NOT NULL,
  `member_id` bigint NOT NULL,
  `content` text NOT NULL,
  `rating` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `fk_comment_recipe` (`recipe_id`),
  KEY `fk_comment_member` (`member_id`),
  CONSTRAINT `fk_comment_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_comment_recipe` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,'진짜 너무 맛있게 잘 먹었습니다! 요리 초보인데도 쉽게 따라했네요.',5,'정상','2026-05-29 10:12:59');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
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
INSERT INTO `fridge_item` VALUES (2,1,'돼지고기 앞다리살','300g','2026-06-05','2026-05-29 10:12:59',0),(3,1,'우유','1L','2026-06-05','2026-05-29 10:12:59',0),(4,1,'달걀','10알','2026-06-20','2026-05-29 10:12:59',0),(5,1,'두부','1모','2026-06-02','2026-05-29 10:12:59',0),(6,1,'체다 치즈','10장','2026-07-10','2026-05-29 10:12:59',0),(7,1,'양파','3개','2026-06-15','2026-05-29 10:12:59',0),(8,1,'당근','1개','2026-06-18','2026-05-29 10:12:59',0),(9,1,'배추김치','1포기','2026-09-30','2026-05-29 10:12:59',0),(10,1,'사과','5개','2026-06-25','2026-05-29 10:12:59',0),(11,1,'플레인 요거트','4개','2026-06-08','2026-05-29 10:12:59',0),(12,1,'대파','1단','2026-06-12','2026-05-29 10:12:59',0),(13,1,'콩나물','1봉지','2026-06-01','2026-05-29 10:12:59',0),(14,1,'팽이버섯','2봉지','2026-06-03','2026-05-29 10:12:59',0),(15,1,'다진 마늘','150g','2026-07-15','2026-05-29 10:12:59',0),(16,1,'슬라이스 햄','200g','2026-06-14','2026-05-29 10:12:59',0),(17,1,'베이컨','1팩','2026-06-10','2026-05-29 10:12:59',0),(18,1,'어묵','1봉지','2026-06-07','2026-05-29 10:12:59',0),(19,1,'방울토마토','500g','2026-06-09','2026-05-29 10:12:59',0),(20,1,'오이','2개','2026-06-11','2026-05-29 10:12:59',0),(21,1,'청양고추','1봉지','2026-06-20','2026-05-29 10:12:59',0),(22,1,'상추','100g','2026-06-02','2026-05-29 10:12:59',0),(23,1,'깻잎','30장','2026-06-03','2026-05-29 10:12:59',0),(24,1,'파프리카','2개','2026-06-14','2026-05-29 10:12:59',0),(25,1,'버터','200g','2026-08-22','2026-05-29 10:12:59',0),(26,1,'쌈장','500g','2026-11-30','2026-05-29 10:12:59',0),(27,1,'고추장','1kg','2027-05-15','2026-05-29 10:12:59',0),(28,1,'단무지','1팩','2026-07-01','2026-05-29 10:12:59',0),(29,1,'새송이버섯','1봉지','2026-06-06','2026-05-29 10:12:59',0),(30,1,'무','1/2개','2026-06-22','2026-05-29 10:12:59',0),(31,1,'생강','50g','2026-07-20','2026-05-29 10:12:59',0),(32,1,'양배추','1/4통','2026-06-17','2026-05-29 10:12:59',0),(33,1,'냉동 삼겹살','500g','2026-12-31','2026-05-29 10:12:59',1),(34,1,'냉동 만두','1봉지','2026-11-15','2026-05-29 10:12:59',1),(35,1,'냉동 블루베리','1kg','2027-05-20','2026-05-29 10:12:59',1),(36,1,'냉동 닭가슴살','1kg','2026-09-10','2026-05-29 10:12:59',1),(37,1,'피자 치즈','300g','2026-08-05','2026-05-29 10:12:59',1),(38,1,'냉동 새우','20마리','2026-12-01','2026-05-29 10:12:59',1),(39,1,'떡볶이 떡','500g','2026-07-14','2026-05-29 10:12:59',1),(40,1,'돈가스','4장','2026-11-30','2026-05-29 10:12:59',1),(41,1,'얼린 대파','1통','2026-08-20','2026-05-29 10:12:59',1),(42,1,'차돌박이','400g','2026-10-15','2026-05-29 10:12:59',1),(43,1,'냉동 다진 생강','100g','2026-12-25','2026-05-29 10:12:59',1),(44,1,'멸치 육수팩','10개','2027-03-10','2026-05-29 10:12:59',1),(45,1,'베이킹용 생크림','500ml','2026-08-11','2026-05-29 10:12:59',1),(46,1,'손질 고등어','2마리','2026-09-05','2026-05-29 10:12:59',1),(47,1,'오징어 링','300g','2026-11-04','2026-05-29 10:12:59',1),(48,1,'냉동 볶음밥','3봉지','2026-08-30','2026-05-29 10:12:59',1),(49,1,'해물 모둠','500g','2026-12-15','2026-05-29 10:12:59',1),(50,1,'우삼겹','600g','2026-10-22','2026-05-29 10:12:59',1),(51,1,'냉동 감자튀김','1kg','2027-02-18','2026-05-29 10:12:59',1),(52,1,'얼린 청양고추','1통','2026-09-12','2026-05-29 10:12:59',1),(53,1,'가래떡','1팩','2026-08-01','2026-05-29 10:12:59',1),(54,1,'바닐라 아이스크림','1L','2026-11-20','2026-05-29 10:12:59',1),(55,1,'냉동 딸기','1kg','2027-04-05','2026-05-29 10:12:59',1),(56,1,'치킨 너겟','500g','2026-10-09','2026-05-29 10:12:59',1),(57,1,'손질 갈치','3 토막','2026-08-14','2026-05-29 10:12:59',1),(58,1,'피자 도우','2장','2026-07-25','2026-05-29 10:12:59',1),(59,1,'냉동 콘옥수수','1kg','2027-01-30','2026-05-29 10:12:59',1),(60,1,'얼린 마늘 박스','200g','2026-11-11','2026-05-29 10:12:59',1),(61,1,'대패 삼겹살','1kg','2026-11-05','2026-05-29 10:12:59',1),(62,1,'떡갈비','5장','2026-09-22','2026-05-29 10:12:59',1);
/*!40000 ALTER TABLE `fridge_item` ENABLE KEYS */;
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
  PRIMARY KEY (`img_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img`
--

LOCK TABLES `img` WRITE;
/*!40000 ALTER TABLE `img` DISABLE KEYS */;
INSERT INTO `img` VALUES (1,'/images/recipe_kimchi_01.jpg'),(2,'/images/recipe_kimchi_01.jpg');
/*!40000 ALTER TABLE `img` ENABLE KEYS */;
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
  `answered_date` date DEFAULT NULL,
  `guest_name` varchar(50) DEFAULT NULL,
  `guest_email` varchar(100) DEFAULT NULL,
  `guest_password` varchar(255) DEFAULT NULL,
  `inquiry_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`inquiry_id`),
  UNIQUE KEY `inquiry_code` (`inquiry_code`),
  KEY `fk_inquiry_member` (`member_id`),
  KEY `fk_inquiry_admin` (`admin_id`),
  CONSTRAINT `fk_inquiry_admin` FOREIGN KEY (`admin_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_inquiry_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inquiry`
--

LOCK TABLES `inquiry` WRITE;
/*!40000 ALTER TABLE `inquiry` DISABLE KEYS */;
INSERT INTO `inquiry` VALUES (1,1,'탈퇴한 계정의 게시글 처리는 어떻게 되나요?','회원 탈퇴를 하게 되면 예전에 썼던 게시글들도 같이 지워지는지 궁금합니다.','답변완료','2026-05-29 10:12:59',1,'탈퇴 시 본인 게시글은 자동 삭제되지 않으니 미리 삭제 후 탈퇴 바랍니다.','2026-05-26',NULL,NULL,NULL,NULL);
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
  `login_id` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `report_count` int DEFAULT '0',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `profile_img` varchar(100) DEFAULT NULL,
  `login_type` varchar(20) DEFAULT 'LOCAL',
  `provider` varchar(20) DEFAULT NULL,
  `provider_id` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `login_id` (`login_id`),
  UNIQUE KEY `nickname` (`nickname`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'chef_gildong','$2a$10$WRBKSJUzg01GoAZFS8XYaeRqeeeSxOvJltS7Hbin56JLDKd6wz2W6','요리왕길동','gildong@example.com','User','Active',0,'2026-05-29 10:10:34','no_file','LOCAL',NULL,NULL,'홍길동');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (1,1,'[공지] 냉장고 파먹기 서비스 정기 점검 안내 (5/30)','더 안정적인 서비스 제공을 위해 정기 점검이 진행될 예정입니다. 점검 시간에는 서비스 이용이 제한됩니다.',250,'2026-05-29 10:12:59');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
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
INSERT INTO `nutrition` VALUES (1,'450kcal','15g','5g','25g','50g','800mg'),(2,'450kcal','15g','5g','25g','50g','800mg');
/*!40000 ALTER TABLE `nutrition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `recipe_id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `thumbnail` varchar(250) DEFAULT NULL,
  `cooking_time` int DEFAULT NULL,
  `difficulty` varchar(20) DEFAULT NULL,
  `nutrition_id` bigint NOT NULL,
  `view_count` int DEFAULT '0',
  `like_count` int DEFAULT '0',
  `status` varchar(20) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_date` datetime DEFAULT NULL,
  `ingredient` varchar(200) DEFAULT NULL,
  `img_id` int DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `fk_recipe_member` (`member_id`),
  KEY `fk_recipe_nutrition` (`nutrition_id`),
  KEY `fk_recipe_img` (`img_id`),
  CONSTRAINT `fk_recipe_img` FOREIGN KEY (`img_id`) REFERENCES `img` (`img_id`),
  CONSTRAINT `fk_recipe_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_recipe_nutrition` FOREIGN KEY (`nutrition_id`) REFERENCES `nutrition` (`nutrition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,1,'얼큰한 돼지고기 김치찌개','엄마가 해주던 그 맛 그대로, 밥 한 그릇 뚝딱 비우는 찌개입니다.','kimchi_thumb.jpg',25,'쉬움',1,120,45,'정상','2026-05-29 10:12:59',NULL,'신김치 1/4포기, 돼지고기 200g, 대파 1대, 두부 반모',1);
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

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
  `board_id` bigint NOT NULL,
  `reason` varchar(100) NOT NULL,
  `detail` text,
  `status` varchar(20) DEFAULT NULL,
  `admin_id` bigint DEFAULT NULL,
  `admin_memo` text,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `processed_date` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `fk_report_member` (`member_id`),
  KEY `fk_report_board` (`board_id`),
  KEY `fk_report_admin` (`admin_id`),
  CONSTRAINT `fk_report_admin` FOREIGN KEY (`admin_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `fk_report_board` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`),
  CONSTRAINT `fk_report_member` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
INSERT INTO `report` VALUES (1,1,'게시글',1,'광고성 글','댓글 유도 링크가 포함되어 있어 신고합니다.','처리완료',1,'해당 링크 확인 후 게시글 정상 판단하여 기각 처리함.','2026-05-29 10:12:59',NULL);
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40000 ALTER TABLE `web_push_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cook'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-29 10:27:09
