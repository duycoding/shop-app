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
