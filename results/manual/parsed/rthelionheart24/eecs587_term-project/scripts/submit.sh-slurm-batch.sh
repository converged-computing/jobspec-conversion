#!/bin/bash
#SBATCH --job-name=term-project
#SBATCH --account=eecs587f23_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:05:00

module load cuda
module load gcc
cd /home/qifwang/eecs587/term-project/build
rm -rf *
cmake ..
make
cd /home/qifwang/eecs587/term-project/build
rm ../output.txt
./scheduler > ../output.txt
