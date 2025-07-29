#!/bin/bash
#SBATCH --job-name=multi
#SBATCH --output=m_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=7
#SBATCH --mem=10G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-7

module purge
module load python
module load gcc
module load boost
module load matlab
module load anaconda
set -e
date
source activate py2
echo $nMethod
method=$(($SLURM_ARRAY_TASK_ID-1))
if [ $SLURM_ARRAY_TASK_ID == $nMethod ]; then
    ./multi -d $method --tIn=1
    echo "output tIncome with method $method"
else
    ./multi -d $method
fi
date
hostname
