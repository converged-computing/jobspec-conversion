#!/bin/bash
#SBATCH --job-name=hello-cuda
#SBATCH --output=hello-cuda-%j.out
#SBATCH --error=hello-cuda-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=02:00:00
#SBATCH --partition=training

module load cuda-11.2.1
module load gcc-6.5.0
/usr/local/cuda/bin/nvcc ../exp_force_main.cu -o ../output/ExForce
for blocks in 5600 8192 16384
do
    for stream_count in 2 4 8
    do
        srun -N 1 ../output/ExForce ../input/twitter.txt $blocks 1024 $stream_count 1 >> twitter_stopwatch.txt
    done 
done
