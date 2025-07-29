#!/bin/bash
#SBATCH --job-name=main_best_hier
#SBATCH --output=logs/slurm_%j.log
#SBATCH --error=logs/slurm_%j.log
#SBATCH --mail-user=bsantraigi@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6000

export CUDA_VISIBLE_DEVICES='0,1'

pwd; hostname; date
module load compiler/intel-mpi/mpi-2019-v5
module load compiler/cuda/10.1
export CUDA_VISIBLE_DEVICES=0,1
mpirun -bootstrap slurm which python
mpirun -bootstrap slurm nvcc --version
mpirun -bootstrap slurm python main_acts.py -embed 175 -heads 7 -hid 91 -l_e1 4 -l_e2 6 -l_d 3 -d 0.071 -bs 16 -e 60 -model HIER++
