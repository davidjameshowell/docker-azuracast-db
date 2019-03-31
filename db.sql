/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `azuracast`;
USE `azuracast`;

ALTER DATABASE `azuracast` CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

DROP TABLE IF EXISTS `analytics`;
CREATE TABLE `analytics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) DEFAULT NULL,
  `type` varchar(15) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `number_min` int(11) NOT NULL,
  `number_max` int(11) NOT NULL,
  `number_avg` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EAC2E68821BDB235` (`station_id`),
  KEY `search_idx` (`type`,`timestamp`),
  CONSTRAINT `FK_EAC2E68821BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `api_keys`;
CREATE TABLE `api_keys` (
  `id` varchar(16) NOT NULL,
  `user_id` int(11) NOT NULL,
  `verifier` varchar(128) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9579321FA76ED395` (`user_id`),
  CONSTRAINT `FK_9579321FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `app_migrations`;
CREATE TABLE `app_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `app_migrations` WRITE;
INSERT INTO `app_migrations` VALUES ('20161003041904'),('20161006030903'),('20161007021719'),('20161007195027'),('20161117000718'),('20161117161959'),('20161120032434'),('20161122035237'),('20170412210654'),('20170414205418'),('20170423202805'),('20170424042111'),('20170502202418'),('20170510082607'),('20170510085226'),('20170510091820'),('20170512023527'),('20170512082741'),('20170512094523'),('20170516073708'),('20170516205418'),('20170516214120'),('20170516215536'),('20170518100549'),('20170522052114'),('20170524090814'),('20170606173152'),('20170618013019'),('20170619044014'),('20170619171323'),('20170622223025'),('20170719045113'),('20170803050109'),('20170823204230'),('20170829030442'),('20170906080352'),('20170917175534'),('20171022005913'),('20171103075821'),('20171104014701'),('20171124184831'),('20171128121012'),('20171208093239'),('20171214104226'),('20180203201032'),('20180203203751'),('20180203214656'),('20180204210633'),('20180206105454'),('20180211192448'),('20180320052444'),('20180320061801'),('20180320070100'),('20180320163622'),('20180320171318'),('20180324053351'),('20180412055024'),('20180415235105'),('20180417041534'),('20180425025237'),('20180425050351'),('20180428062526'),('20180429013130'),('20180506022642'),('20180608130900'),('20180716185805'),('20180818223558'),('20180826011103'),('20180826043500'),('20180830003036'),('20180909035413'),('20180909060758'),('20180909174026'),('20181016144143'),('20181025232600'),('20181120100629'),('20181126073334'),('20181202180617'),('20181211220707'),('20190124132556'),('20190128035353'),('20190314074747'),('20190314203550'),('20190315002523'),('20190324040155'),('20190326051220');
UNLOCK TABLES;

DROP TABLE IF EXISTS `custom_field`;
CREATE TABLE `custom_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `listener`;
CREATE TABLE `listener` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `listener_uid` int(11) NOT NULL,
  `listener_ip` varchar(45) NOT NULL,
  `listener_user_agent` varchar(255) NOT NULL,
  `timestamp_start` int(11) NOT NULL,
  `timestamp_end` int(11) NOT NULL,
  `listener_hash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_959C342221BDB235` (`station_id`),
  KEY `update_idx` (`listener_hash`),
  KEY `search_idx` (`listener_uid`,`timestamp_end`),
  CONSTRAINT `FK_959C342221BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `station_id` int(11) DEFAULT NULL,
  `action_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_permission_unique_idx` (`role_id`,`action_name`,`station_id`),
  KEY `IDX_1FBA94E6D60322AC` (`role_id`),
  KEY `IDX_1FBA94E621BDB235` (`station_id`),
  CONSTRAINT `FK_1FBA94E621BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1FBA94E6D60322AC` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `setting_key` varchar(64) NOT NULL,
  `setting_value` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `song_history`;
