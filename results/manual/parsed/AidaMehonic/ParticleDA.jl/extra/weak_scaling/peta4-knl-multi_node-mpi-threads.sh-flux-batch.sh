#!/bin/bash
#FLUX: --job-name=purple-signal-5043
#FLUX: -N=16
#FLUX: -n=256
#FLUX: -t=43200
#FLUX: --priority=16

export OMP_NUM_THREADS='4'
export JULIA_NUM_THREADS='$OMP_NUM_THREADS'

module purge
module load rhel7/default-peta4   
module load julia/1.4
module load hdf5/impi
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=4
export JULIA_NUM_THREADS=$OMP_NUM_THREADS
rm -f weak_scaling_r*.h5
for ranks in 16 32 64 128 256
do
    srun -n $ranks julia run_tdac.jl
done
