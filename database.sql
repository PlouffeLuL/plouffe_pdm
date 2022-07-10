INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('pdm', 'Pdm Auto', 1),
	('pdmoff', 'Pdm Auto Hors Service', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('pdmoff', 0, 'consierge', 'Consierge Hors Service', 0, '{}', '{}'),
	('pdmoff', 1, 'recruit', 'Debutant Hors Service', 0, '{}', '{}'),
	('pdmoff', 2, 'novice', 'Experimenter Hors Service', 0, '{}', '{}'),
	('pdmoff', 3, 'experienced', 'Professionel Hors Service', 0, '{}', '{}'),
  ('pdmoff', 4, 'boss', 'Patron Hors Service', 0, '{}', '{}'),
	('pdm', 0, 'consierge', 'Consierge', 0, '{}', '{}'),
	('pdm', 1, 'recruit', 'Debutant', 0, '{}', '{}'),
	('pdm', 2, 'novice', 'Experimenter', 0, '{}', '{}'),
	('pdm', 3, 'experienced', 'Professionel', 0, '{}', '{}'),
	('pdm', 4, 'boss', 'Patron', 0, '{}', '{}')
;

CREATE TABLE IF NOT EXISTS `pdm_display` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) NOT NULL,
  `coords` longtext NOT NULL,
  `props` longtext NOT NULL,
  `price` mediumint(9) NOT NULL,
  `model` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) NOT NULL DEFAULT '',
  `performance_state` longtext NOT NULL DEFAULT '{}',
  `owned` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pdm_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `price` mediumint(9) NOT NULL DEFAULT 0,
  `delivery_time` bigint(20) NOT NULL DEFAULT 0,
  `order_time` bigint(20) NOT NULL DEFAULT 0,
  `ordered_by` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pdm_orders_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `price` mediumint(9) NOT NULL DEFAULT 0,
  `delivery_time` bigint(20) NOT NULL DEFAULT 0,
  `order_time` bigint(20) NOT NULL DEFAULT 0,
  `ordered_by` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `pdm_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `price` mediumint(9) NOT NULL,
  `props` longtext NOT NULL DEFAULT '{}',
  `performance_state` longtext NOT NULL DEFAULT '{}',
  `plate` varchar(50) NOT NULL,
  `owned` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
