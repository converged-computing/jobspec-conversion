#!/bin/bash
#SBATCH --job-name=OSP
#SBATCH --output=out.txt
#SBATCH --error=err.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=50000

module load cuda/10.0.130
module load gnu7
module load openmpi3
module load anaconda/3.6
source activate /opt/ohpc/pub/apps/tensorflow_2.0.0
python3.7 -m pip install --user scikit-image
python3.7 -m pip install --user nibabel
cd src
srun -n 1 python3 -m preprocessing.prepare_tfrecords
