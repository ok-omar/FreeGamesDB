CREATE DATABASE IF NOT EXISTS freegamesdb DEFAULT CHARACTER SET utf8;
USE freegamesdb ;

DROP TABLE IF EXISTS publishers;

CREATE TABLE IF NOT EXISTS publishers (
  publisher_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (publisher_id));

DROP TABLE IF EXISTS requerimientos_minimos;

CREATE TABLE IF NOT EXISTS freegamesdb.requerimientos_minimos (
  requeriments_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  os VARCHAR(45) NOT NULL,
  cpu VARCHAR(45) NOT NULL,
  ram VARCHAR(45) NOT NULL,
  gpu VARCHAR(45) NOT NULL,
  storage VARCHAR(45) NOT NULL,
  PRIMARY KEY (requeriments_id));

DROP TABLE IF EXISTS desarrolladoras;

CREATE TABLE IF NOT EXISTS desarrolladoras (
  desarrolladora_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (desarrolladora_id));

DROP TABLE IF EXISTS juegos_gratis;

CREATE TABLE IF NOT EXISTS juegos_gratis (
  juego_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo_juego VARCHAR(45) NOT NULL,
  titulo VARCHAR(50) NOT NULL,
  thumbnail VARCHAR(255) NULL,
  status ENUM("Live", "Offline") NOT NULL,
  short_desc VARCHAR(255) NULL,
  desc VARCHAR(255) NULL,
  url VARCHAR(255) NULL,
  release_date DATE NOT NULL,
  publishers_publisher_id INT UNSIGNED NOT NULL,
  requerimientos_minimos_requeriments_id INT UNSIGNED NOT NULL,
  desarrolladoras_desarrolladora_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (juego_id),
  UNIQUE INDEX codigo_UNIQUE (codigo_juego ASC) INVISIBLE,
  INDEX fk_juegos_gratis_publishers1_idx (publishers_publisher_id ASC) VISIBLE,
  INDEX fk_juegos_gratis_requerimientos_minimos1_idx (requerimientos_minimos_requeriments_id ASC) VISIBLE,
  INDEX fk_juegos_gratis_desarrolladoras1_idx (desarrolladoras_desarrolladora_id ASC) VISIBLE,
  CONSTRAINT fk_juegos_gratis_publishers1
    FOREIGN KEY (publishers_publisher_id)
    REFERENCES freegamesdb.publishers (publisher_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_juegos_gratis_requerimientos_minimos1
    FOREIGN KEY (requerimientos_minimos_requeriments_id)
    REFERENCES freegamesdb.requerimientos_minimos (requeriments_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_juegos_gratis_desarrolladoras1
    FOREIGN KEY (desarrolladoras_desarrolladora_id)
    REFERENCES freegamesdb.desarrolladoras (desarrolladora_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


DROP TABLE IF EXISTS plataformas;

CREATE TABLE IF NOT EXISTS plataformas (
  plataforma_id INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (plataforma_id));

DROP TABLE IF EXISTS screenshots;

CREATE TABLE IF NOT EXISTS screenshots (
  screenshot_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  url VARCHAR(255) NOT NULL,
  juegos_gratis_juego_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (screenshot_id),
  INDEX fk_screenshots_juegos_gratis_idx (juegos_gratis_juego_id ASC) VISIBLE,
  CONSTRAINT fk_screenshots_juegos_gratis
    FOREIGN KEY (juegos_gratis_juego_id)
    REFERENCES juegos_gratis (juego_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

DROP TABLE IF EXISTS juegos_plataformas ;

CREATE TABLE IF NOT EXISTS juegos_plataformas (
  juego_plataforma_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  juegos_gratis_juego_id INT UNSIGNED NOT NULL,
  plataformas_plataforma_id INT NOT NULL,
  PRIMARY KEY (juego_plataforma_id),
  INDEX fk_juegos_plataformas_juegos_gratis1_idx (juegos_gratis_juego_id ASC) VISIBLE,
  INDEX fk_juegos_plataformas_plataformas1_idx (plataformas_plataforma_id ASC) VISIBLE,
  CONSTRAINT fk_juegos_plataformas_juegos_gratis1
    FOREIGN KEY (juegos_gratis_juego_id)
    REFERENCES juegos_gratis (juego_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_juegos_plataformas_plataformas1
    FOREIGN KEY (plataformas_plataforma_id)
    REFERENCES plataformas (plataforma_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);