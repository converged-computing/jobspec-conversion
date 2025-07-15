#!/bin/bash
#FLUX: --job-name=hairy-lamp-7962
#FLUX: --priority=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$4" != "" ]; then
	echo "cluster count pairs file provided ${1}
		recDur provided: ${2}
		DeltaT provided: ${3}
		iterations provided: ${4}
		output file name provided: ${5}"
	Date=$(date '+%Y-%m-%d')
	clusterCountFile=$1
	recDur=$2	
	DeltaT=$3
	iterations=$4
	if [ "$5" != "" ]; then
        outputFile=$5
        else
        outputFile=${Date}_sttcSimulation.csv
        fi
	touch $outputFile
	while read -r LINE;
 		do IFS=\, read -a clusterCounts <<< "$LINE";
 		sbatch -n 1 -t 1 -p short --mem=100M ~/scripts/R-3.4.1/sttcSim.R ${clusterCounts[@]} "$recDur" "$DeltaT" "$iterations" "$outputFile";
 		done < "$clusterCountFile"
else 
	echo "Error: Need to provide following inputs: 
		* cluster count pairs file
		* recDur - duration interval (seconds) of recording to assess STTC
		* DeltaT - time interval (seconds) around each firing event to use in calculation of STTC
		* iterations - number of iterations of STTC calculation to simulate"
fi
