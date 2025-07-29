#!/bin/bash
#SBATCH --job-name=PICSAR.ARMFORGE-SERIAL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=c6gn
#SBATCH: --exclusive

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
spack load picsar%gcc@10.3.0
spack load arm-forge@21.0
input_file="INPUT_FILE_PATH"
cp "$input_file" "input_file.pixr"
mkdir "RESULTS"
map --profile srun picsar
