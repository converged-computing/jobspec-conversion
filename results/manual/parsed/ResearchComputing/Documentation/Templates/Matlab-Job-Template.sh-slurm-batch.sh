#!/bin/bash
#SBATCH --job-name=Matlab_Gen_Parallel
#SBATCH --output=MATLAB_GEN_PARALLEL.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --qos=testing

module purge
module load matlab
cd /projects/$USER/target_Directory
matlab -nosplash -nodesktop -r "clear; num_workers=$SLURM_NTASKS; parallel_std;"
