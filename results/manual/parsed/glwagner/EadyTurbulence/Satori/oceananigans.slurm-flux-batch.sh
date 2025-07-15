#!/bin/bash
#FLUX: --job-name=eady
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --priority=16

module purge > /dev/null 2>&1
module load spack/0.1
module load gcc/8.3.0 # to get libquadmath
module load julia/1.4.1
module load cuda/10.1.243
module load openmpi/3.1.4-pmi-cuda
module load py-matplotlib/3.1.1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR/../Oceananigans/
CUDA_VISIBLE_DEVICES=0 unbuffer julia --project non_dimensional_eady_problem.jl --Nh 192 --stop-time 60000 --bottom-bc linear-drag 2>&1 | tee linear_192.out &
CUDA_VISIBLE_DEVICES=1 unbuffer julia --project non_dimensional_eady_problem.jl --Nh 256 --stop-time 60000 --bottom-bc linear-drag 2>&1 | tee linear_256.out &
CUDA_VISIBLE_DEVICES=2 unbuffer julia --project non_dimensional_eady_problem.jl --Nh 192 --stop-time 60000 --bottom-bc pumping-velocity 2>&1 | tee pumping_192.out &
CUDA_VISIBLE_DEVICES=3 unbuffer julia --project non_dimensional_eady_problem.jl --Nh 256 --stop-time 60000 --bottom-bc pumping-velocity 2>&1 | tee pumping_256.out &
sleep 42480 # sleep for 11.8 hours
