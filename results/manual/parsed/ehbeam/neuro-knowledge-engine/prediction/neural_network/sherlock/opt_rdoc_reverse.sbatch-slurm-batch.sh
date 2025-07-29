#!/bin/bash
#SBATCH --job-name=op_rdo_reverse
#SBATCH --output=logs/op_rdoc_reverse.%j.out
#SBATCH --error=logs/op_rdoc_reverse.%j.err
#SBATCH --mail-user=ebeam@stanford.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00

module load python/3.6 py-pytorch/1.0.0_py36 viz py-matplotlib/3.1.1_py36
srun python3 opt_rdoc_reverse.py
