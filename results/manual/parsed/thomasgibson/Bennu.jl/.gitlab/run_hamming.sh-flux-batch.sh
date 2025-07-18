#!/bin/bash
#FLUX: --job-name=hanky-pastry-8016
#FLUX: -t=3600
#FLUX: --urgency=16

echo "# "
echo "# Running job $SLURM_JOB_NAME - $SLURM_JOB_ID "
echo "# Job execution hosts are $SLURM_JOB_NODELIST "
echo "# "
source $HOME/.bashrc
module load lib/cuda/10.1.243
echo "Available GPUs..."
nvidia-smi
echo "Julia GPU environment..."
env | grep JULIA
env | grep CUDA
echo "Running Julia..."
julia --project=. -e "import Pkg; Pkg.Registry.update(); Pkg.instantiate(); Pkg.precompile(); import InteractiveUtils; InteractiveUtils.versioninfo(verbose=true); import CUDA; CUDA.versioninfo(); Pkg.test()"
