#!/bin/bash
#SBATCH --job-name=HIER_marco
#SBATCH --output=logs/slurm_%j.log
#SBATCH --error=logs/slurm_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=23000
#SBATCH --partition=gpu
#SBATCH --nodelist=gpu016

export CUDA_VISIBLE_DEVICES='0'

pwd; hostname; date
module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
source /home/$USER/.bashrc
export CUDA_VISIBLE_DEVICES=0
nvidia-smi
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python -u train_generator.py --option train --model model/ --batch_size 384 --max_seq_length 50 --act_source bert --learning_rate 1e-4 --nlayers_e 6 --nlayers_d 3 --seed 0
