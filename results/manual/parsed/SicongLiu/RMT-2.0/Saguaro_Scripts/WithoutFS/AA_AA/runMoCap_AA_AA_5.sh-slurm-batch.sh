#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --mail-user=sliu104@asu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:12:00
#SBATCH --partition=serial

module load gcc/4.9.2
module load matlab/2015b
cd /home/sliu104/MoCapGaussian/
matlab -nodisplay -nosplash -nodesktop -r "runMoCap_AA_AA_5()"
