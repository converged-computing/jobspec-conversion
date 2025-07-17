#!/bin/bash
#FLUX: --job-name=unnamed job
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=432000
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
echo Host: 
hostname
echo
echo CUDA_VISIBLE_DEVICES:
echo $CUDA_VISIBLE_DEVICES
echo
echo running command:
echo $@
echo
$@
