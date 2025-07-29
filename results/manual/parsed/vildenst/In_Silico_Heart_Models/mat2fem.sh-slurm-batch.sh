#!/bin/bash
#SBATCH --job-name=mat2fem
#SBATCH --account=nn9249k
#SBATCH --output=mat2fem_out.txt
#SBATCH --error=mat2fem_err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=8

source /cluster/bin/jobsetup
module load matlab
module load python2
module load gcc
python mat2fem.py
