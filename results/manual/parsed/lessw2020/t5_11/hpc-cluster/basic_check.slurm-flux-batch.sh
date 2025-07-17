#!/bin/bash
#FLUX: --job-name=ior
#FLUX: -n=4
#FLUX: --urgency=16

mpirun  hostname
nvidia-smi
