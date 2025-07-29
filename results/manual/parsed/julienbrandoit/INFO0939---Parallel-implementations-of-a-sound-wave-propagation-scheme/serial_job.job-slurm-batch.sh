#!/bin/bash
#SBATCH --job-name=SERIAL output
#SBATCH --output=out/serial_out1.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:05:00

module load Info0939Tools
gcc SERIAL/fdtd.c -o bin/fdtd -lm -O3 
cd ./example_inputs/simple3d
srun ../../bin/fdtd param_3d.txt
