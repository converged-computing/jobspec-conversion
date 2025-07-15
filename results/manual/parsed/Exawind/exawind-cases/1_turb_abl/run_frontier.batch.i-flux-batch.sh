#!/bin/bash
#FLUX: --job-name=chunky-bits-8613
#FLUX: --exclusive
#FLUX: --priority=16

export rocm_version='5.4.3'
export LD_LIBRARY_PATH='/opt/rocm-${rocm_version}/llvm/lib/:$LD_LIBRARY_PATH'
export HIP_LAUNCH_BLOCKING='1'
export FI_MR_CACHE_MONITOR='memhooks'
export FI_CXI_RX_MATCH_MODE='software'

nodes=$SLURM_JOB_NUM_NODES
ranks=$SLURM_NTASKS
export rocm_version=5.4.3
module purge
module load amd/${rocm_version}
module load craype-accel-amd-gfx90a
module load PrgEnv-amd
module load cray-mpich
export LD_LIBRARY_PATH=/opt/rocm-${rocm_version}/llvm/lib/:$LD_LIBRARY_PATH
export HIP_LAUNCH_BLOCKING=1
export FI_MR_CACHE_MONITOR=memhooks
export FI_CXI_RX_MATCH_MODE=software
exawind=/lustre/orion/cfd116/proj-shared/mullowne/spack-manager/spack/opt/spack/linux-sles15-zen3/clang-15.0.0/exawind-master-ndi3c36sv4e6dpvcwggd7g46ozuicnxb/bin/exawind
srun -N %NODES% -n %RANKS% --gpus-per-node=%RANKS_PER_NODE% --gpu-bind=closest  $exawind --awind %AMRW_RANKS% --nwind %NALU_RANKS% nrel5mw.yaml
mkdir run_${SLURM_JOBID}
mv nrel5mw_nalu*.log run_${SLURM_JOBID}
mv 1t-abl_gpu_%AMRW_RANKS%_%NALU_RANKS%.o${SLURM_JOBID} run_${SLURM_JOBID}
mv amr-wind.log run_${SLURM_JOBID}/amr_wind_%AMRW_RANKS%.log
mv timings.dat run_${SLURM_JOBID}/
mv forces*dat run_${SLURM_JOBID}/
