#!/bin/bash
#SBATCH --job-name=desi
#SBATCH --mail-user=j.loveday@sussex.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --partition=regular
#SBATCH --constraint=cpu

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
module load conda
conda activate jon
python <<EOF
import platform
print(platform.python_version())
import desi
desi.desi_legacy_xcounts()
EOF
