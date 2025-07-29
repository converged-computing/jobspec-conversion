#!/bin/bash
#SBATCH --job-name=rmodel_Ssci
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=36
#SBATCH --cpus-per-task=1

. ~/conda/etc/profile.d/conda.sh
conda activate
PROCESSORS=36
BATCHES=50
cd /path/to/working/directory
python rmodel.py -g /path/to/genome/assembly.$NAME.fa.gz -p $PROCESSORS -b $BATCHES -w /lustre/scratch//npaulat/arachnids/Ssci/
