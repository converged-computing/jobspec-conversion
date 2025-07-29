#!/bin/bash
#FLUX: --job-name=sample
#FLUX: -n=2
#FLUX: --queue=defq
#FLUX: -t=60
#FLUX: --urgency=16

module load apptainer
apptainer pull docker://<image>
if ! test -f container.sif; then
  echo "Container does not exist...building"
  apptainer build container.sif recipe.def
fi
apptainer exec container.sif <command>
