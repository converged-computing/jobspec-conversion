#!/bin/bash
#FLUX: --job-name=redsmall_plots_wDolly
#FLUX: --queue=main
#FLUX: -t=43200
#FLUX: --urgency=16

export MV2_ENABLE_AFFINITY='0'

export MV2_ENABLE_AFFINITY=0
srun --mpi=pmi2 python3 /home/mfa51/deep-scheduler/redsmall_plots_wDolly.py --ro 
