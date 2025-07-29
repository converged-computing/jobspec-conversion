#!/bin/bash
#SBATCH --job-name=freq
#SBATCH --output=freq-slurm.%N.%j.out
#SBATCH --error=freq-slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

python -u -c "import PyHipp as pyh; \
import time; \
pyh.FreqSpectrum(saveLevel=1); \
pyh.FreqSpectrum(loadHighPass=True, pointsPerWindow=3000, saveLevel=1);\
print(time.localtime());"
