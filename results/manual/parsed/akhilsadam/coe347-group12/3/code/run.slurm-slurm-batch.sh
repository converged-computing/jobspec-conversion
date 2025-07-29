#!/bin/bash
#SBATCH --job-name=of
#SBATCH --account=COE-347-S22
#SBATCH --output=ofo.%j
#SBATCH --error=ofe.%j
#SBATCH --mail-user=akhil.sadam@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

export OMP_NUM_THREADS='272'

pwd
date
echo "[+] RUN : MODULE LOAD." 
export OMP_NUM_THREADS=272
module purge
module load intel/18.0.2  libfabric/1.7.0  impi/18.0.2 
module load python3
module load openfoam/7.0
module list
echo "[+] RUN : SLURM RUN." 
sh runTACC.sh
date
