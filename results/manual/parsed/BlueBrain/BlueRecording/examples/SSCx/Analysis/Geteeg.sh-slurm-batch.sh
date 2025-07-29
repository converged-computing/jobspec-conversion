#!/bin/bash
#SBATCH --job-name=EEG_2_CoordsV
#SBATCH --account=proj85
#SBATCH --output=EEG_0_CoordsV.out
#SBATCH --error=EEG_0_CoordsV.err
#SBATCH --nodes=14
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=0
#SBATCH --time=1-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=clx
#SBATCH --no-requeue

spack env activate bluerecording-dev
source ~/bluerecording-dev/bin/activate
mkdir ../sscxSimulation/pkls
srun -n 420 python geteeg.py
