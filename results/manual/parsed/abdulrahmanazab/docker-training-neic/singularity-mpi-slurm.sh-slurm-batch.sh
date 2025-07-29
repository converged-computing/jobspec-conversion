#!/bin/bash
#SBATCH --job-name=hello
#SBATCH --account=staff
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:02:00

source /cluster/bin/jobsetup
module purge   # clear any inherited modules
set -o errexit # exit on errors
module load singularity/2.5.0
module load openmpi.gnu/1.10.2
mpirun singularity exec -B /work:/work  ~/ubuntu.simg /usr/bin/hello
