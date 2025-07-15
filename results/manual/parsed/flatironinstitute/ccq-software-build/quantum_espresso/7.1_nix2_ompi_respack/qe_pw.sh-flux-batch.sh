#!/bin/bash
#FLUX: --job-name="ortho-GX"
#FLUX: --queue=ccq
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
ulimit -s unlimited
module load slurm
module load quantum_espresso/7.1_nix2_gnu_ompi_respack
mpirun pw.x -pd .true. -nk 8 < lno.bnd.in > lno.bnd.out 
mpirun -n 32 unfold.x -pd .true. < lno.unfold.in > lno.unfold.out
