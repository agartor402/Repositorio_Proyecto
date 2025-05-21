--------------------------------------------------------------------
-- execute the following statements to create a user name COMPANY and
-- grant priviledges
--------------------------------------------------------------------

-- Desde root

CREATE DATABASE company_db;

CREATE USER 'company'@localhost IDENTIFIED BY 'company';

GRANT ALL PRIVILEGES ON company_db.* TO 'company'@localhost;

-- Ahora creamos una nueva sesión asociada al usuario y la abrimos