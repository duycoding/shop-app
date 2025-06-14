create database ShopApp;
-- move to ShopApp
use ShopApp;

-- encrypt password sha-256
create table users (
 id int PRIMARY KEY auto_increment,
 fullname VARCHAR(100) DEFAULT '',
 phone_number VARCHAR(10) NOT NULL,
 address VARCHAR(200) DEFAULT '',
 password VARCHAR(100) NOT NULL DEFAULT '',
 create_at DATETIME,
 updated_at DATETIME,
 is_active TINYINT(1) DEFAULT 1,
 date_of_birth DATE,
 facebook_account_id INT DEFAULT 0
);

-- UPDATE TALBE USER WITH ROLES
ALTER TABLE users ADD COLUMN `role_id` INT;
ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles(id);

CREATE TABLE tokens (
 id int PRIMARY KEY AUTO_INCREMENT,
 token VARCHAR(255) UNIQUE NOT NULL,
 token_type VARCHAR(50) NOT NULL,
 expiration_date DATETIME,
 revoked TINYINT(1) NOT NULL,
 expired TINYINT(1) NOT NULL,	
 user_id int,
 FOREIGN KEY (user_id) REFERENCES users(id)
);

-- support Google login and Facebook login
CREATE TABLE social_accounts (
 id INT PRIMARY KEY AUTO_INCREMENT,
 provider VARCHAR(20) NOT NULL COMMENT 'Facebook provider or Google Provider',
 provider_id VARCHAR(50) NOT NULL,
 email VARCHAR(150) NOT NULL COMMENT 'User email',
 name VARCHAR(100) NOT NULL COMMENT 'Username',
 user_id int,
 FOREIGN KEY (user_id) REFERENCES users(id)
);

-- table categories
CREATE TABLE categories(
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'name of category, for example: electric...'
);

-- table products
CREATE TABLE products (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(350) COMMENT 'product name',
 price FLOAT NOT NULL CHECK(price >= 0), -- constraint price >= 0
 thumnail VARCHAR(300) DEFAULT '', -- image url
 description LONGTEXT DEFAULT '',
 created_at DATETIME,
 updated_at DATETIME,
 category_id INT,
 FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- table orders
CREATE TABLE orders(
 id INT PRIMARY KEY AUTO_INCREMENT,
 user_id INT,
 FOREIGN KEY (user_id) REFERENCES users(id),
 fullname VARCHAR(100) DEFAULT '',
 email VARCHAR(20) NOT NULL,
 phone_number VARCHAR(20) NOT NULL,
 address VARCHAR(200) NOT NULL,
 note VARCHAR(100) DEFAULT '',
 order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 status VARCHAR(20),
 total_money FLOAT CHECK(total_money >= 0)
);

-- update table orders
ALTER TABLE orders ADD COLUMN `shipping_method` VARCHAR(100);
ALTER TABLE orders ADD COLUMN `shipping_address` VARCHAR(200);
ALTER TABLE orders ADD COLUMN `shipping_date` DATE;
ALTER TABLE orders ADD COLUMN `tracking_number` VARCHAR(100);
ALTER TABLE orders ADD COLUMN `payment_method` VARCHAR(100);
-- soft delete orders
ALTER TABLE orders ADD COLUMN `active` TINYINT(1);

-- modify table orders on field status
ALTER TABLE orders MODIFY COLUMN status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') COMMENT 'Order status';

-- table order_details
CREATE TABLE order_details(
 id INT PRIMARY KEY AUTO_INCREMENT,
 order_id INT,
 FOREIGN KEY (order_id) REFERENCES orders (id),
 product_id INT,
 FOREIGN KEY (product_id) REFERENCES products (id),
 price FLOAT CHECK(price >= 0),
 number_of_products INT CHECK(number_of_products >= 0),
 total_money FLOAT CHECK(total_money >= 0),
 color VARCHAR(20) DEFAULT ''
);

-- table roles
CREATE TABLE roles (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(20)
);