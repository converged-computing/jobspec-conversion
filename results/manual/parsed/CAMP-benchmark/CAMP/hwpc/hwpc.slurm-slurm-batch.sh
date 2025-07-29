#!/bin/bash
#SBATCH --job-name=CAMP
#SBATCH --account=ta094-wenqingpen
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --time=00:20:00
#SBATCH --qos=short

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
