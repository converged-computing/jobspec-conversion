#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=2

module unload nvidia/cuda/10.0
module load nvidia/cuda/10.2
cd $SLURM_SUBMIT_DIR
HOST=$(scontrol show hostname $SLURM_NODELIST | head -n1)
srun python main.py --host $HOST --port 29500
