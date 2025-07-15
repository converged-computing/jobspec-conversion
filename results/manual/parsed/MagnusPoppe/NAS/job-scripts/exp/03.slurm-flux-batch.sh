#!/bin/bash
#FLUX: --job-name="exp03"
#FLUX: -N=6
#FLUX: --queue=EPICALL
#FLUX: -t=259200
#FLUX: --priority=16

export EA_NAS_UPLOAD_TO_FIREBASE='0'

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "SLURM INFORMATION"
echo "  NAME:                $SLURM_JOB_NAME"
echo "  WORKING DIRECTORY:   $SLURM_SUBMIT_DIR"
echo "  ID:                  $SLURM_JOB_ID"
echo "  NODES:               $SLURM_JOB_NODELIST"
echo "  NODE COUNT:          $SLURM_JOB_NUM_NODES"
echo "  PROCESSES PER NODE:  $SLURM_CPUS_ON_NODE"
echo "  TOTAL GPU PROCESSES: $SLURM_NTASKS"
echo ;
module load GCC/6.4.0-2.28
module load CUDA/9.0.176
module load OpenMPI/2.1.1
module load cuDNN/7
module load Python/3.6.3
export EA_NAS_UPLOAD_TO_FIREBASE="0"
venv/bin/python slurm_nodes.py $SLURM_JOB_NODELIST "./configurations/cifar-10/experiments/exp03.json"
echo "SERVER SETUP:        COMPLETE!";
echo "OUTPUT OF MAIN PROGRAM:"
if [ $SLURM_JOB_NUM_NODES = 1 ]; then
    venv/bin/python start_ea_nas.py ./configurations/cifar-10/experiments/exp03.json
else
    mpiexec -n $SLURM_NTASKS venv/bin/python -m mpi4py.futures start_ea_nas.py ./configurations/cifar-10/experiments/exp03.json
fi
