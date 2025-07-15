#!/bin/bash
#FLUX: --job-name=Sorani-Arabic
#FLUX: -n=8
#FLUX: --priority=16

ml gnu10; ml cuda; ml cudnn; ml nvidia-hpc-sdk; ml python;
echo "Start process"
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
RUNPATH=/scratch/sahmad46
cd $RUNPATH
echo "Starting Venv"
source $RUNPATH/venvs/joeynmt_torch1/bin/activate
echo "Running the script"
python3 -m joeynmt train training/configs/Sorani-Arabic_$SLURM_ARRAY_TASK_ID.yaml
deactivate
echo "End process"
