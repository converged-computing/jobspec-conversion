#!/bin/bash
#SBATCH --job-name=singularity
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:45

module load singularity/3.4.1
module load intel/2021.2
module load openmpi3
echo "Starting singularity on host $HOSTNAME"
singularity exec ithicafv.sif /bin/bash Of.sh
echo "Completed singularity on host $HOSTNAME"
