#!/bin/bash
#FLUX: --job-name=GP_MASTER
#FLUX: -c=128
#FLUX: --queue=EPYC
#FLUX: -t=129600
#FLUX: --urgency=16

export DASK_WORKER_PROCESSES='128'

echo "---------------------------------------------"
echo "SLURM job ID:        $SLURM_JOB_ID"
echo "SLURM job node list: $SLURM_JOB_NODELIST"
echo "DATE:                $(date)"
echo "HOSTNAME:            $(hostname)"
echo "---------------------------------------------"
source /u/dssc/ipasia00/test_dask/dask_epyc/bin/activate
export DASK_WORKER_PROCESSES=128
python3 -u infer_3_3.py 
