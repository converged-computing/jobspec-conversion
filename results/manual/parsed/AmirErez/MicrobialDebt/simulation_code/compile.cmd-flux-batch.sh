#!/bin/bash
#FLUX --job-name=fugly-frito-0504
#FLUX -t=64800
#FLUX --urgency=16

export MCR_CACHE_ROOT='/tmp/$SLURM_JOB_ID'

module load matlab/2021a mcc
export MCR_CACHE_ROOT=/tmp/$SLURM_JOB_ID
mcc -mv automated_run_serialdil.m
