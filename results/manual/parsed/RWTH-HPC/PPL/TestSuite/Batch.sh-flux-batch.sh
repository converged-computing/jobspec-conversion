#!/bin/bash
#FLUX: --job-name=Testing
#FLUX: -n=2
#FLUX: -c=48
#FLUX: --queue=c18g
#FLUX: -t=36000
#FLUX: --urgency=16

module unload intel
module unload intelmpi
module load cuda/110
module load gcc/9
module load openmpi/4.0.3
echo; export; echo;  nvidia-smi; echo
cd ~/Master/out
make runall
$MPIEXEC $FLAGS_MPI_BATCH ./bin/Pattern_Test.exe
