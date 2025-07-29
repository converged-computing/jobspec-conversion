#!/bin/bash
#FLUX: --job-name=wanda_parallel_fft
#FLUX: -N=8
#FLUX: --queue=m100_usr_prod
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load spectrum_mpi
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/m100_work/PROJECTS/spack/spack-0.14/install/linux-rhel7-power9le/gcc-8.4.0/fftw-3.3.8-hwlrarpm6cvjlukhfdowwveb7g7oqwgc/lib
/
make clean
make 
make fftw3_mpi
rm data/times.dat
echo -e "mode\t\tprc\tnx\tny\tnz\titr\tdt\t\ttime" >> data/times.dat
nx=512
ny=512
nz=1024
nstep=100
dt=0.000001
prc=32
for value in {1..4}
do
        mpirun -np $prc -npernode 32 ./diffusion.x $nstep $nx $ny $nz $dt
        ((prc*=2))
done
prc=32
for value in {1..4}
do
        mpirun -np $prc -npernode 32 ./fftw3_mpidiffusion.x $nstep $nx $ny $nz $dt
        ((prc*=2))
done
make clean
