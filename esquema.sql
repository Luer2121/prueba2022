DROP SCHEMA IF EXISTS prueba2020 ;


CREATE SCHEMA IF NOT EXISTS prueba2020 DEFAULT CHARACTER SET utf8 ;
USE prueba2020 ;


CREATE TABLE IF NOT EXISTS prueba2020.users (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME NULL DEFAULT NOW(),
  updated_at DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS prueba2020.appointments (
  id INT NOT NULL AUTO_INCREMENT,
  task VARCHAR(255) NOT NULL,
  date DATETIME NOT NULL,
  status VARCHAR(255) NOT NULL,
  created_at DATETIME NULL DEFAULT NOW(),
  updated_at DATETIME NULL DEFAULT NOW(),
  users_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_table2_users_idx (users_id ASC) VISIBLE,
  CONSTRAINT fk_table2_users
    FOREIGN KEY (users_id)
    REFERENCES prueba2020.users (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



DROP TABLE IF EXISTS appointments;

CREATE TABLE appointments (
  id int NOT NULL AUTO_INCREMENT,
  task varchar(255) NOT NULL,
  date datetime NOT NULL,
  status varchar(255) NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP,
  users_id int NOT NULL,
  PRIMARY KEY (id),
  KEY fk_table2_users_idx (users_id),
  CONSTRAINT fk_table2_users FOREIGN KEY (users_id) REFERENCES users (id)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;


LOCK TABLES appointments WRITE;
INSERT INTO appointments VALUES (3,'PLAYA','2022-08-28 00:00:00','Missed','2022-08-27 11:03:16','2022-08-27 12:17:24',1),(4,'aaa','2022-08-05 00:00:00','Missed','2022-08-27 11:22:11','2022-08-27 11:22:11',1),(5,'Cantar','2022-08-28 00:00:00','Pending','2022-08-27 11:23:54','2022-08-27 11:23:54',1),(6,'aaa','2022-08-28 00:00:00','Missed','2022-08-27 11:25:52','2022-08-27 11:25:52',1),(7,'bbbb','2022-09-02 00:00:00','Done','2022-08-27 11:40:03','2022-08-27 11:40:03',1);

UNLOCK TABLES;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id int NOT NULL AUTO_INCREMENT,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  password varchar(255) NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;


LOCK TABLES users WRITE;

INSERT INTO users VALUES (1,'Luis','Erazo','luer2121@hotmail.com','$2b$12$QH1EF05LbGMkJcJXQc/d5OsMcCkJXxmm0YXZnYi4gIIKx.zfQHO2S','2022-08-27 09:37:24','2022-08-27 09:37:24'),(2,'Andres','Noguera','andres@hotmail.com','$2b$12$2RTYTjf9/CCjgC6iso8UfOUiQTuvBvEY.uSDgWrYEx0sdR4PGmWJC','2022-08-27 11:04:06','2022-08-27 11:04:06');

UNLOCK TABLES;

