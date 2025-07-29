#!/bin/bash
#SBATCH --job-name=tensorflow_gpu_sample
#SBATCH --output=tensorflow_gpu_sample_output_%j.out
#SBATCH --error=tensorflow_gpu_sample_error_%j.err
#SBATCH --mail-user=gy4065@wayne.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=160G
#SBATCH --time=1-00:00:00
#SBATCH --partition=gpu

echo "Converting notebook to script"
jupyter nbconvert --to python tensorflow_gpu_sample.ipynb
echo "Setting up python version and conda shell"
ml python/3.7
source /wsu/el7/pre-compiled/python/3.7/etc/profile.d/conda.sh
echo "Activating conda environment"
conda activate tensorflow-gpu-v2.8
echo "Running simulation"
python -u tensorflow_gpu_sample.py
