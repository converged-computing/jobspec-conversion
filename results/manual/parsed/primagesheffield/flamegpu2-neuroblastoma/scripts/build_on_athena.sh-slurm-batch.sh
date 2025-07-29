#!/bin/bash
#SBATCH --job-name=build_fgpu2_nb
#SBATCH --account=plgprimage4-gpu-a100
#SBATCH --output=build_output.out
#SBATCH --error=build_error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5GB
#SBATCH --time=00:30:00
#SBATCH --partition=plgrid-gpu-a100
#SBATCH --constraint=ntasks-per-node=4

cd $SLURM_SUBMIT_DIR
module load GCCcore/11.3.0
module load CMake/3.23.1
module load CUDA/11.7.0
HOME_PATH=`pwd`
mkdir -p build
cmake -DCMAKE_BUILD_TYPE=Release -DVISUALISATION=OFF -DSEATBELTS=OFF -DCUDA_ARCH="80" -S $HOME_PATH/.. -B $HOME_PATH/build
cd build
cmake --build . --target all --parallel 4
