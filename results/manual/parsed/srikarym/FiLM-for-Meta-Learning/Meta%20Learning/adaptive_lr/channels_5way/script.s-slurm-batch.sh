#!/bin/bash
#SBATCH --job-name=ch_5
#SBATCH --output=slurm_ch_5.out
#SBATCH --mail-user=msy290@nyu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50GB
#SBATCH --time=1-16:00:00
#SBATCH --constraint=ntasks-per-node=10

cd /scratch/msy290/maml_less_grad_adaptive_lr/channels_5way/
module load cudnn/8.0v6.0
module load cuda/8.0.44
module load tensorflow/python3.6/1.3.0
python main.py --datasource=omniglot --metatrain_iterations=40000 --meta_batch_size=32 --update_batch_size=1 --num_classes=5 --update_lr=0.4  --num_updates=1 --logdir=logs/omniglot5way/ --train=False --test_set=True >> log_test.txt
