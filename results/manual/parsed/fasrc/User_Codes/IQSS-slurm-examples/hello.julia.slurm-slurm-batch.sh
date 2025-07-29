#!/bin/bash
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:15:00
#SBATCH --partition=serial_requeue

module load julia/1.1.1-fasrc01
chmod u+x ./hello.jl
./hello.jl
