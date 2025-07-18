#!/bin/bash
#FLUX: --job-name=earthquake-a100
#FLUX: --queue=bii-gpu
#FLUX: -t=259200
#FLUX: --urgency=16

echo "###############################################################"
echo "# ENVIRONMENT                                                 #"
echo "###############################################################"
CODE_DIR=$(dirname $(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}'))
echo "Working in $(pwd)"
HOSTNAME=`hostname`
echo "HOSTNAME:              $HOSTNAME"
echo "SLURM_CPUS_ON_NODE:    $SLURM_CPUS_ON_NODE"
echo "SLURM_CPUS_PER_GPU:    $SLURM_CPUS_PER_GPU"
echo "SLURM_GPU_BIND:        $SLURM_GPU_BIND"
echo "SLURM_JOB_ACCOUNT:     $SLURM_JOB_ACCOUNT"
echo "SLURM_JOB_GPUS:        $SLURM_JOB_GPUS"
echo "SLURM_JOB_ID:          $SLURM_JOB_ID"
echo "SLURM_JOB_PARTITION:   $SLURM_JOB_PARTITION"
echo "SLURM_JOB_RESERVATION: $SLURM_JOB_RESERVATION"
echo "SLURM_SUBMIT_HOST:     $SLURM_SUBMIT_HOST"
nvidia-smi
echo "###############################################################"
echo "# CODE SETUP                                                  #"
echo "###############################################################"
BASENAME=FFFFWNPFEARTHQ_newTFTv29-mllog
NOTEBOOK_IN=${BASENAME}.ipynb
NOTEBOOK_OUT=${BASENAME}-output.ipynb
echo "###############################################################"
echo "# GPU MONITOR                                                 #"
echo "###############################################################"
singularity exec --nv --bind /sfs/weka:/sfs/weka ../../earthquake.sif cms gpu watch --gpu=0 --delay=1 --dense > gpu0.log &
echo "###############################################################"
echo "# RUN CODE                                                    #"
echo "###############################################################"
allocations
singularity exec --nv --bind /sfs/weka:/sfs/weka ../../earthquake.sif \
          bash -c \
          "papermill ${CODE_DIR}/${NOTEBOOK_IN} \
          ${CODE_DIR}/${NOTEBOOK_OUT} \
          --no-progress-bar --log-output --execution-timeout=-1 --log-level INFO"
allocations
echo "###############################################################"
echo "# EFFICIENCY MONITOR                                          #"
echo "###############################################################"
seff $SLURM_JOB_ID
echo "###############################################################"
echo "# END SCRIPT                                                  #"
echo "###############################################################"
