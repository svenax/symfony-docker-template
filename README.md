# 🐳 Docker + PHP 7.4 + MySQL + Nginx + Symfony 5 project template

## Description

This is a complete stack for running Symfony 5 in Docker containers using `docker-compose`.

It consists of three containers:

- `nginx` - webserver.
- `php` - PHP-FPM with PHP 7.4.
- `db` - MySQL container with a **MySQL 8.0** image.

## Installation

1. Clone this repo
2. Run `make up`
3. Run `bin/composer install`
4. Go to <http://localhost> to check it out

You should change the name, user and password of the database in the `.env` 
file at the root of the project and in the `app` folder. 

# TODO

- Remove passwords from checked-in files
- Use Symfony secret assets for that
