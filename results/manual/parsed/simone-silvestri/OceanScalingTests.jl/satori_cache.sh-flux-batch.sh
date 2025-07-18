#!/bin/bash
#FLUX: --job-name=ornery-noodle-6672
#FLUX: -c=16
#FLUX: --queue=reservation7
#FLUX: -t=86400
#FLUX: --urgency=16

export OMPI_MCA_pml='^ucx'
export OMPI_MCA_osc='^ucx'
export OMPI_MCA_btl_openib_allow_ib='true'
export COMMON='/nobackup/users/ssilvest/perlmutter-test'
export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'
export JULIA_NVTX_CALLBACKS='gc'
export JULIA_LOAD_PATH='${JULIA_LOAD_PATH}:$(pwd)/satori'
export JULIA_CUDA_MEMORY_POOL='none'
export JULIA='${COMMON}/julia-1.9-src/julia'
export JULIA_DEPOT_PATH=':${COMMON}/depot'
export RESOLUTION='1'
export NZ='100'
export PROFILE='1'
export EXPERIMENT='DoubleDrake'

module purge all
module add spack
module add cuda/11.4
module load openmpi/3.1.6-cuda-pmi-ucx-slurm-jhklron
export OMPI_MCA_pml=^ucx
export OMPI_MCA_osc=^ucx
export OMPI_MCA_btl_openib_allow_ib=true
export COMMON="/nobackup/users/ssilvest/perlmutter-test"
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
export JULIA_NVTX_CALLBACKS=gc
export JULIA_LOAD_PATH="${JULIA_LOAD_PATH}:$(pwd)/satori"
export JULIA_CUDA_MEMORY_POOL=none
export JULIA="${COMMON}/julia-1.9-src/julia"
export JULIA_DEPOT_PATH=":${COMMON}/depot"
export RESOLUTION=1
export NZ=100
export PROFILE=1
export EXPERIMENT=DoubleDrake
JULIA_DEPOT_PATH="${COMMON}/depot" $JULIA --check-bounds=no --project -e "import Pkg; Pkg.instantiate(); Pkg.precompile()"
rm -rf ${HOME}/.julia/{packages, compiled, scratchspaces}
$JULIA --check-bounds=no --project experiments/run.jl
