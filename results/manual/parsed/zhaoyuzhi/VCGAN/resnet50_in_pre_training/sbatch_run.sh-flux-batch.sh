#!/bin/bash
#FLUX: --job-name=resnet50_fc_in
#FLUX: --urgency=16

srun --mpi=pmi2 sh ./run.sh
