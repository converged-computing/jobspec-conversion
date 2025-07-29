#!/bin/bash
#SBATCH --output=exelogs/gpu_monet_seeder.%A_%a.out
#SBATCH --error=exelogs/gpu_monet_seeder.%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000
#SBATCH --time=1-16:00:00
#SBATCH --qos=gpu
#SBATCH --constraint=ntasks-per-node=1

module purge
module load gcc cuda cudnn mvapich2 openblas
deactivate
source ~/lpdi_fs/masif/tensorflow-1.12/bin/activate
./train_nn.sh nn_models.sc05.all_feat.custom_params.py
