#!/bin/bash
#FLUX: --job-name=outstanding-chair-1101
#FLUX: --urgency=16

export rocm_version='5.4.3'
export FI_MR_CACHE_MONITOR='memhooks'
export FI_CXI_RX_MATCH_MODE='software'
export SPACK_MANAGER='/lustre/orion/cfd162/proj-shared/kevmoor/spack-manager'

nodes_requested=$SLURM_JOB_NUM_NODES
ranks_requested=$SLURM_NTASKS
export rocm_version=5.4.3
module load PrgEnv-amd
module load amd/${rocm_version}
module load craype-accel-amd-gfx90a
module load cray-mpich
export FI_MR_CACHE_MONITOR=memhooks
export FI_CXI_RX_MATCH_MODE=software
export SPACK_MANAGER=/lustre/orion/cfd162/proj-shared/kevmoor/spack-manager
source ${SPACK_MANAGER}/start.sh
spack-start
spack env activate -d ${SPACK_MANAGER}/environments/naluGPUOverset
spack load nalu-wind
srun -u -N32 -n256 --ntasks-per-gpu=1 --gpu-bind=closest naluX -i Validation_AOA2_1_Variation8_2_Freq075Cumulative.yaml -o val2cumulative.out
