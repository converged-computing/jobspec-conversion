#!/bin/bash
#SBATCH --job-name=OIL
#SBATCH --output=out/job.%j.out
#SBATCH --error=err/job.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=21:00:00
#SBATCH --exclude=c[79-98,101-107]

cd /home/txia4/magic101
source addroot.sh
/home/txia4/anaconda3/bin/python3 Main/experiment.py $1 $2 10
