#!/bin/bash
#FLUX: --job-name=Job_Name
#FLUX: --queue=Partition_Name
#FLUX: --urgency=16

time_stamp="Anything_You_Want_That_can_Specify_The_Time_Or_Job_(cf.Regarding_Virtual_Environment_Below_Check_'mmd-env.yml'_File)"
source activate ~/venv/mmd-env
which python
pip freeze
python parallel_mmdcurve.py $SLURM_ARRAY_TASK_ID $time_stamp #(: Or, python parallel_lognolog.py $SLURM_ARRAY_TASK_ID $time_stamp)
