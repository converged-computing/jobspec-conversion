#!/bin/bash
#FLUX: --job-name=CAMP
#FLUX: -c=128
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --priority=16

export OMP_NUM_THREADS='16'
export OMP_PROC_BIND='SPREAD'
export PAT_RT_SUMMARY='0'
export PAT_RT_PERFCTR='CORE_TO_L2_CACHEABLE_REQUEST_ACCESS_STATUS:LS_RD_BLK_C,PAPI_L2_DCM,PAPI_FP_OPS,mem_bw'

export OMP_NUM_THREADS=16
export OMP_PROC_BIND=SPREAD
export PAT_RT_SUMMARY=0
export PAT_RT_PERFCTR=CORE_TO_L2_CACHEABLE_REQUEST_ACCESS_STATUS:LS_RD_BLK_C,PAPI_L2_DCM,PAPI_FP_OPS,mem_bw
module load perftools-base
module load perftools
srun --hint=nomultithread --unbuffered kernel_hwpc_ADD+pat
srun --hint=nomultithread --unbuffered kernel_hwpc_TMP+pat
srun --hint=nomultithread --unbuffered kernel_hwpc_NOTMP+pat
srun --hint=nomultithread --unbuffered kernel_hwpc_MORE+pat
