#!/bin/bash
#FLUX: --job-name="o_train_STREAM"
#FLUX: --queue=GPUQ
#FLUX: -t=172800
#FLUX: --priority=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"
module load GCCcore/.8.3.0
module load Python/3.7.4
source ../../.virtualenvs/masters-project/bin/activate
cd ../code
python pretrain_STREAM.py --cfg cfg/pretrain_STREAM_original.yml
