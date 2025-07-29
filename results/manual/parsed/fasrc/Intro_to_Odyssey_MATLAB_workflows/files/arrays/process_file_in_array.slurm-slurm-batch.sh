#!/bin/bash
#SBATCH --job-name=process_file_in_array
#SBATCH --output=process_file_in_array_%A_%a.out
#SBATCH --error=process_file_in_array_%A_%a.err
#SBATCH --mail-user=robertfreeman@g.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=00:00:15
#SBATCH --partition=serial_requeue

source new-modules.sh
module load matlab
sleep $(( ( RANDOM % $SLURM_ARRAY_TASK_ID )  + 1 ))
matlab -nojvm -nodisplay -nosplash -r "process_file_in_array('$1', $SLURM_ARRAY_TASK_ID); exit"
