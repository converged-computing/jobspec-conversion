#!/bin/bash
#FLUX: --job-name=astute-punk-8858
#FLUX: --exclusive
#FLUX: --urgency=16

export FI_MR_CACHE_MONITOR='memhooks'
export FI_CXI_RX_MATCH_MODE='software'

nodes=$SLURM_JOB_NUM_NODES
ranks=$SLURM_NTASKS
module load PrgEnv-amd
module load cray-mpich
exawind=/lustre/orion/cfd116/proj-shared/mullowne/spack-manager/spack/opt/spack/linux-sles15-zen3/clang-15.0.0/exawind-master-wusoumhon22vkjawiiykqqciwrcfamqp/bin/exawind
export FI_MR_CACHE_MONITOR=memhooks
export FI_CXI_RX_MATCH_MODE=software
srun -N %NODES% -n %RANKS% $exawind --awind %AMRW_RANKS% --nwind %NALU_RANKS% nrel5mw.yaml
mkdir run_${SLURM_JOBID}
mv nrel5mw_nalu*.log run_${SLURM_JOBID}
mv 4t-unifinflow_cpu_%AMRW_RANKS%_%NALU_RANKS%.o${SLURM_JOBID} run_${SLURM_JOBID}
mv amr-wind.log run_${SLURM_JOBID}/amr_wind_%AMRW_RANKS%.log
mv timings.dat run_${SLURM_JOBID}/
mv forces*dat run_${SLURM_JOBID}/
