#!/bin/bash
#FLUX: --job-name=swampy-fudge-7705
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --priority=16

fold=$((${SLURM_ARRAY_TASK_ID}-100))
module purge
module load cpuarch/amd
module load pytorch-gpu/py3/1.11.0
PATH=$PATH:~/.local/bin
export PATH
set -x
srun python -u command_line_runner.py --execution_method from_hparams --execution_type fit --global_seed 42 --trainer_config_file trainer_default_config.yaml --trainer_config.logger_version ${SLURM_ARRAY_TASK_ID} --hparams_config_file prevectorized_spd_network_length_21_best_mf1_hparams.yaml --datamodule_config.batch_size 64 --datamodule_config.cross_validation_fold_index $fold
