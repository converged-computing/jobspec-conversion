#!/bin/bash
#FLUX: --job-name=robustness
#FLUX: --queue=gpu-2080ti-preemptable
#FLUX: --urgency=16

scontrol show job "$SLURM_JOB_ID"
row="2" # This is the row in the table
singularity exec --nv -B /scratch_local \
    -B "$IMAGENET_C_PATH":/ImageNet-C:ro \
    -B "$CHECKPOINT_PATH":/checkpoints:ro \
    -B .:/batchnorm \
    -B ..:/deps \
    docker://georgepachitariu/robustness:latest \
    bash /batchnorm/scripts/paper/table1.sh $row 2>&1
