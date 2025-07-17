#!/bin/bash
#FLUX: --job-name=lno-scf
#FLUX: --queue=ccq
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'

module purge
module load slurm
module load vasp/6.3.2_nix2_gnu
export OMP_NUM_THREADS=4
ulimit -s unlimited
VASP="mpirun --map-by socket:pe=$OMP_NUM_THREADS vasp_std" 
$VASP
