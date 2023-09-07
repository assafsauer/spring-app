CREATE USER spring with encrypted password 'spring';
CREATE DATABASE spring_db OWNER spring;
GRANT ALL PRIVILEGES ON DATABASE spring_db TO spring;

