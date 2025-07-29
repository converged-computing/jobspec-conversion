#!/bin/bash
#SBATCH --output=%x.slurm.%N.%j.out
#SBATCH --error=%x.slurm.%N.%j.err
#SBATCH --mail-user=jkinney@mit.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32000
#SBATCH --time=2-00:00:00

export TZ='America/New_York'

module add mit/matlab/2016b
cd /home/jkinney/lotus-registration
export TZ=America/New_York
matlab -nodisplay -nodesktop -nosplash -r "run('master_reg_bead_20180328.m');disp('FINISHED');exit;"
