#!/bin/bash
#FLUX: --job-name=sweep
#FLUX: --queue=cpulong
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
singularity exec ${OPENSPIEL_IMG} wandb agent ${WANDB_PROJECT}
