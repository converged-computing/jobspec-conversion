#!/bin/bash
#SBATCH --job-name=vasp-crpa
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=120,rome

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm
module load vasp/6.1.2_gnu_ompi/module-rome
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
