#!/bin/bash
#SBATCH --job-name=timAhcal_valid
#SBATCH --mail-user=chirayu.gupta@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=100g
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

folder="/home/chirayugupta/test"
module load cdac/spack/0.17
source /home/apps/spack/share/spack/setup-env.sh
spack load python@3.8.2
source /home/apps/iiser/pytorch-venv/bin/activate
/home/chirayugupta/DRN/The_DRN_for_HGCAL/train $folder /home/chirayugupta/pickles/AToGG_pickles_1M_good --nosemi --idx_name all --target trueE --in_layers 3 --mp_layers 4 --out_layers 2  --agg_layers 2 --valid_batch_size 100 --train_batch_size 100  --lr_sched Const --max_lr 0.0001 --pool mean --hidden_dim 128 --n_epochs 100 &>> $folder/training.log
