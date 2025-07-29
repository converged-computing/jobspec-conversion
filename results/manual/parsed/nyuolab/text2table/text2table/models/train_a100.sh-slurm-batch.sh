#!/bin/bash
#SBATCH --job-name=text2table
#SBATCH --output=/gpfs/data/oermannlab/users/yangz09/summer/text2table/log/text2table.out
#SBATCH --error=/gpfs/data/oermannlab/users/yangz09/summer/text2table/log/text2table.err
#SBATCH --mail-user=ZihaoGavin.Yang@nyulangone.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=96
#SBATCH --gres=gpu:a100:8
#SBATCH --mem=800G
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=1

echo "hostname:"
hostname
source ~/.bashrc
echo "setup env"
pwd
nvidia-smi
module load cuda/11.4 gcc/9.3.0 nccl
conda activate text2table
which deepspeed
deepspeed --hostfile /gpfs/data/oermannlab/users/yangz09/summer/text2table/text2table/hostfile --num_gpus=8 --num_nodes=3 train_model.py
