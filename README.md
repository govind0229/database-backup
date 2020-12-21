# database-backup

## All database backup script automation.

### This script is used for take dump all available databases. 

`SKIP` = add database name which database no need take dump. 

        `like`;
                `SKIP="information_schema mysql performance_schema"`

### Days is used for delete old backup files from server. You can change days as per your requirement.

        DAYS = 10 #Default value;

### DEST is destination where you take backup. you can change accordinagle. 

        DEST="/home/govind" #Default location;

``Thank you``
