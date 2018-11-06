# cache_warmer
Website cache warmer with page load times pushed to MySQL database.

Usage:

./cache-warmer.sh sitemap.xml


MariaDB [(none)]> create database stats;
MariaDB [(none)]> use stats;
MariaDB [stats]> CREATE TABLE `table_name` (
  `address` varchar(255) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT current_timestamp(),
  `time_namelookup` varchar(255) DEFAULT NULL,
  `time_connect` varchar(255) DEFAULT NULL,
  `time_appconnect` varchar(255) DEFAULT NULL,
  `time_pretransfer` varchar(255) DEFAULT NULL,
  `time_redirect` varchar(255) DEFAULT NULL,
  `time_starttransfer` varchar(255) DEFAULT NULL,
  `time_total` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1322 DEFAULT CHARSET=utf8
