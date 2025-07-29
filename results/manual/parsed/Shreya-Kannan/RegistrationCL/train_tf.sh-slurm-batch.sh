#!/bin/bash
#SBATCH --account=rrg-punithak
#SBATCH --mail-user=skannan3@ualberta.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem-per-cpu=32G
#SBATCH --time=1-11:00:00

module load python
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install voxelmorph
pip install tensorflow
pip install numpy==1.23.5
pip install "nibabel<5"
NOW=$(date '+%Y%m%d%H%M%S')
python /home/shreya/scratch/train_tf_nmi.py
