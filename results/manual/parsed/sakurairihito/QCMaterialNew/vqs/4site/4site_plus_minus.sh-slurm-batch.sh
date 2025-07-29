#!/bin/bash
#SBATCH --job-name=uccgsd_dimer_tau_plus
#SBATCH --output=stdout.%J
#SBATCH --error=stderr.%J
#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --cpus-per-task=1
#SBATCH --partition=defq

export OMP_NUM_THREADS='1'

module load openmpi/3.1.5/gcc-9.3.0
export OMP_NUM_THREADS=1
echo $OMP_NUM_THREADS > output-np$SLURM_NTASKS
echo $SLURM_NTASKS >> output-np$SLURM_NTAsSKS
julia --version >> output-np$SLURM_NTASKS
mpirun -np $SLURM_NTASKS julia --project=@. 4site_plus_minus.jl plus_true minus_false sp_tau.txt >> output-np$SLURM_NTASKS-vqs-plus-2
