#!/bin/bash
#FLUX: --job-name=eccentric-peanut-4507
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
r=$((1 + $RANDOM % 10))
echo $r
name=gamr
gpu=1
key=${1:-familiar_high}
b_s=300
steps=${2:-4}
lr=${3:-.00005}
w_d=${4:-.0001}
python train_v3.py --config-path=config --config-name=config model.architecture=${name} \
                    trainer.gpus=${gpu} trainer.max_epochs=500 \
                    training.neptune=False training.optuna=False training.key=${key} \
                    training.nclasses=4 training.batch_size=${b_s} \
                    training.num_workers=0 model.steps=${steps} model_optuna.lr=${lr} \
                    model_optuna.weight_decay=${w_d} 
