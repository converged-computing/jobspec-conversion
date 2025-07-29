#!/bin/bash
#SBATCH --job-name=pTat3d
#SBATCH --output=p3davx-%j.out
#SBATCH --error=p3davx-%j.err
#SBATCH --mail-user=dave.mayhem23@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=24

EXEC=${PWD}/${PETSC_ARCH}/bin/ptatin_driver_linear_ts.app
aprun -n $SLURM_NTASKS -N $SLURM_NTASKS_PER_NODE $EXEC -options_file src/models/viscous_sinker/examples/sinker-mfscaling.opts -a11_op avx
exit
