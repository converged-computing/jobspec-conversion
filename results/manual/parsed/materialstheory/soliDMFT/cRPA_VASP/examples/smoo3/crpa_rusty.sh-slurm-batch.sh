#!/bin/bash
#SBATCH --job-name=vasp-crpa
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=40

export OMP_NUM_THREADS='1'
export MODULEPATH='/mnt/home/ahampel/codes/modules:$MODULEPATH'

export OMP_NUM_THREADS=1
ulimit -s unlimited
export MODULEPATH=/mnt/home/ahampel/codes/modules:$MODULEPATH
module purge
module load slurm 
module load vasp/6.1_w90v3.1_intel
VASP="mpirun vasp_std" 
cp INCAR.DFT INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.DFT
cp INCAR.EXACT INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.EXACT
cp INCAR.CRPA INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.CRPA_target.static
