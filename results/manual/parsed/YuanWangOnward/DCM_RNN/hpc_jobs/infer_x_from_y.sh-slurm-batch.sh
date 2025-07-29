#!/bin/bash
#FLUX: --job-name=infer_x
#FLUX: -n=2
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONPATH='$PYTHONPATH:$SOURCEDIR'

module purge
module load python3/intel/3.5.3
module load tensorflow/python3.5/1.0.1
JOBNAME=Ideal_long
RUNDIR=$SCRATCH/runs/$JOBNAME-${SLURM_JOB_ID/.*}
SOURCEDIR=~/projects/DCM_RNN/dcm_rnn
OUTPUTDIR=$SCRATCH/results/DCM_RNN/$JOBNAME/${SLURM_JOB_ID/.*}
mkdir -p $RUNDIR
mkdir -p $OUTPUTDIR
export PYTHONPATH=$PYTHONPATH:$SOURCEDIR
echo $PYTHONPATH
cd $RUNDIR
python3 ~/projects/DCM_RNN/experiments/infer_x_from_y/experiment_main.py
