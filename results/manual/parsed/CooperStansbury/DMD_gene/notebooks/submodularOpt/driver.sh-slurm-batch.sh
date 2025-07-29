#!/bin/bash
#SBATCH --job-name=soss2015
#SBATCH --account=indikar0
#SBATCH --mail-user=jpic@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1,3,5,10,15,20,25,30,50,70,100

module load matlab
echo $1
echo $2
echo $3
matlab -nodisplay -r "addpath(genpath(pwd)); driver($1, $SLURM_ARRAY_TASK_ID, 100, $2, $3)"
