#!/bin/bash
#FLUX: --job-name="EA NAS"
#FLUX: -N=9
#FLUX: --queue=EPICALL,V100-IDI,DEBUG
#FLUX: -t=604800
#FLUX: --priority=16

export EA_NAS_UPLOAD_TO_FIREBASE='0'

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "-- SLURM INFORMATION --"
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo "The name of the job is: $SLURM_JOB_NAME"
echo "The job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "$SLURM_JOB_NUM_NODES compute nodes with $SLURM_CPUS_ON_NODE processes each"
echo "Total of $SLURM_NTASKS processes with GPUs"
echo ;
module load GCC/6.4.0-2.28
module load CUDA/9.0.176
module load OpenMPI/2.1.1
module load cuDNN/7
module load Python/3.6.3
export EA_NAS_UPLOAD_TO_FIREBASE="0"
echo "-- SETTING UP SERVERS --"; echo;
venv/bin/python slurm_nodes.py $SLURM_JOB_NODELIST "./configurations/cifar-10/slurm.json"
echo "-- OUTPUT OF MAIN PROGRAM --"; echo;
if [ $SLURM_JOB_NUM_NODES = 1 ]; then
    venv/bin/python start_ea_nas.py ./configurations/cifar-10/slurm.json
else
    mpiexec -n $SLURM_NTASKS venv/bin/python -m mpi4py.futures start_ea_nas.py ./configurations/cifar-10/slurm.json
fi
