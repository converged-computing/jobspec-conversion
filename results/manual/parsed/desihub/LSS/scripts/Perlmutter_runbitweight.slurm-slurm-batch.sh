#!/bin/bash
#SBATCH --job-name=bitweights
#SBATCH --mail-user=your@email.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=cpu

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
source /global/common/software/desi/desi_environment.sh 
PYTHONPATH=$PYTHONPATH:$HOME/LSS/py
srun -n 32 -c 8 --cpu_bind=cores $HOME/LSS/bin/mpi_bitweights --mtl inputfolder/targ.fits --tiles inputfolder/tiles.fits --format fits --outdir outputfolder --realizations 128
