#!/bin/bash
#SBATCH --mail-user=jwravenscroft1@sheffield.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16000
#SBATCH --time=1-00:00:00

module load Anaconda3/5.3.0
module load fosscuda/2019b  # includes GCC 8.3
module load imkl/2019.5.281-iimpi-2019b
module load CMake/3.15.3-GCCcore-8.3.0
source activate speechbrain
srun --export=ALL python3 create_whamr_rirs.py --output-dir ~/fastdata/data/whamr/rirs
