#!/bin/bash
#FLUX: --job-name=reclusive-poodle-9246
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --urgency=16

nvidia-smi
bede-mpirun --bede-par 1ppg -np 1 ~/parafem/parafem/bin/xx3 xx3_small
