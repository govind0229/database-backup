#!/bin/bash
# Shell script to backup MySQL database
# Created By Govind Sharma
set -e

MyUSER="root"	# DB_USERNAME
MyPASS="govind"	# DB_PASSWORD
MyHOST="localhost"	# DB_HOSTNAME
DEST="/home/govind"
DAYS=10
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"
YER="$(date +"%Y")"
MON="$(date +"%m")"
NOW="$(date +"%d")"
MBD="$DEST/$YER/$MON/$NOW/"
install -C -d $MBD
chmod 777 $MBD;

# Skip database list
SKIP="information_schema mysql performance_schema"

DBL="$($MYSQL -h $MyHOST -u $MyUSER -p$MyPASS -Bse 'show databases')"

for db in $DBL
do
    skipdb=-1
        if [ "$SKIP" != "" ];
            then
                for i in $SKIP
                    do
                        [ "$db" == "$i" ] && skipdb=1 || :
                    done
        	fi
            	if [[ -f "$MBD/$db.sql.gz" ]]; then
                	echo "$db database backup exist"
        	else
            	if [ "$skipdb" == "-1" ] ; then
                	echo "$db database Backup start";
	                FILE="$MBD/$db.sql"
	                $MYSQLDUMP -h $MyHOST -u $MyUSER -p$MyPASS $db > $FILE
	                $GZIP $FILE
            fi
        fi
done

# Remove old files
cd $DEST/$YER/$MON/
find $NOW -mtime +$DAYS -exec rm -f {} \;
