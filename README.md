# 🚀 PHP + MariaDB Web Application using Docker

This project demonstrates how to deploy a PHP web application that connects to a MariaDB database — using Docker containers only. The app fetches and displays a list of users stored in the database.

## 📁 Folder Structure

php-mariadb-project/
├── app.php          # PHP script (main web app)
├── init.sql         # SQL script to create and populate the database
└── Dockerfile       # Dockerfile for building PHP + Apache image

## ✅ Features

- PHP 7.4 + Apache container serving the web app
- MariaDB 11 container with initialized data
- Docker network to allow container-to-container communication
- Clean separation of app and database logic

## 🛠️ Getting Started

### Step 1: Create Docker Network

docker network create php-mariadb-net

### Step 2: Run the MariaDB Container

docker run -d \
  --name mariadb \
  --network php-mariadb-net \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=unnati \
  -e MYSQL_USER=yashraj \
  -e MYSQL_PASSWORD=redhat \
  -v $(pwd)/init.sql:/docker-entrypoint-initdb.d/init.sql \
  mariadb:11

### Step 3: Build the PHP + Apache Docker Image

docker build -t php-mariadb-app .

### Step 4: Run the PHP Container

docker run -d \
  --name php-app \
  --network php-mariadb-net \
  -p 8080:80 \
  -e DB_HOST=mariadb \
  -e DB_NAME=unnati \
  -e DB_USER=yashraj \
  -e DB_PASS=redhat \
  php-mariadb-app

## 🌐 Access the App

Open your browser and visit:

http://localhost:8080

You should see a list of users from the MariaDB database.

## 🧹 Clean Up (Optional)

To stop and remove containers and network:

docker stop php-app mariadb
docker rm php-app mariadb
docker network rm php-mariadb-net

## 📌 Notes

- `init.sql` only runs on the first DB container start. To apply changes, you must remove and recreate the container.
- Make sure both containers are in the same Docker network.

## 📄 License

This project is provided for educational and demo purposes.
