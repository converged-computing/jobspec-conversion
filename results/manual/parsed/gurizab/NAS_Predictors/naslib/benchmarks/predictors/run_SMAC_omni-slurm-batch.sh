#!/bin/bash
#FLUX: --job-name=OMNI_SMAC
#FLUX: -c=4
#FLUX: --queue=mlhiwidlc_gpu-rtx2080
#FLUX: --urgency=16

export PATH='$PATH:/home/zabergjg/miniconda3/envs/naslib/lib/python3.7/'

source ~/.bashrc
conda activate DL_Lab
echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION";
export PATH=$PATH:/home/zabergjg/miniconda3/envs/naslib/lib/python3.7/
python runner_xgb.py
echo "DONE";
echo "Finished at $(date)";
