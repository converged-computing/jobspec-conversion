#!/bin/bash
#SBATCH --job-name=matlab_p100
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:2
#SBATCH --time=12:00:00
#SBATCH --partition=gpup100
#SBATCH --constraint=ntasks-per-node=2

ml cuda/8.0
ml gcc/5.5.0
ml # confirm modules used
for foldername in ~/work/yixuan/data/{1485..1500} ; do
    for filename in $foldername/*.h5; do
        ./k-Wave/binaries/kspaceFirstOrder3D-CUDA -i "$filename" -o "$filename" -p
    done
done
