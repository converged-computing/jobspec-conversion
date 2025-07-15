#!/bin/bash
#FLUX: --job-name=torch-train
#FLUX: --queue=test
#FLUX: -t=300
#FLUX: --priority=16

module load lang/cuda/11.1
module load lang/python/anaconda/3.8.8-2021.05-torch
nvidia-smi
nvcc --version
echo 'My torch test'
source activate #!activate conda
conda activate colloids
application="python3"
options="scripts/bp1.py"
cd $SLURM_SUBMIT_DIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job ID is $SLURM_JOBID
echo This jobs runs on the following machines:
echo $SLURM_JOB_NODELIST
$application $options
