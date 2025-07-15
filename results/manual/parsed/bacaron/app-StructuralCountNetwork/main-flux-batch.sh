#!/bin/bash
#FLUX: --job-name=joyous-lemon-3014
#FLUX: -t=900
#FLUX: --urgency=16

singularity exec -e docker://brainlife/mcr:r2019a ./compiled/main config.json
