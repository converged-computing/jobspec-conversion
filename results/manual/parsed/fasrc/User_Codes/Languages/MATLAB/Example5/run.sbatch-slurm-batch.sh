#!/bin/bash
#SBATCH --job-name=array_test_rnd
#SBATCH --output=array_test_rnd_%a.out
#SBATCH --error=array_test_rnd_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:00:30
#SBATCH --array=1-3

module load matlab
iseed=$(($SLURM_ARRAY_JOB_ID+$SLURM_ARRAY_TASK_ID))
echo "iseed = $iseed"
srun -c $SLURM_CPUS_PER_TASK matlab -nosplash -nodesktop -nodisplay -r "rnd_test(10, -2, 2, $iseed); exit"
