#!/bin/bash
#FLUX: --job-name=eccentric-puppy-6305
#FLUX: --queue=standard
#FLUX: -t=172800
#FLUX: --urgency=16

source __utils.sh
source __directories.sh
mkdir -p ${assar_dirs[repo]}${assar_dirs[raw_mrms_quantized]}
cd ${assar_dirs[repo]}${assar_dirs[raw_mrms_quantized]}
YEARS=$(seq 2012 2014)
for YEAR in ${YEARS}
do
	year=${YEAR}
	determine_month_and_day ${YEAR} ${SLURM_ARRAY_TASK_ID}
	month=${array_out[0]}
	day=${array_out[1]}
  # loop through all hours and minutes of this day in $year and download and unzip data
  HOURS=$(seq 0 23)
  MINUTES=$(seq 0 1 59)
  url1='https://mesonet.agron.iastate.edu/cgi-bin/request/raster2netcdf.py?dstr='
  url2='&prod=mrms_a2m'
  # source for URL: https://mesonet.agron.iastate.edu/GIS/rasters.php?rid=3
	if [[ $month != "NULL" ]] && [[ $day != "NULL" ]] # not day 366 of a year with only 365 days
	then   
    # loop through all hours and minutes
		for HOUR in ${HOURS}
		do
			if [ ${HOUR} -lt 10 ]
			then
				hour=0${HOUR}
			else
				hour=${HOUR}
			fi
			for MINUTE in ${MINUTES} # minutes
			do
				if [ ${MINUTE} -lt 10 ]
				then
					minute=0${MINUTE}
				else
					minute=${MINUTE}
				fi
				# download file only if it is not there
				## check if the file already exits
				datetime=${year}${month}${day}${hour}${minute}
				FILE="a2m_${datetime}.nc"
				echo "File being processed: $FILE"
				# Download the file only if it doesn't exist
				# source: https://stackoverflow.com/questions/6363441/check-if-a-file-exists-with-a-wildcard-in-a-shell-script
				if compgen -G "$FILE" > /dev/null; then
					echo "already downloaded data for ${year}${month}${day}-${hour}${minute}"
				else
					# echo "File does not exist! Downloading..."
					full_url=${url1}${datetime}${url2}
					wget -q -c -O a2m_${datetime}.nc ${full_url}
					echo "downloaded data for ${year}${month}${day}-${hour}${minute}"
				fi
				# echo "done!"
				find . -name "$FILE" -type f -size -2k -delete # delete file if it is below 2kilobytes
			done
		done
	fi
done
