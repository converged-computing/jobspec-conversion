#!/bin/bash
#SBATCH --mail-user=aramirezreyes@ucdavis.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --qos=regular
#SBATCH --constraint=knl

export JULIA_NUM_THREADS='1'
export TMPDIR='$SCRATCH'

export JULIA_NUM_THREADS=1
export TMPDIR=$SCRATCH
/global/homes/a/aramreye/Software/julia-1.5.0/bin/julia --project=@. -e 'using RamirezReyes_Yang_SpontaneousCyclogenesis; smooth_vars_and_write_to_netcdf!("/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/f5e-4_2km_1000km_homoSfc_2d_smoothed.nc","/global/cscratch1/sd/aramreye/for_postprocessing/largencfiles/f5e-4_2km_1000km_homoSfc_2d.nc",("SHF","LHF","PSFC"),11,120)' 