CREATE TABLE `song_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `song_id` varchar(50) NOT NULL,
  `station_id` int(11) NOT NULL,
  `timestamp_start` int(11) NOT NULL,
  `listeners_start` int(11) DEFAULT NULL,
  `timestamp_end` int(11) NOT NULL,
  `listeners_end` smallint(6) DEFAULT NULL,
  `delta_total` smallint(6) NOT NULL,
  `delta_positive` smallint(6) NOT NULL,
  `delta_negative` smallint(6) NOT NULL,
  `delta_points` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `playlist_id` int(11) DEFAULT NULL,
  `timestamp_cued` int(11) DEFAULT NULL,
  `request_id` int(11) DEFAULT NULL,
  `unique_listeners` smallint(6) DEFAULT NULL,
  `media_id` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `sent_to_autodj` tinyint(1) NOT NULL,
  `autodj_custom_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2AD16164427EB8A5` (`request_id`),
  KEY `IDX_2AD16164A0BDB2F3` (`song_id`),
  KEY `IDX_2AD1616421BDB235` (`station_id`),
  KEY `IDX_2AD161646BBD148` (`playlist_id`),
  KEY `IDX_2AD16164EA9FDD75` (`media_id`),
  KEY `history_idx` (`timestamp_start`,`timestamp_end`,`listeners_start`),
  CONSTRAINT `FK_2AD1616421BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2AD16164427EB8A5` FOREIGN KEY (`request_id`) REFERENCES `station_requests` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2AD161646BBD148` FOREIGN KEY (`playlist_id`) REFERENCES `station_playlists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2AD16164A0BDB2F3` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2AD16164EA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `station_media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `songs`;
CREATE TABLE `songs` (
  `id` varchar(50) NOT NULL,
  `text` varchar(150) DEFAULT NULL,
  `artist` varchar(150) DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `created` int(11) NOT NULL,
  `play_count` int(11) NOT NULL,
  `last_played` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `search_idx` (`text`,`artist`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station`;
CREATE TABLE `station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `frontend_type` varchar(100) DEFAULT NULL,
  `frontend_config` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `backend_type` varchar(100) DEFAULT NULL,
  `backend_config` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `description` longtext DEFAULT NULL,
  `automation_settings` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `automation_timestamp` int(11) DEFAULT NULL,
  `enable_requests` tinyint(1) NOT NULL,
  `request_delay` int(11) DEFAULT NULL,
  `enable_streamers` tinyint(1) NOT NULL,
  `needs_restart` tinyint(1) NOT NULL,
  `request_threshold` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `radio_media_dir` varchar(255) DEFAULT NULL,
  `radio_base_dir` varchar(255) DEFAULT NULL,
  `has_started` tinyint(1) NOT NULL,
  `nowplaying` longtext DEFAULT NULL COMMENT '(DC2Type:array)',
  `adapter_api_key` varchar(150) DEFAULT NULL,
  `nowplaying_timestamp` int(11) DEFAULT NULL,
  `enable_public_page` tinyint(1) NOT NULL,
  `short_name` varchar(100) DEFAULT NULL,
  `current_streamer_id` int(11) DEFAULT NULL,
  `is_streamer_live` tinyint(1) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL,
  `api_history_items` smallint(6) NOT NULL,
  `disconnect_deactivate_streamer` int(11) DEFAULT 0,
  `genre` varchar(150) DEFAULT NULL,
  `storage_quota` bigint(20) DEFAULT NULL,
  `storage_used` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9F39F8B19B209974` (`current_streamer_id`),
  CONSTRAINT `FK_9F39F8B19B209974` FOREIGN KEY (`current_streamer_id`) REFERENCES `station_streamers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_media`;
CREATE TABLE `station_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `song_id` varchar(50) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `artist` varchar(200) DEFAULT NULL,
  `album` varchar(200) DEFAULT NULL,
  `length` int(11) NOT NULL,
  `length_text` varchar(10) DEFAULT NULL,
  `path` varchar(500) DEFAULT NULL,
  `mtime` int(11) DEFAULT NULL,
  `fade_overlap` decimal(3,1) DEFAULT NULL,
  `fade_in` decimal(3,1) DEFAULT NULL,
  `fade_out` decimal(3,1) DEFAULT NULL,
  `cue_in` decimal(5,1) DEFAULT NULL,
  `cue_out` decimal(5,1) DEFAULT NULL,
  `isrc` varchar(15) DEFAULT NULL,
  `lyrics` longtext DEFAULT NULL,
  `unique_id` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `path_unique_idx` (`path`,`station_id`),
  KEY `IDX_32AADE3A21BDB235` (`station_id`),
  KEY `IDX_32AADE3AA0BDB2F3` (`song_id`),
  KEY `search_idx` (`title`,`artist`,`album`),
  CONSTRAINT `FK_32AADE3A21BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_32AADE3AA0BDB2F3` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_media_custom_field`;
