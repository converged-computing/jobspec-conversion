#!/bin/bash
#FLUX: --job-name=test
#FLUX: -n=40
#FLUX: --queue=savio
#FLUX: -t=1800
#FLUX: --priority=16

export MDCE_OVERRIDE_EXTERNAL_HOSTNAME='$(/bin/hostname -f)'

module load matlab
export MDCE_OVERRIDE_EXTERNAL_HOSTNAME=$(/bin/hostname -f)
matlab -nodisplay -nosplash -nodesktop < helloworld_parallel.m
