# ESPOLTEL Hiring Manager
Mobile and web tool to facilitate the hiring flow of the company ESPOLTEL S.A. 
Specifically, it aims to help human resources and to keep track of all its contracts.

## Dependencies
- Mariadb
- SprintBoot Tools
- Java JRE 21
- Maven

## How to install and execute
- Clone the repository
```
git clone https://github.com/Jeremy-Poveda/EspoltelHiringManager
cd EspoltelHiringManager
```
- Install dependencies
```
mvn clean install
```
- Execute SQL script on /SQL/ESPOLTEL-DB.sql
- Create an .env file for enviromental variables
Example:
```
SPRING_PORT=8001
DB_NAME=ESPOLTEL
DB_USERNAME=root
DB_PASSWORD=1234
DB_PORT=3306
```
- Execute and test the program
On linux or Bash-like terminal:
```
./mvnw spring-boot:run
```
On Windows:

```
./mvnw.cmd spring-boot:run
```