#!/bin/bash
#SBATCH --job-name=small_batch
#SBATCH --account=cs-charcsi-2019
#SBATCH --output=ch_%A_%a.log
#SBATCH --mail-user=matt.dale@york.ac.uk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10gb
#SBATCH --time=04:00:00
#SBATCH --array=1-20

echo My working directory is `pwd`
echo Running job on host:
echo -e '\t'`hostname` at `date`
echo $SLURM_CPUS_ON_NODE CPU cores available
echo Running array job index $SLURM_ARRAY_TASK_ID, on host:
echo
module load math/MATLAB/2018a
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,0,1,4)'
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,1,1,4)'
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,0,1,6)'
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,1,1,6)'
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,0,1,8)'
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,1,1,8)'
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,0,1,10)'
matlab -r 'viking_charc($SLURM_ARRAY_TASK_ID,1,1,10)'
echo
echo Job completed at `date`
