#!/bin/bash
#SBATCH --job-name=cnn_validation
#SBATCH --output=cnn_validation.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8GB
#SBATCH --time=01:00:00

module purge ## purge modules that we are not using 
module load python/intel/3.8.6 ## load python module
python ./cnn_validate.py ## run python training script.
echo "Job finished at: `date`" ## print the date and time the job finished
