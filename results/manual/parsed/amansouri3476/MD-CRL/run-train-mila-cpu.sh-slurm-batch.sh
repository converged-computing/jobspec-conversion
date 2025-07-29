#!/bin/bash
#SBATCH --output=./slurm_out/mdcrl-%j.out
#SBATCH --error=./slurm_err/mdcrl-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=30G
#SBATCH --time=03:59:00
#SBATCH --partition=long

export WANDB_API_KEY='1406ef3255ef2806f2ecc925a5e845e7164b5eef'
export LD_PRELOAD='/home/mila/s/sayed.mansouri-tehrani/MD-CRL/hack.so'

module load miniconda/3
conda activate mdcrl
export WANDB_API_KEY=1406ef3255ef2806f2ecc925a5e845e7164b5eef
wandb login
export LD_PRELOAD=/home/mila/s/sayed.mansouri-tehrani/MD-CRL/hack.so
python run_training.py trainer.accelerator='gpu' trainer.devices=1 ckpt_path=null model/optimizer=adamw model.optimizer.lr=0.001 datamodule=md_balls model=balls model.z_dim=25 model/autoencoder=resnet18_ae_balls model/scheduler_config=reduce_on_plateau model.scheduler_config.scheduler_dict.monitor="train_loss" logger.wandb.tags=["mila","balls","resnet"] ~callbacks.early_stopping
conda deactivate
module purge
