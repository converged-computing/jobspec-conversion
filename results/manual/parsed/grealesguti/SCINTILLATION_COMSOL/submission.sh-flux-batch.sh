#!/bin/bash
#FLUX: --job-name="matlab_demo"
#FLUX: -c=2
#FLUX: --queue=compute
#FLUX: -t=14400
#FLUX: --priority=16

srun scomsoltest.sh
