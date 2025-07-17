#!/bin/bash
#FLUX: --job-name=L1C_to_L2A
#FLUX: -N=10
#FLUX: -n=10
#FLUX: -c=32
#FLUX: --queue=compute
#FLUX: --urgency=16

srun conda run -n fires3.7 python process_l1c.py
