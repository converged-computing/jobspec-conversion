#!/bin/bash
#SBATCH --job-name=lda_expers
#SBATCH --output=pipeline%j.out
#SBATCH --error=pipeline%j.err
#SBATCH --mail-user=kriss1@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=1-00:00:00
#SBATCH --qos=normal

source /home/kriss1/.bash_profile
module load python/3.6.1
cd /scratch/users/kriss1/programming/research/microbiome_plvm/src/sim/lda/pipeline/
python3 pipeline.py LDAExperiment --local-scheduler --workers=5
