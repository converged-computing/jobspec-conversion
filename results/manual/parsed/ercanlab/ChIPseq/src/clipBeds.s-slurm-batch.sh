#!/bin/bash
#SBATCH --job-name=bedClip
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=00:15:00

module purge
module load kent/intel/20170111
val=$SLURM_ARRAY_TASK_ID
file=`sed -n ${val}p files.txt`
mv $file temp${val}.bed
bedClip temp${val}.bed /scratch/cgsb/ercan/annot/forBowtie/WS220.genome $file
rm temp${val}.bed
exit 0;
