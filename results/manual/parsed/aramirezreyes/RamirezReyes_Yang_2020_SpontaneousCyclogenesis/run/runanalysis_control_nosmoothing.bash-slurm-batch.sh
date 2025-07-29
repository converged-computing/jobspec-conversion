#!/bin/bash
#SBATCH --mail-user=aramirezreyes@ucdavis.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --qos=premium
#SBATCH --constraint=haswell

export TMPDIR='$SCRATCH'

export TMPDIR=$SCRATCH
/global/homes/a/aramreye/Software/julia-1.5.1/bin/julia --project=@. -e 'using RamirezReyes_Yang_SpontaneousCyclogenesis;  RamirezReyes_Yang_SpontaneousCyclogenesis.computebudgets_nosmoothing("f5e-4_2km_1000km_control")'
