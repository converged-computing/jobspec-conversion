#!/bin/bash
#SBATCH --job-name=mmsrl
#SBATCH --account=lco@gpu
#SBATCH --output=/gpfswork/rech/lco/url46ht/outputs/ofa_seq2seq_%j_%x_%A_%a.out
#SBATCH --error=/gpfswork/rech/lco/url46ht/outputs/ofa_seq2seq_%j_%x_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --constraint=v100-32g,ntasks-per-node=1
#SBATCH --array=0-11

export DATA_PATH='$WORK/data'

set -x
cd $WORK/mmsrl
module purge
source ~/.bashrc
conda activate pytorch
export DATA_PATH=$WORK/data
base_config=(""
             "--ofa_path=OFA/checkpoints/ofa_base.pt"
             "--weight_decay=0.01"
             "--ofa_path=OFA/checkpoints/ofa_base.pt --weight_decay=0.01")
base_name=("s2s_vqa_large"
           "s2s_base"
           "s2s_vqa_large_ddecay"
           "s2s_base_ddecay")
iconfig=$(($SLURM_ARRAY_TASK_ID%4))
config=${base_config[$iconfig]}
name=${base_name[$iconfig]}
python -m mmsrl.train configs/ofa_ours.py configs/ofa_vqa.py configs/ofa_seq2seq.py --patience=26 $config --output_val=\"$WORK/outputs/val_${name}_${SLURM_ARRAY_TASK_ID}.pkl\" --output_test=\"$WORK/outputs/test_${name}_${SLURM_ARRAY_TASK_ID}.pkl\"
