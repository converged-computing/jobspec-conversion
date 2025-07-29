#!/bin/bash
#SBATCH --job-name=runGA
#SBATCH --output=./headlessOut/%A_%a.out
#SBATCH --error=./headlessOut/%A_%a.err
#SBATCH --mail-user=zf1005@wildcats.unh.edu
#SBATCH --mail-type=START,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=300G
#SBATCH --time=60-00:00:00

module load MATLAB
./runHeadless.sh MatlabRun
