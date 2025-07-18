#!/bin/bash
#FLUX: --job-name=phat-chip-3828
#FLUX: -N=3
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

export OMPI_MCA_btl='tcp,self,sm'

module load anaconda/4.4.0
source activate PPPL
module load cudatoolkit/8.0
module load cudnn/cuda-8.0/6.0
module load openmpi/cuda-8.0/intel-17.0/2.1.0/64
module load intel/17.0/64/17.0.4.196
rm /scratch/gpfs/$USER/model_checkpoints/*
rm /scratch/gpfs/$USER/results/*
rm /scratch/gpfs/$USER/csv_logs/*
rm /scratch/gpfs/$USER/Graph/*
rm /scratch/gpfs/$USER/normalization/*
export OMPI_MCA_btl="tcp,self,sm"
srun python mpi_learn.py
