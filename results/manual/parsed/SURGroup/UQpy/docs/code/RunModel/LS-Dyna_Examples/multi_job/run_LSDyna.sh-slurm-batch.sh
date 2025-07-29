#!/bin/bash
#SBATCH --job-name=UQpy_LSDyna_Test_Parallel
#SBATCH --mail-user=michael.shields@jhu.edu
#SBATCH --mail-type=end
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=parallel
#SBATCH --constraint=ntasks-per-node=24

module load ls-dyna/10.1.0
module load python
module load parallel
python dyna_model.py
