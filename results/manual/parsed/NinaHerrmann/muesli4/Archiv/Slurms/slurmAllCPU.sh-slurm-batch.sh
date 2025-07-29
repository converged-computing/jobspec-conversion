#!/bin/bash
#FLUX: --job-name=Muesli2-CPU
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=14400
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'
export I_MPI_FABRICS='shm:ofa'

cd /home/k/kuchen/Muesli2
module load intelcuda/2019a
module load CMake/3.15.3
export OMP_NUM_THREADS=4
export I_MPI_FABRICS=shm:ofa
for file in /home/k/kuchen/Muesli2/build/bin/*cpu
do
  mpirun $file &
done
wait
