#!/bin/bash
#FLUX: --job-name=cylStudy_MA2P1_greasy_AECNN_RNN
#FLUX: -N=65
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --priority=16

export HYPRE_ROOT='/users/novatig/hypre/build'
export GSL_ROOT='/apps/daint/UES/jenkins/7.0.UP02/gpu/easybuild/software/GSL/2.5-CrayGNU-20.08'
export CRAY_CUDA_MPS='1'
export CUDA_VISIBLE_DEVICES='0'
export GPU_DEVICE_ORDINAL='0'
export GREASY_LOGFILE='/scratch/snx3000/pvlachas/LED/Code/Results/cylReLEDStudyHR/Logs/cylStudy_MA2P1_B"$1"_greasy_AECNN_RNN_logfile_JID"${SLURM_JOBID}".txt'

module load daint-gpu
module load GREASY
module load cray-hdf5-parallel cray-fftw cray-petsc cudatoolkit GSL cray-python
export HYPRE_ROOT=/users/novatig/hypre/build
export GSL_ROOT=/apps/daint/UES/jenkins/7.0.UP02/gpu/easybuild/software/GSL/2.5-CrayGNU-20.08
module load PyTorch/1.9.0-CrayGNU-20.11
source ${HOME}/venv-python3.8-pytorch1.9/bin/activate
export CRAY_CUDA_MPS=1
export CUDA_VISIBLE_DEVICES=0
export GPU_DEVICE_ORDINAL=0
export GREASY_LOGFILE="/scratch/snx3000/pvlachas/LED/Code/Results/cylReLEDStudyHR/Logs/cylStudy_MA2P1_B"$1"_greasy_AECNN_RNN_logfile_JID"${SLURM_JOBID}".txt"
echo "GREASY - Running greasy tasks from "
echo $PWD
echo $GREASY_LOGFILE
echo "## BATCH = B"$1" ##"
greasy ./Tasks/MA2P1_B$1_greasy_AECNN_RNN_tasks.txt
