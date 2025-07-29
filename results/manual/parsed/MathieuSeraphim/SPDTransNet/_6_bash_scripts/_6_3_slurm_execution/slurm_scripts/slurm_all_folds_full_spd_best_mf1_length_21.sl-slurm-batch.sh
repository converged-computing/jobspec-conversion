#!/bin/bash
#SBATCH --job-name=all_folds_full_spd_best_mf1_length_21
#SBATCH --account=wpd@a100
#SBATCH --output=log/index_%a.job_%x.job_id_%j.master_id_%A.array_id_%a.out
#SBATCH --error=log/index_%a.job_%x.job_id_%j.master_id_%A.array_id_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --constraint=a100
#SBATCH --array=100-130

fold=$((${SLURM_ARRAY_TASK_ID}-100))
module purge
module load cpuarch/amd
module load pytorch-gpu/py3/1.11.0
PATH=$PATH:~/.local/bin
export PATH
set -x
srun python -u command_line_runner.py --execution_method from_hparams --execution_type fit --global_seed 42 --trainer_config_file trainer_default_config.yaml --trainer_config.logger_version ${SLURM_ARRAY_TASK_ID} --hparams_config_file prevectorized_spd_network_length_21_best_mf1_hparams.yaml --datamodule_config.batch_size 64 --datamodule_config.cross_validation_fold_index $fold
