#!/bin/bash
#FLUX: --job-name=gassy-kerfuffle-5458
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

module load openmpi/3.1.5/gcc-9.3.0
export OMP_NUM_THREADS=1
echo $OMP_NUM_THREADS > output-np$SLURM_NTASKS
echo $SLURM_NTASKS >> output-np$SLURM_NTASKS
julia --version >> output-np$SLURM_NTASKS
mpirun -np $SLURM_NTASKS julia --project=@. dimer_plus_minus.jl plus_true minus_false sp_tau.txt >> output-np$SLURM_NTASKS-vqs-symmetry3
echo "done!"
