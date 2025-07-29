#!/bin/bash
#SBATCH --job-name=jsulpico_train_config-2_logfilt_baseline
#SBATCH --output=jsulpico_results_train_config-2_logfilt_baseline.out
#SBATCH --error=jsulpico_errors_train_config-2_logfilt_baseline.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load shared tensorflow openmpi3/gcc/64/3.0.0
srun --gres=gpu:1 ~/superduperthesis/src/batch-job_train_config-2_logfilt_baseline.py gpu 1000
