#!/bin/bash
#FLUX: --job-name=modeltrainer
#FLUX: --priority=16

enable_lmod
module load container_env pytorch-gpu/1.9.0
crun -p ~/envs/citationparser python reshad.py
