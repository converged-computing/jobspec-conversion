#!/bin/bash
#FLUX: --job-name=test_nsys
#FLUX: -c=8
#FLUX: --queue=boost_usr_prod
#FLUX: -t=600
#FLUX: --urgency=16

ml 
nvidia-smi
cd ${HOME}/programming/cuda/matmul_multinode
pwd
echo "compilazione"
make -j -B
echo "RUN SU 2 NODI normale"
mpirun -np 4 ./matvec 1024 1024 1024 1024 1 -v
echo "RUN SU 2 NODI con nsys"
nsys profile --trace=cuda,mpi -f true -o report_prova_nsys_multinodo_8 mpirun -np 4 ./matvec 1024 1024 1024 1024 1 -v
