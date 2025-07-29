#!/bin/bash
#SBATCH --job-name=Muesli2-examples-GPU
#SBATCH --output=/scratch/tmp/kuchen/outputAllGPU.txt
#SBATCH --error=/scratch/tmp/kuchen/errorAllGPU.txt
#SBATCH --mail-user=kuchen@uni-muenster.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --time=04:00:00
#SBATCH --partition=gpu2080
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

cd /home/k/kuchen/Muesli2
module load intelcuda/2019a
module load CMake/3.15.3
./build.sh
for file in /home/k/kuchen/Muesli2/build/bin/*gpu
do
  mpirun $file
done
wait
