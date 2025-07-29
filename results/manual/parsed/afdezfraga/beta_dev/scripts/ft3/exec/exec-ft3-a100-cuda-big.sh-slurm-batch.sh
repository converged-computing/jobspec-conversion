#!/bin/bash
#SBATCH --job-name=output/cuda_big_exec_beta_pdf_A100
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=3G
#SBATCH --time=00:20:00

module load cesga/2020 cuda/12.2.0
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
sleep 1
make clean
sleep 1
make VERBOSE=1
sleep 1
EXECUTABLE=../bin/bench_base
for i in 1000000000
do
    for j in cuda
    do
        OMP_NUM_THREADS=32 $EXECUTABLE $i 5 $j betapdf
        OMP_NUM_THREADS=32 $EXECUTABLE $i 5 $j betacdf
    done
done
