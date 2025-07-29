#!/bin/bash
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:8
#SBATCH --mem=24gb
#SBATCH --time=08:00:00
#SBATCH --partition=hpg-ai
#SBATCH --constraint=ntasks-per-node=1

export MASTER_ADDR='$(hostname)'

module load conda
conda activate torch-timm
ip1=`hostname -I | awk '{print $2}'`
echo $ip1
export MASTER_ADDR=$(hostname)
echo "r$SLURM_NODEID master: $MASTER_ADDR"
echo "r$SLURM_NODEID Launching python script"
srun python train.py --nodes=2 --ngpus 8 --ip_adress $ip1 --epochs 10
