#!/bin/bash
#FLUX: --job-name=lovable-pedo-8130
#FLUX: -t=900
#FLUX: --urgency=16

singularity exec -e docker://brainlife/mcr:r2019a ./compiled/main config.json