CREATE TABLE `station_media_custom_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `field_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_35DC02AAEA9FDD75` (`media_id`),
  KEY `IDX_35DC02AA443707B0` (`field_id`),
  CONSTRAINT `FK_35DC02AA443707B0` FOREIGN KEY (`field_id`) REFERENCES `custom_field` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_35DC02AAEA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `station_media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_mounts`;
CREATE TABLE `station_mounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `fallback_mount` varchar(100) DEFAULT NULL,
  `enable_autodj` tinyint(1) NOT NULL,
  `autodj_format` varchar(10) DEFAULT NULL,
  `autodj_bitrate` smallint(6) DEFAULT NULL,
  `frontend_config` longtext DEFAULT NULL,
  `relay_url` varchar(255) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `authhash` varchar(255) DEFAULT NULL,
  `custom_listen_url` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `is_visible_on_public_pages` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_4DDF64AD21BDB235` (`station_id`),
  CONSTRAINT `FK_4DDF64AD21BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_playlist_media`;
CREATE TABLE `station_playlist_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `playlist_id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `weight` smallint(6) NOT NULL,
  `last_played` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_EA70D7796BBD148` (`playlist_id`),
  KEY `IDX_EA70D779EA9FDD75` (`media_id`),
  CONSTRAINT `FK_EA70D7796BBD148` FOREIGN KEY (`playlist_id`) REFERENCES `station_playlists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_EA70D779EA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `station_media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_playlists`;
CREATE TABLE `station_playlists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `type` varchar(50) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL,
  `play_per_songs` smallint(6) NOT NULL,
  `play_per_minutes` smallint(6) NOT NULL,
  `schedule_start_time` smallint(6) NOT NULL,
  `schedule_end_time` smallint(6) NOT NULL,
  `play_once_time` smallint(6) NOT NULL,
  `weight` smallint(6) NOT NULL,
  `include_in_automation` tinyint(1) NOT NULL,
  `schedule_days` varchar(50) DEFAULT NULL,
  `play_once_days` varchar(50) DEFAULT NULL,
  `source` varchar(50) NOT NULL,
  `include_in_requests` tinyint(1) NOT NULL,
  `playback_order` varchar(50) NOT NULL,
  `remote_url` varchar(255) DEFAULT NULL,
  `remote_type` varchar(25) DEFAULT NULL,
  `is_jingle` tinyint(1) NOT NULL,
  `play_per_hour_minute` smallint(6) NOT NULL,
  `interrupt_other_songs` tinyint(1) NOT NULL,
  `loop_playlist_once` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DC827F7421BDB235` (`station_id`),
  CONSTRAINT `FK_DC827F7421BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_remotes`;
CREATE TABLE `station_remotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable_autodj` tinyint(1) NOT NULL,
  `autodj_format` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autodj_bitrate` smallint(6) DEFAULT NULL,
  `custom_listen_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mount` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_username` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_port` smallint(6) DEFAULT NULL,
  `source_mount` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_visible_on_public_pages` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_779D0E8A21BDB235` (`station_id`),
  CONSTRAINT `FK_779D0E8A21BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `station_requests`;
CREATE TABLE `station_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `played_at` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F71F0C0721BDB235` (`station_id`),
  KEY `IDX_F71F0C075ED23C43` (`track_id`),
  CONSTRAINT `FK_F71F0C0721BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_F71F0C075ED23C43` FOREIGN KEY (`track_id`) REFERENCES `station_media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_streamers`;
CREATE TABLE `station_streamers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `streamer_username` varchar(50) NOT NULL,
  `streamer_password` varchar(50) NOT NULL,
  `comments` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `reactivate_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5170063E21BDB235` (`station_id`),
  CONSTRAINT `FK_5170063E21BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `station_webhooks`;
CREATE TABLE `station_webhooks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `station_id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL,
  `triggers` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `config` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `name` varchar(100) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`),
  KEY `IDX_1516958B21BDB235` (`station_id`),
  CONSTRAINT `FK_1516958B21BDB235` FOREIGN KEY (`station_id`) REFERENCES `station` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `user_has_role`;
CREATE TABLE `user_has_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `IDX_EAB8B535A76ED395` (`user_id`),
  KEY `IDX_EAB8B535D60322AC` (`role_id`),
  CONSTRAINT `FK_EAB8B535A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`uid`) ON DELETE CASCADE,
  CONSTRAINT `FK_EAB8B535D60322AC` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `auth_password` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `timezone` varchar(100) DEFAULT NULL,
  `locale` varchar(25) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `theme` varchar(25) DEFAULT NULL,
  `two_factor_secret` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `email_idx` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
