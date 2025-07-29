#!/bin/bash
#SBATCH --output=output/slurm-%j.out
#SBATCH --mail-user=<tiange.zhou@outlook.com>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem=32G
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=4

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp2/resnet101.py
