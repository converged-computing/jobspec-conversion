#!/bin/bash
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100M
#SBATCH --time=00:10:00

                                # Or use HH:MM:SS or D-HH:MM:SS, instead of just number of minutes
module load gcc/6.2.0 R/3.4.1
if [ "$1" != "" ]; then
    echo "treatment list provided: ${1} \n well logHz data provided: ${2}"		
    treatmentSamples=$1
	wellLogHzLong=$2
	srun -c 1 -t 30 -p priority --mem=1G ~/scripts/R-3.4.1/bootstrapCohortAssign.R "$treatmentSamples" "$wellLogHzLong" 
else
    echo "Error: Need to provide 2 input files: treatment-samples.csv & well_logHz_long.csv"
fi
