#!/bin/bash
#SBATCH --job-name=NWSimImp
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --time=2-12:30:00
#SBATCH --constraint=el7
#SBATCH --array=1-16

config=/nfs/stak/users/phatakg/ResearchCode/Sunbelt23/Code/bashScripts/config.txt
sim=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
type=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
module load gcc/12.2
module load R/4.2.2
Rscript ../NWSimulationGen.R ${sim} ${type}
