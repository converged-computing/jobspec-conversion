#!/bin/bash
#FLUX --job-name=lovable-frito-5768
#FLUX -t=900
#FLUX --urgency=16

singularity exec -e docker://brainlife/mcr:r2019a ./compiled/main config.json
