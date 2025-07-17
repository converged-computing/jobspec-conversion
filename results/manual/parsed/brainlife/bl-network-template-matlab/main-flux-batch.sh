#!/bin/bash
#FLUX: --job-name=template
#FLUX: -t=900
#FLUX: --urgency=16

singularity exec -e docker://brainlife/mcr:r2019a ./compiled/main config.json
