#!/bin/bash

LOG=~/df.log
H0=~/df
let COUNT=1
let MAX=500
# H is expected to hold the home directory of DF_HACK. This is where you will find the directories data, libs, raw, sdl, etc
# there should also be a 'df' executable script
H=$H0/df_linux1
H1=~/df-ready

mkdir -p $H1

# iterates through $H1/regionX.zip until we find a clear number up to $MAX-1
while [ $COUNT -lt $MAX ];
do
	while [ -f $H1/region$COUNT.zip ]
	do
		echo $H1"/region"$COUNT".zip existed"
		echo $H1"/region"$COUNT".zip existed" >> $LOG
		let COUNT=$COUNT+1
	done
	if [ $COUNT -lt 1 ]; then
		let COUNT=1
	fi
	cd $H
	echo "Iteration "$COUNT" is about to happen..."
	echo "Iteration "$COUNT" is about to happen..." >> $LOG
	sleep 3
	SAVE=`date`
	# feel free to remove "nice -n 20" to use the entire CPU
	nice -n 20 ./df -gen $COUNT RANDOM SMALL_ISLAND_GEN
	SAVE1=`date`
	echo $COUNT" of "$MAX"] START ["$SAVE"] to ["$SAVE1"]"
	echo $COUNT" of "$MAX"] START ["$SAVE"] to ["$SAVE1"]" >> $LOG
	sleep 5
	echo $COUNT" storing ..."
	echo $COUNT" storing ..." >> $LOG
	cd $H/data/save
	zip -r -m -q $H1/region$COUNT.zip region$COUNT/
	cd $H
	zip -m -q $H1/region$COUNT.zip region$COUNT-[0w]*
	du -h $H1/region$COUNT.zip >> $LOG
	echo $COUNT" iteraton stored. Continuing loop."
	echo $COUNT" iteraton stored. Continuing loop." >> $LOG
	sleep 5
	let COUNT=$COUNT+1
done
