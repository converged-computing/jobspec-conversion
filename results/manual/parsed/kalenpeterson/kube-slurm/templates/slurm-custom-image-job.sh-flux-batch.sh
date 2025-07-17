#!/bin/bash
#FLUX: --job-name=slurm-single-job
#FLUX: --urgency=16

export KUBE_IMAGE='tensorflow:custom'
export KUBE_SCRIPT='/home/dgx/kube-slurm/containers/slurm-single-tf-job/test.sh'

export KUBE_IMAGE=tensorflow:custom
export KUBE_SCRIPT=/home/dgx/kube-slurm/containers/slurm-single-tf-job/test.sh
srun ../wrappers/kube-slurm-custom-image-job.sh
