#!/bin/bash

# Function to prompt for MySQL credentials if needed
get_mysql_credentials() {
    read -p "Do you need to login to MySQL with a username and password? (y/n): " login_required
    if [ "$login_required" == "y" ]; then
        read -p "Enter MySQL username: " MYSQL_USER
        read -s -p "Enter MySQL password: " MYSQL_PASS
        echo
        MYSQL_CREDENTIALS="-u$MYSQL_USER -p$MYSQL_PASS"
    else
        MYSQL_CREDENTIALS=""
    fi
}

convert_database() {
    local DBNAME=$1
    echo "Converting tables in database: $DBNAME"
    SQL=$(mysql $MYSQL_CREDENTIALS -N -e "SELECT CONCAT('ALTER TABLE \`', table_name, '\` ENGINE=InnoDB;')
    FROM information_schema.tables
    WHERE table_schema = '$DBNAME'
    AND engine = 'MyISAM';")
    mysql $MYSQL_CREDENTIALS -D "$DBNAME" -e "$SQL"
    echo "Conversion complete for database: $DBNAME"
}

show_welcome_message() {
    clear
    echo "############################################################"
    echo "#                                                          #"
    echo "#          Convert MyISAM to InnoDB                        #"
    echo "#          Made by Dean Williams                           #"
    echo "#          Website: https://webdesires.co.uk               #"
    echo "#          Version: 0.1                                    #"
    echo "#                                                          #"
    echo "#  Disclaimer: Please ensure you have backups of your      #"
    echo "#  databases before running this script. We hold no        #"
    echo "#  responsibility for any loss of data or damage.          #"
    echo "#                                                          #"
    echo "#  If you find this script useful, please consider         #"
    echo "#  making a donation via PayPal to:                        #"
    echo "#  payments@webdesires.co.uk                               #"
    echo "#                                                          #"
    echo "############################################################"
    echo
    read -p "Do you accept the disclaimer and wish to continue? (y/n): " accept
    if [ "$accept" != "y" ]; then
        echo "Exiting script."
        exit 1
    fi
}

show_welcome_message

# Get MySQL credentials if needed
get_mysql_credentials

# Prompt for conversion type
echo "Choose an option:"
echo "1. Convert one database"
echo "2. Convert multiple databases (with partial match)"
echo "3. Convert all databases"
read -p "Enter choice [1-3]: " choice

case $choice in
    1)
        read -p "Enter database name: " DBNAME
        convert_database "$DBNAME"
        ;;
    2)
        read -p "Enter partial database name: " PARTIAL_DBNAME
        DBNAMES=$(mysql $MYSQL_CREDENTIALS -N -e "SHOW DATABASES LIKE '%$PARTIAL_DBNAME%';")
        if [ -z "$DBNAMES" ]; then
            echo "No databases found with partial name: $PARTIAL_DBNAME"
            exit 1
        fi
        for DBNAME in $DBNAMES; do
            convert_database "$DBNAME"
        done
        ;;
    3)
        DBNAMES=$(mysql $MYSQL_CREDENTIALS -N -e "SHOW DATABASES;")
        for DBNAME in $DBNAMES; do
            convert_database "$DBNAME"
        done
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo "All requested databases have been converted."
