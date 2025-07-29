#!/bin/bash
#SBATCH --output=single_fouriernetwork64.out
#SBATCH --error=single_fouriernetwork64.err
#SBATCH --mail-user=mnye@college.harvard.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32000
#SBATCH --time=00:40:00
#SBATCH --partition=serial_requeue

module load gcc/4.9.3-fasrc01 tensorflow/0.12.0-fasrc02
python fouriernetwork_odyssey64.py
