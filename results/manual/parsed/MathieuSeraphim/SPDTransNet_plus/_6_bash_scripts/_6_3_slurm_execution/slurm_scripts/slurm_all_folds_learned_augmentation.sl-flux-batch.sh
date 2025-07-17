#!/bin/bash
#FLUX: --job-name=all_folds_learned_augmentation
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

fold=$((${SLURM_ARRAY_TASK_ID}-100))
module purge
module load cpuarch/amd
module load pytorch-gpu/py3/1.11.0
PATH=$PATH:~/.local/bin
export PATH
set -x
srun python -u command_line_runner.py --execution_method from_hparams --execution_type fit --global_seed 42 --trainer_config_file trainer_default_config.yaml --trainer_config.logger_version ${SLURM_ARRAY_TASK_ID} --trainer_add_callback_config_file LearnedAugmentationFinetuning_no_unfreeze_delay.yaml --hparams_config_file learned_augmentation_IITNet_without_delayed_finetuning_hparams.yaml --model_config.cross_validation_fold_index $fold --datamodule_config.batch_size 4 --datamodule_config.cross_validation_fold_index $fold
