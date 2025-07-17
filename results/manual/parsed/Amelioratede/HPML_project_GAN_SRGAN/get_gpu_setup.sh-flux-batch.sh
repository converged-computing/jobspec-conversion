#!/bin/bash
#FLUX: --job-name=setup
#FLUX: -c=20
#FLUX: -t=50400
#FLUX: --urgency=16

nvidia-smi -L
nvidia-smi -l 60
