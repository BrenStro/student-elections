# Student Elections
Web application for hosting student elections in schools for various student government positions.

## Version
Initial release: 0.1.0

## Set-Up
The following is an overview of the steps needed to set up and run the Student Elections Application Server.


### Dependencies
Ensure all of the following dependent softwares are installed and properly configured before proceeding:

 * [Apache ^2.4.0](https://httpd.apache.org/)
 * [MySQL ^5.7.0](https://www.mysql.com/)
 * [PHP ^7.1.0](https://www.php.net)

### System Administration
The following System Administrative tasks must be completed before the application can run.

 1. Configure Apache
  * Enable the rewrite module: `sudo a2enmod rewrite`.
  * Add the following Directory directive to the default site in the Apache sites file configuration (replacing `/var/www` with the file-system directory from which Apache is serving this application):
	```
	DocumentRoot /var/www/src
	<Directory /var/www/>
		AllowOverride FileInfo
		Order Allow,Deny
		Allow from all
	</Directory>
	```
  * After updating, reload Apache: `systemctl reload apache2`.
 2. Configure MySQL
  * Create user `student-elections` using the `mysql_native_password` plugin for password hashing (replacing `USER_PASSWORD` with a strong, secure, unique password):
	```
	CREATE USER 'student-elections'@'localhost'
		IDENTIFIED WITH mysql_native_password BY 'USER_PASSWORD';
	```
  * For the new `student-elections` user, grant the following privileges:
	```
	GRANT USAGE, SELECT, INSERT, UPDATE, DELETE, EXECUTE, SHOW VIEW, CREATE, ALTER, REFERENCES, INDEX, CREATE VIEW, DROP, CREATE TEMPORARY TABLES
		ON 'StudentElections'.*
		TO 'student-elections'@'localhost';
	```

### Application Administration
Should the server environment be fully configured, the application environment can be set up by following the steps below. **Note:** Any executable statement prefixed with _Run_ should be executed in the root directory of the application. The recommended location for the application to live is is `/var/www/`, though this isn’t necessary for the application to run successfully.
 1. Clone application from the Git Repository.
 2. Set up MySQL environment.
  1. Find the MySQL Script located in `./scripts/CreateDB.sql`.
  2. Log in to MySQL using the created `student-elections` user and run the script.
 3. Set up environment variables.
  1. Create a file to hold the variables. Run `touch .htaccess`.
  2. In the file, include the following (updating all values placed in `<angle_brackets>`):
	```
	SetEnv DB_HOST localhost
	SetEnv DB_NAME StudentElections
	SetEnv DB_USERNAME student-elections
	SetEnv DB_PASSWORD <mysql_password>

	SetENV RUNNING_ENV <environment>
	```
   `DB_PASSWORD` comes from the password set in the **Configure MySQL** sub-section of the **System Administration** section.
   `RUNNING_ENV` should be set to which type of server environment this application is running within (i.e. either `development` or `production`).
 4. Install the dependent PHP Composer dependencies. Run `php composer install`.
