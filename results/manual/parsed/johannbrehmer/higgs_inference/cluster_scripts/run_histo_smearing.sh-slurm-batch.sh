#!/bin/bash
#SBATCH --job-name=histo-smearing
#SBATCH --output=slurm_histo_smearing.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --time=2-00:00:00

module purge
module load jupyter-kernels/py2.7
module load scikit-learn/intel/0.18.1
cd /home/jb6504/higgs_inference/higgs_inference
python -u experiments.py histo --smearing --neyman -x 1 41 -o neyman2 asymmetricbinning
