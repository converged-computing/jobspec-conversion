#!/bin/bash
#SBATCH --job-name=HIER_marcoAct
#SBATCH --output=logs/slurm_%j.log
#SBATCH --error=logs/slurm_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=23000
#SBATCH --nodelist=gpu005

export CUDA_VISIBLE_DEVICES='0'

pwd; hostname; date
module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
export CUDA_VISIBLE_DEVICES=0
nvidia-smi
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python train_generator.py --option train --model modelAct/ --batch_size 512 --max_seq_length 50 --act_source pred --learning_rate 1e-4 --nlayers_e 3 --nlayers_d 3 --seed 0
