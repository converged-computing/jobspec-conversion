#!/bin/bash
#FLUX: --job-name=road_detector
#FLUX: --queue=GPUQ
#FLUX: -t=18000
#FLUX: --urgency=16

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
module purge
module load fosscuda/2020b
module load Anaconda3/2020.07
nvidia-smi
PYTHONPATH=/cluster/home/jorgro/road-detector python ./tools/train.py ./configs/road_detector.py --work-dir ./runs
uname -a
