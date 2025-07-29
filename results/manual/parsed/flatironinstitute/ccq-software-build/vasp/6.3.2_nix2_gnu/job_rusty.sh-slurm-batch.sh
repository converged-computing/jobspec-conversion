#!/bin/bash
#SBATCH --job-name=lno-scf
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=32,rome

export OMP_NUM_THREADS='4'

module purge
module load slurm
module load vasp/6.3.2_nix2_gnu
export OMP_NUM_THREADS=4
ulimit -s unlimited
VASP="mpirun --map-by socket:pe=$OMP_NUM_THREADS vasp_std" 
$VASP
