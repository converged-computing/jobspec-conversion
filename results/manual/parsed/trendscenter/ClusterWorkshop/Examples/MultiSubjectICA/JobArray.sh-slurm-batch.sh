#!/bin/bash
#SBATCH --job-name=cworkshop_multi_ica
#SBATCH --account=trends53c17
#SBATCH --output=out%A_%a.out
#SBATCH --error=error%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=01:00:00
#SBATCH --partition=qTRD

sleep 10s 
module load matlab
cd $MYDIR/Examples/MultiSubjectICA
matlab -batch 'gigica_step2'
sleep 10s
