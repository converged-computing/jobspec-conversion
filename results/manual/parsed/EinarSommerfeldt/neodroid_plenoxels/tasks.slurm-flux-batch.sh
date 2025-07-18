#!/bin/bash
#FLUX: --job-name=plenoxels_tasks
#FLUX: --queue=GPUQ
#FLUX: -t=1800
#FLUX: --urgency=16

echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo "the name of the job is: $SLURM_JOB_NAME"
echo "The job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"
echo "Total of GPUS: $CUDA_VISIBLE_DEVICES"
nvidia-smi
nvidia-smi nvlink -s
nvidia-smi topo -m
module purge
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0
cd /cluster/home/einarjso/neodroid_plenoxels/svox2/opt
python autotune_neodroid.py -g '0' tasks/neodroid/niters_tuning.json
