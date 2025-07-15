#!/bin/bash
#FLUX: --job-name="nno-cpra-1orb"
#FLUX: --queue=ccq
#FLUX: -t=86400
#FLUX: --priority=16

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
