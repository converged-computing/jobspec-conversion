#!/bin/bash
#FLUX: --job-name=te_mpi
#FLUX: -n=4
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --priority=16

export PYTHONPATH='/usr/users/$USER/IDTxl'
export JAVA_HOME='/usr/users/$USER/jdk-16.0.1'

cd /usr/users/$USER
export PYTHONPATH=/usr/users/$USER/IDTxl
export JAVA_HOME=/usr/users/$USER/jdk-16.0.1
date
srun --nodes 4 -n 4 --mpi=pmi2 python -m mpi4py.futures "IDTxl/demos/demo_multivariate_te_mpi.py" 3
wait
date
srun --nodes 3 -n 3 --mpi=pmi2 python -m mpi4py.futures "IDTxl/demos/demo_multivariate_te_mpi.py" 2
wait
date
srun --nodes 2 -n 2 --mpi=pmi2 python -m mpi4py.futures "IDTxl/demos/demo_multivariate_te_mpi.py" 1
wait
date
srun --nodes 1 -n 1 --mpi=pmi2 python -m mpi4py.futures "IDTxl/demos/demo_multivariate_te_mpi.py" 0
wait
date
