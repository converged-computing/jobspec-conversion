#!/bin/bash
#FLUX: --job-name=woojung
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --queue=ivy_v100_2
#FLUX: -t=5400
#FLUX: --urgency=16

srun python /scratch/kedu14/woojung/albert/mycode/albert_practice.py
