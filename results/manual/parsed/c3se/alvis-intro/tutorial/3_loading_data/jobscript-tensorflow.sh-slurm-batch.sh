#!/bin/bash
#SBATCH --job-name=Data TensorFlow
#SBATCH --account=NAISS2024-22-219
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

ml purge
ml TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
ml matplotlib/3.5.2-foss-2022a
ml JupyterLab/3.5.0-GCCcore-11.3.0
ipython -c "%run data-tensorflow.ipynb"
