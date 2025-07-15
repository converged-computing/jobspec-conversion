#!/bin/bash
#FLUX: --job-name=chocolate-bike-4168
#FLUX: -t=72000
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export NCCL_IB_DISABLE='1'
export PYTHONFAULTHANDLER='1'
export NEPTUNE_API_TOKEN='eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vdWkubmVwdHVuZS5haSIsImFwaV91cmwiOiJodHRwczovL3VpLm5lcHR1bmUuYWkiLCJhcGlfa2V5IjoiODgwMGZmNjktNWMyYS00NjViLWE2MjAtNjY5YWQ1ZmUzNGFmIn0='
export HYDRA_FULL_ERROR='1'

module load cuda/10.2 # 11.1.1 # 
source ../../env/visreason/bin/activate
module load python/3.7.4
export NCCL_DEBUG=INFO
export NCCL_IB_DISABLE=1
export PYTHONFAULTHANDLER=1
echo $CUDA_VISIBLE_DEVICES
export NEPTUNE_API_TOKEN="eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vdWkubmVwdHVuZS5haSIsImFwaV91cmwiOiJodHRwczovL3VpLm5lcHR1bmUuYWkiLCJhcGlfa2V5IjoiODgwMGZmNjktNWMyYS00NjViLWE2MjAtNjY5YWQ1ZmUzNGFmIn0="
export HYDRA_FULL_ERROR=1
r=$((1 + $RANDOM % 5))
echo $r
name=${2:-gamr} # gamr_resnet34
gpu=1
b_s=50
key=${1:-familiar_high} # 'familiar_high', 'novel_low', 'novel_high', 'familiar_low'
python train_v3.py --config-path=config --config-name=config -m model.architecture=${name} \
                    trainer.gpus=${gpu} trainer.max_epochs=100 \
                    training.neptune=False training.optuna=True training.key=${key} \
                    training.nclasses=4 training.batch_size=${b_s} training.task=${task} \
                    training.num_workers=0 datamodule=data_barense_stimuli_all model_optuna=model_v3_freeze
                    # model.steps=${steps}
