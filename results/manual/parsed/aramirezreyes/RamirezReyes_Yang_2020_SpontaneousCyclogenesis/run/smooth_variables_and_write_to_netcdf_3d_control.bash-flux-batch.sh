#!/bin/bash
#FLUX: --job-name=quirky-cherry-7179
#FLUX: -t=50400
#FLUX: --urgency=16

export JULIA_NUM_THREADS='1'
export TMPDIR='$SCRATCH'

export JULIA_NUM_THREADS=1
export TMPDIR=$SCRATCH
/global/homes/a/aramreye/Software/julia-1.5.0/bin/julia --project=@. -e 'using RamirezReyes_Yang_SpontaneousCyclogenesis; smooth_vars_and_write_to_netcdf!("/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/smoothed_variables/f5e-4_2km_1000km_control_3d_smoothed.nc","/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/f5e-4_2km_1000km_control_3d.nc",("U","V", "W", "QV", "TABS", "QRAD","PP"),11,60)' 
