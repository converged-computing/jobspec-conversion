#!/bin/bash
#SBATCH --job-name=build_fgpu2_nb
#SBATCH --account=plgprimage4-cpu
#SBATCH --output=build_output.out
#SBATCH --error=build_error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=00:30:00
#SBATCH --partition=plgrid
#SBATCH --constraint=ntasks-per-node=4

cd $SLURM_SUBMIT_DIR
module load cmake/3.20.1-gcccore-10.3.0
module load cudacore/11.2.2
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DVISUALISATION=OFF -DSEATBELTS=OFF -DCUDA_ARCH="70"
cmake --build . --target all --parallel 4
