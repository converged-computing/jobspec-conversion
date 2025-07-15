#!/bin/bash
#FLUX: --job-name=boopy-squidward-1496
#FLUX: --priority=16

export OMPI_MCA_btl='tcp,self,vader'

module load anaconda3
conda activate my_env
module load cudatoolkit
module load cudnn
module load openmpi/cuda-8.0/intel-17.0/3.0.0/64
module load intel/19.0/64/19.0.3.199
module load hdf5/intel-17.0/intel-mpi/1.10.0
rm /tigress/$USER/model_checkpoints/*
rm /tigress/$USER/results/*
rm /tigress/$USER/csv_logs/*
rm /tigress/$USER/Graph/*
rm /tigress/$USER/normalization/*
export OMPI_MCA_btl="tcp,self,vader"
srun python mpi_learn.py
