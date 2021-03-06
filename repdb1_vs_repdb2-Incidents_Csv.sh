#!/usr/bin/env bash

# This script pulls a row count for the Incidents_Csv table on both repdb1 and repdb2 and makes a comparison

QUERY1="select count(CONCAT(org_id, \"-\", incident_id, \"-\", start_time)) from Incidents_Csv"


printf "\n\n========================================\n Table: Incidents_Csv \n\n *** repdb1 ***:\n"
DB1=$(mysql -h 10.10.12.34 -D vo_reports_data_warehouse -u reports -se "$QUERY1");
echo "COUNT: "$DB1
printf "\n *** repdb2 ***\n"
DB2=$(mysql -h 10.10.12.35 -D vo_reports_data_warehouse -u reports -se "$QUERY1");
echo "COUNT: "$DB2

if [[ $DB1 -ne $DB2 ]]
then
	DIFF=$(( $DB1 - $DB2 ))
	ABS_OF_DIFF=${DIFF#-}

	printf "!!!--------- DISCREPANCY FOUND ---------!!!"
	echo Difference = $ABS_OF_DIFF
	printf "-------------------------------------------"
else 
	printf "\nNo discrepancy found\n"
fi