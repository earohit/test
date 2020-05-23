#!/bin/bash
PASS=0
TOTAL_TESTS=5
SCORE=0

echo "describe keyspaces;" | cqlsh > keyspaces.txt
if(($(grep -io "cycling" keyspaces.txt | wc -l)==1)); then PASS=$((PASS+1)); fi;

echo "describe tables;" | cqlsh > tables.txt
if(($(grep -io "cyclist_details" tables.txt | wc -l)==1)); then PASS=$((PASS+1)); fi;

echo "describe table cycling.cyclist_details;" | cqlsh > tableinfo.txt
if(($(grep -io -e "id" -e "name" tableinfo.txt | wc -l)>=2)); then PASS=$((PASS+1)); fi;

echo "select * from cycling.cyclist_details;" | cqlsh > details.txt
if(($(grep -io -e "id" -e "name" -e 1 -e "Raichel" -e 2 -e "Alex" -e 3 -e "Ellen" details.txt | wc -l)>=8)); then PASS=$((PASS+1)); fi;

if(($(grep -io -e "id" -e "name" -e 1 -e "Raichel" -e 2 -e "Alex" -e 3 -e "Ellen" cyclers.csv | wc -l)>=8)); then PASS=$((PASS+1)); fi;


echo $PASS
SCORE=$((PASS*100 / TOTAL_TESTS))
echo "FS_SCORE:$SCORE%"