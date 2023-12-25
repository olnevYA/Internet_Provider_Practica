--liquibase formatted sql

--changeSet reward_init:1
INSERT INTO `reward` VALUES
  (1, 'Modem-linksys', 200, 'img/linksys-dpc3008.png'),
  (2, 'USB flash drive Samsung-16GB', 200, 'img/samsung-16.png'),
  (3, 'USB flash drive HP-32GB', 300, 'img/hp-32.png'),
  (4, 'USB flash drive PNY-256GB', 600, 'img/pny-256.png'),
  (5, 'Computer mouse A4Tech-Bloody R7', 380, 'img/a4tech-bloody-R7.png'),
  (6, 'Computer mouse A4Tech-Bloody R8', 400, 'img/a4tech-bloody-R8.png'),
  (7, 'RJ45 cable 8m', 170, 'img/rj-45-8m.png'),
  (8, 'Black Cup The National', 150, 'img/black-cup.png'),
  (9, 'Green Cup Smoothies', 150, 'img/green-cup.png'),
  (10, 'Red cup East Coast Coffee', 150, 'img/red-cup.png');

--changeSet tariff_init:2
INSERT INTO `tariff` VALUES
  (1, 'Super Cat', 10, 20, 15, 100, 'img/cat.png'),
  (2, 'Super Cat X', 25, 25, 18, 150, 'img/cat.png'),
  (3, 'Super Owl', 30, 50, 25, 200, 'img/owl.png'),
  (4, 'Super Dog', 20, 40, 30, 0, 'img/dog.png'),
  (5, 'Super Fox', 35, 70, 50, 0, 'img/lis.png');

--changeSet user_init:3
INSERT INTO `user` VALUES
  (1, 'admin', '$s0$61010$B/8tnznu8c0ipijNiwpExw==$UVzfWgXgw3CWjzNHu4GJxm+ZUjkBMi6X2wSU435OcOo=',
   'admin@gmail.com', 1, null, 0, null, 1, 0),
  (2, 'Trogg', '$s0$61010$yzOZG5aJu9KF2b2nrHG+dg==$6jcja6OVYbpZ9t1ak5jL6Dx64em5ZR4E++6MtBjDfyI=',
   'murfrik666@gmail.com', 0, 4, 50, 0, 1, 1000);

--changeSet user_2reward_init:4
INSERT INTO `user_2reward`
VALUES (2, 5), (2, 10), (1, 10), (1, 1);
