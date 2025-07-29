#!/bin/bash
#SBATCH --job-name=scaling_test.jl
#SBATCH --account=T2-CS097-KNL
#SBATCH --nodes=16
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=knl
#SBATCH --constraint=cache

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
