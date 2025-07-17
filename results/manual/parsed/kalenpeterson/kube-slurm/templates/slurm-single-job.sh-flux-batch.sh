#!/bin/bash
#FLUX: --job-name=slurm-single-job
#FLUX: --urgency=16

export KUBE_IMAGE='registry.local:31500/job-test:latest'
export KUBE_WORK_VOLUME='/nas/volumes/homes/dgx'

export KUBE_IMAGE=registry.local:31500/job-test:latest
export KUBE_WORK_VOLUME=/nas/volumes/homes/dgx
srun ../wrappers/kube-slurm-image-job.sh
