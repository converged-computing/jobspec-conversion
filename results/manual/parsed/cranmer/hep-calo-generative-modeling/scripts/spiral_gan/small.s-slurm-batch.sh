#!/bin/bash
#SBATCH --job-name=small
#SBATCH --output=small_%j.out
#SBATCH --error=small_%j.err
#SBATCH --mail-user=akp258@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50GB
#SBATCH --time=1-06:00:00

module purge
module load cuda/8.0.44
module load cudnn/8.0v5.1
module load pillow/intel/4.0.0
module load h5py/intel/2.7.0rc2
module load tensorflow/python2.7/20170218
module load scikit-image/intel/0.12.3
cd /scratch/akp258/udon/scripts/spiral_gan/
python -u small.py small.cfg
