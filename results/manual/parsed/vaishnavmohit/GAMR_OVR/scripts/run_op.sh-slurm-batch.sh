#!/bin/bash
#SBATCH --account=carney-tserre-condo
#SBATCH --output=../../slurm/stanford/%j.out
#SBATCH --error=../../slurm/stanford/%j.err
#SBATCH --mail-user=mohit_vaishnav@brown.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=20G
#SBATCH --time=20:00:00
#SBATCH --constraint=quadrortx

export NCCL_DEBUG='INFO'
export NCCL_IB_DISABLE='1'
export PYTHONFAULTHANDLER='1'
export NEPTUNE_API_TOKEN='eyJhcGlfYWRkcmVzcyI6Imh0dHBzOi8vdWkubmVwdHVuZS5haSIsImFwaV91cmwiOiJodHRwczovL3VpLm5lcHR1bmUuYWkiLCJhcGlfa2V5IjoiODgwMGZmNjktNWMyYS00NjViLWE2MjAtNjY5YWQ1ZmUzNGFmIn0='
export HYDRA_FULL_ERROR='1'

module load cuda/11.1.1 # 
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
name=gamr
gpu=1
b_s=64
key=${1:-Base} # Base or NonTrivial
data_type=${2:-AB} # AB or SD
steps=6 # ${2:-4}
python train_v3.py --config-path=config --config-name=config -m model.architecture=${name} \
                    trainer.gpus=${gpu} trainer.max_epochs=30 training.data_type=${data_type} \
                    training.neptune=False training.optuna=True training.key=${key} \
                    training.nclasses=2 training.batch_size=${b_s} training.task=${task} \
                    training.num_workers=0 model.steps=${steps}
