#!/bin/bash
#FLUX: --job-name=moolicious-bicycle-5023
#FLUX: --queue=priority
#FLUX: -t=300
#FLUX: --urgency=16

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
for f in $(ls *volt.csv)
	do 
	sbatch -c 1 -t 10 -p short --mem=1G --mail-type=FAIL --wrap="echo $f; ~/scripts/R-3.4.1/wfMetrics.R $f ${f%volt.csv}SD.csv ${f%volt.csv}time.csv"
done
