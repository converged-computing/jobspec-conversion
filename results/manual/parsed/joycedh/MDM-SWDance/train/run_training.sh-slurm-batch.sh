#!/bin/bash
#SBATCH --job-name=train-mdm-new
#SBATCH --output=/your_location_here/logs/%x_%j.out
#SBATCH --mail-user=youremail@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

export PYTHONPATH='.":$PYTHONPATH'

echo "## Starting MDM run on $HOSTNAME"
DIR=$(pwd)
echo "## Current directory $DIR"
echo "## using python:"
which python
export PYTHONPATH=".":$PYTHONPATH
echo "## Number of available CUDA devices: $CUDA_VISIBLE_DEVICES"
echo "## Checking status of CUDA device with nvidia-smi"
nvidia-smi
echo "## Running training"
CHECKPOINT=/motion-diffusion-model/save/humanml_trans_enc_512/model000200000.pt
SAVEDIR=/motion-diffusion-model/save/swdance/models
python train/train_mdm.py --save_dir=${SAVEDIR} --dataset=swdance \
    --resume_checkpoint=${CHECKPOINT} --overwrite \
    --save_interval=5000 --log_interval=500 \
    # --freeze_layers=0
