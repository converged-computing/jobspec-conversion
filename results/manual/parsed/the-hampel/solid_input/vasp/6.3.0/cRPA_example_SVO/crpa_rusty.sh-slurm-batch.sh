#!/bin/bash
#SBATCH --job-name=nno-cpra-1orb
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=32,rome

export OMP_NUM_THREADS='4'

export OMP_NUM_THREADS=4
ulimit -s unlimited
module purge
module load slurm
module load vasp/6.3.0_gnu
VASP="mpirun --map-by socket:pe=$OMP_NUM_THREADS vasp_std" 
cp INCAR.DFT INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.DFT
cp INCAR.EXACT INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.EXACT
cp INCAR.CRPA INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.CRPA
