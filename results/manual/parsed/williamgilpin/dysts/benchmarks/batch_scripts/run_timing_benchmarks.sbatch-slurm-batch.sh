#!/bin/bash
#SBATCH --job-name=benchmarks
#SBATCH --account=PHY22025
#SBATCH --output=benchmarks_timing.out
#SBATCH --error=benchmarks_timing.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=02:30:00
#SBATCH --partition=normal

conda init bash
conda info --envs
echo $PATH
source ~/work/miniconda3/etc/profile.d/conda.sh
conda activate dysts
echo $CONDA_DEFAULT_ENV
echo $CONDA_PREFIX
python timing_benchmarks2.py
