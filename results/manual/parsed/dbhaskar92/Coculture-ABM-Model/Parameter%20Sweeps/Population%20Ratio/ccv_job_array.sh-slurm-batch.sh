#!/bin/bash
#FLUX: --job-name=ABM_Simulation_Parameter_Sweep
#FLUX: -t=258900
#FLUX: --urgency=16

echo "Starting job $SLURM_ARRAY_TASK_ID on $HOSTNAME"
matlab-threaded -nodisplay -r "coculture_model($SLURM_ARRAY_TASK_ID); exit"
