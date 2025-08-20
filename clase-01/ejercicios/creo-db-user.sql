

CREATE DATABASE nombredeladb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci


CREATE USER 'usuario_de_la_db'@'localhost' IDENTIFIED BY 'password_dificil'

GRANT ALL PRIVILEGES ON nombredeladb.* TO 'usuario_de_la_db'@'localhost';


FLUSH PRIVILEGES;
