#!/bin/bash
#FLUX: --job-name=butterscotch-eagle-1465
#FLUX: -t=72000
#FLUX: --urgency=16

export JULIA_NUM_THREADS='64'
export TMPDIR='$SCRATCH'

export JULIA_NUM_THREADS=64
export TMPDIR=$SCRATCH
/global/homes/a/aramreye/Software/julia-1.5.1/bin/julia --project=@. -e 'using RamirezReyes_Yang_SpontaneousCyclogenesis; get_composites_in_chunks("/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/f5e-4_2km_1000km_homoRad_homoSfc_2d.nc","/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/f5e-4_2km_1000km_homoRad_homoSfc_3d.nc","f5e-4_2km_1000km_homoRad_homoSfc")' 
