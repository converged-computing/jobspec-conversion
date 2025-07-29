#!/bin/bash
#SBATCH --job-name=wavetank
#SBATCH --account=ADCIRC
#SBATCH --output=oe.wavetank.asm.o%j
#SBATCH --mail-user=steve.a.mattis@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=192
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=development

set -x
source /home1/01082/smattis/src/proteus/envConfig
mkdir $SLURM_JOB_NAME.$SLURM_JOB_ID
ibrun parun tank_so.py  -l 3 -v -D $SLURM_JOB_NAME.$SLURM_JOB_ID -O ../../petsc.options.asm -o context.options #-p
