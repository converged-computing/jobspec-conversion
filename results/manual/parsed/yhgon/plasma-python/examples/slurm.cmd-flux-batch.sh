#!/bin/bash
#FLUX: --job-name=gloopy-butter-3885
#FLUX: --priority=16

export PYTHONHASHSEED='0'
export OMPI_MCA_btl='tcp,self,sm'

export PYTHONHASHSEED=0
module load anaconda
source activate pppl
module load cudatoolkit/8.0
module load cudnn/cuda-8.0/6.0
module load openmpi/cuda-8.0/intel-17.0/2.1.0/64
module load intel/17.0/64/17.0.4.196 intel-mkl/2017.3/4/64
rm /tigress/$USER/model_checkpoints/*
rm /tigress/$USER/results/*
rm /tigress/$USER/csv_logs/*
rm /tigress/$USER/Graph/*
rm /tigress/$USER/normalization/*
export OMPI_MCA_btl="tcp,self,sm"
srun python mpi_learn.py
