#!/bin/bash
#FLUX: --job-name=hello-pancake-8551
#FLUX: -N=16
#FLUX: -t=43200
#FLUX: --urgency=16

mpirun -npernode 16 lmp_cpu -v x 64 -v y 64 -v z 128 -v t 100 < in.lj
mv log.lammps log.28Jun14.lj.cpu.2048K.16.16
mpirun -npernode 16 lmp_omp -sf omp -pk omp 1 -v x 64 -v y 64 -v z 128 -v t 100 < in.lj
mv log.lammps log.28Jun14.lj.omp.2048K.16.1.16
mpirun -npernode 2 lmp_cuda -c on -sf cuda -pk cuda 2 -v x 64 -v y 64 -v z 128 -v t 100 < in.lj
mv log.lammps log.28Jun14.lj.cuda.2048K.2.16
mpirun -npernode 14 lmp_gpu -sf gpu -pk gpu 2 -v x 64 -v y 64 -v z 128 -v t 100 < in.lj
mv log.lammps log.28Jun14.lj.gpu.2048K.2.14.16
mpirun -npernode 2 lmp_kokkos_cuda -k on g 2 t 1 -sf kk -pk kokkos comm device -v x 64 -v y 64 -v z 128 -v t 100 < in.lj
mv log.lammps log.28Jun14.lj.kokkos.cuda.2048K.2.1.16
mpirun -np 256 -bind-to core -map-by core -x KMP_AFFINITY=scatter lmp_kokkos_omp -k on t 1 -sf kk -pk kokkos comm device -v x 64 -v y 64 -v z 128 -v t 100 < in.lj
mv log.lammps log.28Jun14.lj.kokkos.omp.2048K.16.1.16
