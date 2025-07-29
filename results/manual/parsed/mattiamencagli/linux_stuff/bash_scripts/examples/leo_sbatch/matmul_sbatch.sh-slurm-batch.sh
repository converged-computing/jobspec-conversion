#!/bin/bash
#SBATCH --job-name=test_nsys
#SBATCH --account=cin_staff
#SBATCH --mail-user=m.mencagli@cineca.it
#SBATCH --mail-type=NONE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=4

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
