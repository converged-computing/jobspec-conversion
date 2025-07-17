#!/bin/bash
#FLUX: --job-name=hairy-leg-4130
#FLUX: --exclusive
#FLUX: --urgency=16

MYPATH=/proj/nobackup/<your-proj-id>/<your-user-dir>/HPC-python/Exercises/examples/programs/
ml purge > /dev/null 2>&1
ml GCC/10.2.0 CUDA/11.1.1 OpenMPI/4.0.5
ml TensorFlow/2.4.1
ml Horovod/0.21.1-TensorFlow-2.4.1
list_of_nodes=$( scontrol show hostname $SLURM_JOB_NODELIST | sed -z 's/\n/\:4,/g' )
list_of_nodes=${list_of_nodes%?}
mpirun -np $SLURM_NTASKS -H $list_of_nodes python Transfer_Learning_NLP_Horovod.py --epochs 10 --batch-size 64
