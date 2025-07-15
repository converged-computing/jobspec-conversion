#!/bin/bash
#FLUX: --job-name=frigid-rabbit-6576
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$5" != "" ]; then
	echo "
		active cluster pairs file provided: ${1}
		revised clustered waveforms file provided: ${2}
		Tinit provided: ${3}
		recDur provided: ${4}
		DeltaT provided: ${5}
		output file provided: ${6}"
	Date=$(date '+%Y-%m-%d')
	clusterPairFile=$1
	clusteredWFfile=$2	
	Tinit=$3
	recDur=$4
	DeltaT=$5
	if [ "$6" != "" ]; then
	outputFile=$6
        touch $outputFile
	else
	outputFile=${Date}_sttc.csv
	touch ${Date}_sttc.csv
	fi
	while read -r LINE;
 		do IFS=\, read -a cols <<< "$LINE";
 		sbatch -n 1 -t 3 -p short --mem=2G ~/scripts/R-3.4.1/sttc.R ${cols[@]} "$Tinit" "$recDur" "$DeltaT" "$clusteredWFfile" "$outputFile";
 		done < "$clusterPairFile"
else 
	echo "Error: Need to provide following inputs: 
		* active cluster pairs file
		* revised clustred waveform file
		* Tinit - timestamp (seconds) within recording to begin caclculating STTC
		* recDur - duration interval (seconds) of recording to assess STTC
		* DeltaT - time interval (seconds) around each firing event to use in calculation of STTC"
fi
