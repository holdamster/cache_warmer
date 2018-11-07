# cache_warmer
### Website cache warmer with page load times pushed to MySQL database.

Usage:
```
./cache-warmer.sh sitemap.xml
```

Page load times are taken from curl command which is run to keep the cache warm.

Example stats generated for each URL listed in sitemap.xml file (saved in tmp files) below. These are pushed into the database created to store the data.

```
HTTPS://WEBSITE_ADDRESS

    time_namelookup:  0.004
       time_connect:  0.014
    time_appconnect:  0.174
   time_pretransfer:  0.174
      time_redirect:  0.000
 time_starttransfer:  0.516
                    ----------
         time_total:  0.536

```     

Creating the database and table (replace table_name with your desired name. Also swap it in the script.)

```
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
) ENGINE=InnoDB AUTO_INCREMENT=1322 DEFAULT CHARSET=utf8;

Query OK, 0 rows affected (0.067 sec)

MariaDB [stats]> 

```



Before using the script, create the sitemap.xml file with one URL per line.

Change the paths if you upload it to different directory than /root/cache-warmer/.

And change the table name to the name chosen while creating the table.

Add a cron job to run the script automatically:
```
* * * * * /usr/bin/bash /root/cache-warmer/cache-warmer.sh "/root/cache-warmer/sitemap.xml" > /dev/null
```
