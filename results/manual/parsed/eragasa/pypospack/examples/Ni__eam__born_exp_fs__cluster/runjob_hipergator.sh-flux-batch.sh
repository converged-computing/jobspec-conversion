#!/bin/bash
#FLUX: --job-name=Ni_fs
#FLUX: -n=16
#FLUX: -t=43200
#FLUX: --urgency=16

export OMPI_MCA_pml='^ucx'

pwd; hostname; date
module load intel/2018.1.163
module load openmpi/3.1.2
echo PYTHONPATH=$PYTHONPATH
PYTHON_BIN=$(which python)
echo PYTHON_BIN=$PYTHON_BIN
echo python=$(which python)
echo PATH=$PATH
echo "start_time:$(date)"
export OMPI_MCA_pml=^ucx
srun --mpi=pmi2 $PYTHON_BIN run__iterative_cluster_sampling.py
echo "end_time:$(date)"
