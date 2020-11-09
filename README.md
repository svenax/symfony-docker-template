# 🐳 Docker + PHP 7.4 + MySQL + Nginx + Symfony 5 project template

## Description

This is a complete stack for running Symfony 5 in Docker containers using `docker-compose`.

It consists of three containers:

- `nginx` - webserver.
- `php` - PHP-FPM with PHP 7.4.
- `db` - MySQL container with a **MySQL 8.0** image.

## Installation

1. Clone this repo
2. Copy `app/.env.local.template` to `app/.env.local` and update it as needed
3. Run `make up`
4. Run `bin/composer install`
5. Go to <http://localhost> to check it out

## Usage

All code for the project is found in the `app` folder. Scripts to interact with the Docker
containers are in the `bin` folder. The `Makefile` contains convenience scripts for Docker,
backups, and more.
