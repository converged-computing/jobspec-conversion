#!/bin/bash
#SBATCH --job-name=CNN
#SBATCH --account=edu17.DD2424
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=2

module add cudnn/5.1-cuda-8.0
module load anaconda/py35/4.2.0
source activate tensorflow1.1
jupyter nbconvert --to notebook --ExecutePreprocessor.timeout=300 --execute CNNKaggle.ipynb
source deactivate
