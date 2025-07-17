#!/bin/bash
#FLUX: --job-name=R14f
#FLUX: -N=20
#FLUX: -n=1120
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --urgency=16

module list
pwd
date
ibrun ./pschism_FRONTERA_TVD-VL  5
