#!/bin/bash
#FLUX: --job-name=torch
#FLUX: --queue=main
#FLUX: -t=1879200
#FLUX: --urgency=16

srun bash child.sh
