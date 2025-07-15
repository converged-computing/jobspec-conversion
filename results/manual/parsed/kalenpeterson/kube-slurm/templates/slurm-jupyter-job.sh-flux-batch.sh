#!/bin/bash
#FLUX: --job-name=slurm-jupyter-job
#FLUX: --priority=16

export KUBE_IMAGE='KUBE_IMAGE=registry.local:31500/slurm-tensorflow:latest'

export KUBE_IMAGE=KUBE_IMAGE=registry.local:31500/slurm-tensorflow:latest
srun ../wrappers/kube-slurm-jupyter-job.sh
