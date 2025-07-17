#!/bin/bash
#FLUX: --job-name=tart-citrus-0369
#FLUX: -c=16
#FLUX: -t=43200
#FLUX: --urgency=16

export OMPI_MCA_pml='^ucx'
export OMPI_MCA_osc='^ucx'
export OMPI_MCA_btl_openib_allow_ib='true'
export COMMON='/nobackup/users/lcbrock/'
export JULIA_DEPOT_PATH='${COMMON}/depot'
export JULIA_CUDA_MEMORY_POOL='none'
export JULIA='${COMMON}/julia/julia'
export JULIA_NVTX_CALLBACKS='gc'
export JULIA_NUM_THREADS='${SLURM_CPUS_PER_TASK:=1}'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export RX='1'
export RY='4'

module purge all
module add spack
module add cuda/11.4
module load openmpi/3.1.6-cuda-pmi-ucx-slurm-jhklron
export OMPI_MCA_pml=^ucx
export OMPI_MCA_osc=^ucx
export OMPI_MCA_btl_openib_allow_ib=true
export COMMON="/nobackup/users/lcbrock/"
export JULIA_DEPOT_PATH="${COMMON}/depot"
export JULIA_CUDA_MEMORY_POOL=none
export JULIA="${COMMON}/julia/julia"
export JULIA_NVTX_CALLBACKS=gc
export JULIA_NUM_THREADS=${SLURM_CPUS_PER_TASK:=1}
cat > launch.sh << EoF_s
export CUDA_VISIBLE_DEVICES=0,1,2,3
exec \$*
EoF_s
chmod +x launch.sh
export RX=1
export RY=4
srun --mpi=pmi2 ./launch.sh $JULIA --check-bounds=no --project example/run_mpi.jl
