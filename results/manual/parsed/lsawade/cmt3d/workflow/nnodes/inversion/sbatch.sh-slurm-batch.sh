#!/bin/bash
#SBATCH --job-name=Inversion
#SBATCH --account=GEO111
#SBATCH --output=R-%x.%j.o.txt
#SBATCH --error=R-%x.%j.e.txt
#SBATCH --mail-user=lsawade@princeton.com
#SBATCH --mail-type=end
#SBATCH --nodes=40
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=02:00:00
#SBATCH --array=1-4%1

export MPLCONFIGDIR='${LUSTRE}/.matplotlib'
export OMP_NUM_THREADS='1'
export MPICH_GPU_SUPPORT_ENABLED='0'

module purge
module load PrgEnv-cray amd-mixed cray-mpich craype-accel-amd-gfx90a
module load core-personal hdf5-personal
module unload darshan-runtime
export MPLCONFIGDIR=${LUSTRE}/.matplotlib
export OMP_NUM_THREADS=1
export MPICH_GPU_SUPPORT_ENABLED=0
source ~/miniconda3/bin/activate gf
python -c "from nnodes import root; root.run()"
