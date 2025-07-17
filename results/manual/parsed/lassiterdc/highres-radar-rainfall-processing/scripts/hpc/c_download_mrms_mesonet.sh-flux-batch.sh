#!/bin/bash
#FLUX: --job-name=scruptious-pancake-4326
#FLUX: --queue=standard
#FLUX: -t=259200
#FLUX: --urgency=16

source __utils.sh
source __directories.sh
mkdir -p ${assar_dirs[repo]}${assar_dirs[raw_mrms]}
cd ${assar_dirs[repo]}${assar_dirs[raw_mrms]}
YEARS=$(seq 2015 2022)
HOURS=$(seq 0 23)
MINUTES=$(seq 0 2 58)
for YEAR in ${YEARS}
do
	year=${YEAR}
	determine_month_and_day ${YEAR} ${SLURM_ARRAY_TASK_ID}
	month=${array_out[0]}
	day=${array_out[1]}
	# loop through all hours and minutes of this day in $year and download and unzip data
	if [[ $month != "NULL" ]] && [[ $day != "NULL" ]] # not day 366 of a year with only 365 days
	then
		for HOUR in ${HOURS} # loop through all hours
		do
			if [ ${HOUR} -lt 10 ]
			then
				hour=0${HOUR}
			else
				hour=${HOUR}
			fi
			for MINUTE in ${MINUTES} # loop through all minutes
			do
				if [ ${MINUTE} -lt 10 ]
				then
					minute=0${MINUTE}
				else
					minute=${MINUTE}
				fi
				# start timer at 0
				SECONDS=0
				DATETIME=${year}${month}${day}-${hour}${minute}
				FILE=*"${DATETIME}"*".grib2"
				# if the .grib file does not exist, download it
				if ! compgen -G "$FILE" > /dev/null; then
					wget -q -c https://mtarchive.geol.iastate.edu/${year}/${month}/${day}/mrms/ncep/PrecipRate/PrecipRate_00.00_${DATETIME}00.grib2.gz
					downloaded="was"
					# echo "Downloaded data for datetime: ${DATETIME}"
				else
					# echo ".grib file already exists for datetime: ${DATETIME}"
					downloaded="was not"
				fi
				# if a .gz file exist, unzip it
				FILE=*"${DATETIME}"*".gz"
				if compgen -G "$FILE" > /dev/null; then
					gunzip $FILE
					# echo "Unzipped .gz file for datetime: ${DATETIME}"
					unzipped="was"
				else
					# echo "No .gz file present for datetime: ${DATETIME}"
					unzipped="was not"
				fi
				duration=$SECONDS
				echo "Processed datetime ${DATETIME}; Time elapsed: $(($duration / 60)) minutes and $(($duration % 60)) seconds; file $downloaded downloaded and $unzipped unzipped."
			done
		done
	fi
done
