#!/bin/bash
#FLUX: --job-name=swampy-destiny-4730
#FLUX: -n=64
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export JULIA_NUM_THREADS='$OMP_NUM_THREADS'

module purge
module load rhel7/default-peta4   
module load julia/1.4
module load hdf5/impi
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
export JULIA_NUM_THREADS=$OMP_NUM_THREADS
rm -f weak_scaling_r*.h5
for ranks in 1 2 4 8 16 32 64
do
    srun -n $ranks julia run_tdac.jl
done
