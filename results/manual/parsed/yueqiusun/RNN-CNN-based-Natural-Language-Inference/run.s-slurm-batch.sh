#!/bin/bash
#SBATCH --job-name=nlp
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=bob.smith@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30GB
#SBATCH --time=18:00:00
#SBATCH --constraint=ntasks-per-node=1

for mul in  0
do
python main.py --model RNN --num_epochs 10 --hidden_size 200 --kernel_size 3 --mul $mul --learning_rate 0.001 --dropout -1 --save_model 1
done
