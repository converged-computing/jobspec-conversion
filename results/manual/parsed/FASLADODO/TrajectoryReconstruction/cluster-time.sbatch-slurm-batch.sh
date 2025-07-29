#!/bin/bash
#SBATCH --job-name=slurm_%j
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-user=skp454@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --mem=100GB
#SBATCH --time=7-00:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python3/intel/3.6.3
source ~/bigdata/bdpy/bin/activate
python LinearInterpolationTime.py  > printTime.txt
