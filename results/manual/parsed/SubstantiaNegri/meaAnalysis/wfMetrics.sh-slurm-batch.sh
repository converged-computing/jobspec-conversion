#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB
#SBATCH --time=00:05:00

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
for f in $(ls *volt.csv)
	do 
	sbatch -c 1 -t 10 -p short --mem=1G --mail-type=FAIL --wrap="echo $f; ~/scripts/R-3.4.1/wfMetrics.R $f ${f%volt.csv}SD.csv ${f%volt.csv}time.csv"
done
