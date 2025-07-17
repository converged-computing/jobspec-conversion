#!/bin/bash
#FLUX: --job-name=expressive-pot-7141
#FLUX: --exclusive
#FLUX: --urgency=16

export rocm_version='5.4.3'
export FI_MR_CACHE_MONITOR='memhooks'
export FI_CXI_RX_MATCH_MODE='software'

nodes=$SLURM_JOB_NUM_NODES
ranks=$SLURM_NTASKS
export rocm_version=5.4.3
module purge
module load PrgEnv-amd
module load cray-mpich
export FI_MR_CACHE_MONITOR=memhooks
export FI_CXI_RX_MATCH_MODE=software
amrw=/lustre/orion/cfd116/proj-shared/mullowne/spack-manager/spack/opt/spack/linux-sles15-zen3/clang-15.0.0/amr-wind-main-a347muwc3srkopn3ieo5a4biuw3f72s7/bin/amr_wind
srun -N %NODES% -n %RANKS% $amrw nrel5mw_amr.inp
mkdir run_${SLURM_JOBID}
mv amrw-abl_cpu_%AMRW_RANKS%.o${SLURM_JOBID} run_${SLURM_JOBID}
