#!/bin/bash
#FLUX: --job-name=crunchy-taco-0325
#FLUX: -t=86400
#FLUX: --priority=16

export TMPDIR='$SCRATCH'

export TMPDIR=$SCRATCH
/global/homes/a/aramreye/Software/julia-1.5.1/bin/julia --project=@. -e 'using RamirezReyes_Yang_SpontaneousCyclogenesis;  RamirezReyes_Yang_SpontaneousCyclogenesis.computebudgets_nosmoothing("f5e-4_2km_1000km_control")'
