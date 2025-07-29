#!/bin/bash
#SBATCH --job-name=rse
#SBATCH --output=rse-slurm.%N.%j.out
#SBATCH --error=rse-slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

<<<<<<< HEAD
python -u -c "import PyHipp as pyh; \
import time; \
import os; \
=======
python -u -c "import PyHipp as pyh; \
import os; \
import time; \
>>>>>>> upstream/main
t0 = time.time(); \
print(time.localtime()); \
os.chdir('sessioneye'); \
pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); \
print(time.localtime()); \
print(time.time()-t0);"
<<<<<<< HEAD
=======
aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:018084650241:awsnotify --message "RSEJobDone"
>>>>>>> upstream/main
