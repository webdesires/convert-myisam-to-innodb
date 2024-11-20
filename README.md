
# Convert MyISAM to InnoDB  

A Bash script to automate the conversion of MyISAM tables to InnoDB in a MySQL or MariaDB database. This script is straightforward to use and helps streamline database optimization and management.

## Features  
- Automatically convert all MyISAM tables in a database to InnoDB.  
- Simple setup and execution.  
- Works with MySQL and MariaDB.  

## Requirements  
- Bash shell  
- MySQL or MariaDB client installed  
- Access to the database with appropriate permissions  

## Installation  

1. Download the script using `wget`:  
   ```bash
   wget https://raw.githubusercontent.com/webdesires/convert-myisam-to-innodb/main/convert-myisam-to-innodb.sh
   ```  

2. Make the script executable:  
   ```bash
   chmod +x convert-myisam-to-innodb.sh
   ```  

## Usage  

Run the script with:  
```bash
./convert-myisam-to-innodb.sh
```  

Follow the prompts to provide the database credentials and target database name.

## Disclaimer  

This script is provided "as-is," without any warranty. Use at your own risk. The authors are not responsible for any data loss or issues caused by using this script. Always back up your database before running any modification scripts.

## Donations  

If you find this script useful and would like to support its development, consider making a donation:

- PayPal: [Donate via PayPal](https://www.paypal.me/webdesires)  

Your contributions are greatly appreciated!

## License  

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.  
