#!/bin/bash
#FLUX: --job-name=eccentric-peanut-butter-3650
#FLUX: --priority=16

export QPFAS_DEVICE_ID='kay_hpc_cluster'

export QPFAS_DEVICE_ID="kay_hpc_cluster"
cd $SLURM_SUBMIT_DIR
module load intel/2020u4
module load conda
echo "Start running QPFAS script on Dask" 
python py/run_workflow.py -loc $1 -yml $2 -save_to $3
echo "End running QPFAS script on Dask"
