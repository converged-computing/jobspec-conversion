#!/bin/bash
#SBATCH --mail-user=aramirezreyes@ucdavis.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=300GB
#SBATCH --time=14:00:00
#SBATCH --qos=bigmem

export JULIA_NUM_THREADS='1'
export TMPDIR='$SCRATCH'

export JULIA_NUM_THREADS=1
export TMPDIR=$SCRATCH
/global/homes/a/aramreye/Software/julia-1.5.0/bin/julia --project=@. -e 'using RamirezReyes_Yang_SpontaneousCyclogenesis; smooth_vars_and_write_to_netcdf!("/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/smoothed_variables/f5e-4_2km_1000km_control_3d_smoothed.nc","/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/f5e-4_2km_1000km_control_3d.nc",("U","V", "W", "QV", "TABS", "QRAD","PP"),11,60)' 
