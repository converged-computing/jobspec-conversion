#!/bin/bash
#FLUX: --job-name=blast_ball
#FLUX: -c=24
#FLUX: -t=18000
#FLUX: --priority=16

export OMP_NUM_THREADS='24'

lscpu
echo ""; echo "BUILD"; echo ""
module restore
module load gcc/8.2.0 cmake cuda gsl openmpi hdf5 fftw openblas boost python
module list
export OMP_NUM_THREADS=24
cd ../build/; make; cd ../run/
echo ""; echo "START at "; date; echo ""
time srun ../build/pkdgrav3 cosmology_blast_ball.par
echo ""; echo "END at "; date; echo ""
module restore
module load gcc/6.3.0 python ffmpeg
module list
echo ""; echo "PLOT"; echo ""
cd ../tools/
time python plot.py blast_ball density 300
echo ""; echo "ANIMATE"; echo ""
time python animate.py blast_ball 300
cd ../run/
echo ""; echo "DONE"; echo ""
