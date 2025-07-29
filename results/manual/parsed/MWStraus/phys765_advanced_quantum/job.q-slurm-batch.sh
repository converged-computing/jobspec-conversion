#!/bin/bash
#SBATCH --job-name=AQM
#SBATCH --output=%x-%a.out
#SBATCH --error=slurm.err
#SBATCH --mail-user=jiyong.yu@duke.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --partition=brownlab-gpu,common,scavenger
#SBATCH --array=1-1

source ~/miniconda3/etc/profile.d/conda.sh
conda activate base                             # Update this field to tne conda environment you wish to use for the run
python problem1_pure_python_parallel_zoom_sections.py # Ex if you have two parameters for every job, so it's ${pA[0]} ${pA[1]}
