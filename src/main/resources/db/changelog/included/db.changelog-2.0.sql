--liquibase formatted sql

--changeSet reward:1
CREATE TABLE `internet_provider`.`reward` (
  `reward_id`    INT UNSIGNED                     NOT NULL AUTO_INCREMENT,
  `title`        VARCHAR(60) CHARACTER SET 'utf8' NOT NULL,
  `bonus_points` SMALLINT(4) UNSIGNED             NOT NULL,
  `img_href`     VARCHAR(80) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`reward_id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COLLATE = utf8_roman_ci;

--changeSet user_2reward:2
CREATE TABLE `internet_provider`.`user_2reward` (
  `user_id`   INT UNSIGNED NOT NULL,
  `reward_id` INT UNSIGNED NOT NULL,
  INDEX `user_2reward_fk0_idx` (`user_id` ASC),
  INDEX `user_2reward_fk1_idx` (`reward_id` ASC),
  CONSTRAINT `user_2reward_fk0`
  FOREIGN KEY (`user_id`)
  REFERENCES `internet_provider`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `user_2reward_fk1`
  FOREIGN KEY (`reward_id`)
  REFERENCES `internet_provider`.`reward` (`reward_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8
  COLLATE = utf8_roman_ci;
