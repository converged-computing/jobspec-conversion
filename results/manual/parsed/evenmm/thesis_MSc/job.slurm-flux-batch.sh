#!/bin/bash
#FLUX: --job-name=b.5-200-parallel
#FLUX: -c=2
#FLUX: --queue=CPUQ
#FLUX: -t=356400
#FLUX: --urgency=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "The job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
module purge
module load GCC/7.3.0-2.30
module load CUDA/9.2.88
module load OpenMPI/3.1.1
module load Python/3.6.6
source pythonhome/bin/activate
echo "Running and timing the code parallelly, but no printing until it's done..."
/usr/bin/time -v python cluster-parallel-robustness-evaluation.py $SLURM_ARRAY_TASK_ID
uname -a
deactivate
