#!/bin/bash
#SBATCH --job-name=Python_job
#SBATCH --mail-user=im1247@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --time=01:40:00

module purge
module load pytorch/python2.7/0.3.0_4
module load pytorch/python2.7/0.3.0_4
module load gcc/6.3.0
pip install torchwordemb --user
srun python train.py train.out
