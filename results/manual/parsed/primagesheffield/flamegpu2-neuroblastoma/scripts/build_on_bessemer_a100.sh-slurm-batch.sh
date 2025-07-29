#!/bin/bash
#SBATCH --job-name=compile.a100-tmp.sh
#SBATCH --output=build_output.out
#SBATCH --error=build_error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=80G
#SBATCH --time=00:30:00
#SBATCH --qos=gpu

cd $SLURM_SUBMIT_DIR
module unuse /usr/local/modulefiles/live/eb/all
module unuse /usr/local/modulefiles/live/noeb
module use /usr/local/modulefiles/staging/eb-znver3/all/
module load GCC/11.2.0
module load CUDA/11.4.1
module load CMake/3.21.1-GCCcore-11.2.0
mkdir -p build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DVISUALISATION=OFF -DSEATBELTS=OFF -DCUDA_ARCH="80"
cmake --build . --target all --parallel 6
