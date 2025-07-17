#!/bin/bash
#FLUX: --job-name=subpex_1
#FLUX: --queue=titanx
#FLUX: -t=86400
#FLUX: --urgency=16

source env.sh
SERVER_INFO=$WEST_SIM_ROOT/west_zmq_info-$SLURM_JOBID.json
echo $WEST_PYTHON
w_run --work-manager=serial &> ./job_logs/west-$SLURM_JOBID.log
scontrol show hostname $SLURM_NODELIST > slurm_nodelist.txt
