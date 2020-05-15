-- 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME,
  updated_at DATETIME
);

INSERT INTO users (name, birthday_at) VALUES
  ('Сергей', '1999-12-18'),
  ('Анрей', '2001-09-09'),
  ('Ольга', '1998-11-12'),
  ('София', '2000-12-10'),
  ('Александр', '1985-05-20');

UPDATE users SET created_at = NOW(), updated_at = NOW();
SELECT * FROM users;


-- 2 Таблица users была неудачно спроектирована. Записи created_at и updated_at
-- были заданы типом VARCHAR и в них долгое время помещались значения в формате
-- "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив 
-- введеные ранее значения.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
);


INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Сергей', '1999-12-18', '09.12.2020 11:46',  '29.11.2011 11:22'),
  ('Анрей', '2001-09-09', '03.11.1990 11:46',  '11.11.2011 11:11');
  
 SELECT STR_TO_DATE(created_at, '%k:%i %d.%m.%Y ') FROM users;
 UPDATE users SET  created_at = STR_TO_DATE(created_at, ' %d.%m.%Y %k:%i'),
 		updated_at = STR_TO_DATE(updated_at, ' %d.%m.%Y %k:%i');
 	
 SELECT * FROM users;

-- 3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи
-- таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы
-- должны выводиться в конце, после всех записей.


-- 4 (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий ('may', 'august')



DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  value VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME,
  updated_at DATETIME
);

INSERT INTO users (name, birthday_at, value) VALUES
  ('Сергей', '1999-12-18', '0'),
  ('Анрей', '2001-09-09', '30'),
  ('Ольга', '1998-11-12', '500'),
  ('София', '2000-12-10', '2500'),
  ('Стас', '1999-09-11', '1'),
  ('Александр', '1985-05-20', '0');

UPDATE users SET created_at = NOW(), updated_at = NOW();
SELECT * FROM users ORDER BY IF(value > 0, 0, 1), value;
SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('May', 'September')
 
-- 1 Подсчитайте средний возраст пользователей в таблице users



SELECT
  birthday_at ,
  (
    (YEAR(CURRENT_DATE) - YEAR(birthday_at )) - 
    (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday_at , '%m%d'))
  ) AS age
FROM users  

SELECT AVG(created_at) AS age FROM users
 