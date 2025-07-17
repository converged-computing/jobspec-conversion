#!/bin/bash
#FLUX: --job-name=vasp-crpa
#FLUX: --queue=ccq
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module purge
module load slurm
module load vasp/6.1.2_gnu_ompi/module-rome
VASP="mpirun vasp_std" 
cp INCAR.DFT INCARV
$VASP
cat INCAR OUTCAR > OUTCAR.DFT
cp INCAR.EXACT INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.EXACT
cp INCAR.CRPA INCAR
$VASP
cat INCAR OUTCAR > OUTCAR.CRPA_target.static
