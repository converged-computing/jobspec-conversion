#!/bin/bash
#FLUX: --job-name="Path"
#FLUX: -c=64
#FLUX: --queue=epyc2
#FLUX: -t=43200
#FLUX: --priority=16

export RUST_LOG='info'

SCENE=./images/refracting-spheres/20000
export RUST_LOG=info
srun ./spectral $SCENE
