#!/bin/bash
#SBATCH --job-name=rep1
#SBATCH --output=/home/sryali/VB-HMM/Jobs/repjob-%j.out
#SBATCH --error=/home/sryali/VB-HMM/Jobs/repjob-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000
#SBATCH --time=00:35:00
#SBATCH --qos=normal

module load matlab/R2014a
module load spm/12b
matlab -nojit -nosplash -nodesktop -nodisplay -r "main_vbhmm_HCP_replication("$1");exit;"
