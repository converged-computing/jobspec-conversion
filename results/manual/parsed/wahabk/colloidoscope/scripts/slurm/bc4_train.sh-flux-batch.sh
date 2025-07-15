#!/bin/bash
#FLUX: --job-name=torch-train
#FLUX: --queue=veryshort
#FLUX: -t=2700
#FLUX: --priority=16

export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'

module load CUDA
module load languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch
module load languages/intel/2017.01
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
nvidia-smi
nvcc --version
echo 'My torch test'
source activate #!activate conda
conda activate colloids
application="python3"
options="scripts/bc4.py"
cd $SLURM_SUBMIT_DIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo Slurm job ID is $SLURM_JOBID
echo This jobs runs on the following machines:
echo $SLURM_JOB_NODELIST
$application $options
