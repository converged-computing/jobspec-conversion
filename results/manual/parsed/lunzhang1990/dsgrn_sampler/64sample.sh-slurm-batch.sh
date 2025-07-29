#!/bin/bash
#SBATCH --output=testslurm%N.%j.out
#SBATCH --error=slurm_script.%N.%j.err
#SBATCH --mail-user=chamberlian1990@gmail.com
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=7-00:00:00

cd $PWD
module load py3-numpy/1.14.3 py3-scipy/1.1.0
srun python3 samplerun.py 64 64prec3.dat  
