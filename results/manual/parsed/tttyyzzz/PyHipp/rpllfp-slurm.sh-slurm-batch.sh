#!/bin/bash
#SBATCH --job-name=rpllfp
#SBATCH --output=rpllfp-slurm.%N.%j.out
#SBATCH --error=rpllfp-slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

<<<<<<< HEAD
=======
>>>>>>> upstream/main
python -u -c "import PyHipp as pyh; \
import time; \
pyh.RPLLFP(saveLevel=1); \
print(time.localtime());"
<<<<<<< HEAD
=======
>>>>>>> upstream/main
