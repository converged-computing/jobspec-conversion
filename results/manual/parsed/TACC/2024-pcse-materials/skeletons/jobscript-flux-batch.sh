#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -n=10
#FLUX: --queue=vm-small
#FLUX: -t=600
#FLUX: --urgency=16

module list
pwd
date
ibrun ./myprogram 
