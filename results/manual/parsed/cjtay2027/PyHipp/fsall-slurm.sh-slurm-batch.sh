#!/bin/bash
#SBATCH --job-name=fsall
#SBATCH --output=fsall-slurm.%N.%j.out
#SBATCH --error=fsall-slurm.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

python -u -c "import PyHipp as pyh; \
import time; \
import DataProcessingTools as DPT; \
lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*', '*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1); \
lfall.save(); \
hfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*', '*mountains*'], objtype=pyh.FreqSpectrum, loadHighPass=True, pointsPerWindow=3000, saveLevel=1); \
hfall.save();
print(time.localtime());"
aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:411510307428:awsnotify --message "FSJobDone"
