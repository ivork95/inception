-- -- Set root password
-- ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

-- -- Create wordpress database
-- CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;

-- -- Create user
-- CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost';
-- SET PASSWORD FOR '$MYSQL_USER'@'localhost' = PASSWORD('$MYSQL_PASSWORD');
-- GRANT ALL PRIVILEGES ON wordpress_db.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';

-- FLUSH PRIVILEGES;

-- Set root password
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';

-- Create wordpress database
CREATE DATABASE IF NOT EXISTS WordPressDatabase;

-- Create user
CREATE USER IF NOT EXISTS 'ivork'@'localhost';
SET PASSWORD FOR 'ivork'@'localhost' = PASSWORD('password');
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'ivork'@'%' IDENTIFIED BY 'password';

FLUSH PRIVILEGES;
