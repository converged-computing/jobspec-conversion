#!/bin/bash
#SBATCH --job-name=Preprocess
#SBATCH --output=preprocess.out
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load anaconda/2022.05
source /gpfs/runtime/opt/anaconda/2022.05/etc/profile.d/conda.sh
module load tree
cd finalProject
conda activate finalProject
pip install tqdm
pwd
python create_task.py
