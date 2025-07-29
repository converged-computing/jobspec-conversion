#!/bin/bash
#SBATCH --output=/nfs/home1/swooning/slurm_output/out_%j.log
#SBATCH --error=/nfs/home1/swooning/slurm_output/error_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

module load 2019
module load Miniconda2
module load CUDA/10.0.130
module load cuDNN/7.6.3-CUDA-10.0.130
pip install --user tensorflow
pip install --user tensorflow-gpu
pip install --user keras
pip install --user Pillow
pip install --user pathlib
pip install --user pandas
source activate env
python /nfs/home1/swooning/DataLowMem12.py
mv *.png /nfs/home1/swooning/testing
mv *.h5 /nfs/home1/swooning/testing
mv *.hp5y /nfs/home1/swooning/testing
