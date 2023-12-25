--liquibase formatted sql

--changeSet tariff:1
CREATE TABLE `internet_provider`.`tariff` (
  `tariff_id`      INT UNSIGNED                     NOT NULL AUTO_INCREMENT,
  `title`          VARCHAR(20) CHARACTER SET 'utf8' NOT NULL,
  `cost`           SMALLINT(3) UNSIGNED             NOT NULL,
  `download_speed` SMALLINT(4) UNSIGNED             NOT NULL,
  `upload_speed`   SMALLINT(4) UNSIGNED             NOT NULL,
  `traffic`        SMALLINT(4) UNSIGNED             NOT NULL,
  `img_url`        VARCHAR(20) CHARACTER SET 'utf8',
  PRIMARY KEY (`tariff_id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COLLATE = utf8_roman_ci;

--changeSet user :2
CREATE TABLE `internet_provider`.`user` (
  `user_id`      INT UNSIGNED                      NOT NULL AUTO_INCREMENT,
  `login`        VARCHAR(30) CHARACTER SET 'utf8'  NOT NULL,
  `password`     CHAR(79) CHARACTER SET 'utf8'     NOT NULL,
  `email`        VARCHAR(255) CHARACTER SET 'utf8' NOT NULL,
  `role`         TINYINT(1) UNSIGNED               NOT NULL,
  `tariff_id`    INT UNSIGNED                      NULL,
  `cash`         SMALLINT(4)                       NULL,
  `traffic`      SMALLINT(4) UNSIGNED              NULL,
  `status`       TINYINT(1) UNSIGNED               NOT NULL,
  `bonus_amount` SMALLINT(4) UNSIGNED              NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `FK_user_tariff_idx` (`tariff_id` ASC),
  CONSTRAINT `FK_user_tariff`
  FOREIGN KEY (`tariff_id`)
  REFERENCES `internet_provider`.`tariff` (`tariff_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COLLATE = utf8_roman_ci;
