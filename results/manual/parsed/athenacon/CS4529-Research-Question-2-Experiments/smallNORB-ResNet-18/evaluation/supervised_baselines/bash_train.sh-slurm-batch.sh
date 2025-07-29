#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --mail-user=u16ak20@abdn.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --time=6-06:00:00
#SBATCH --constraint=ntasks-per-node=1

nvidia-smi
module load miniconda3
conda activate testenv
which python
python --version
srun /home/u16ak20/.conda/envs/testenv/bin/python main.py --dataset=smallnorb --name=resnet_self_routing --epochs=350                                  
