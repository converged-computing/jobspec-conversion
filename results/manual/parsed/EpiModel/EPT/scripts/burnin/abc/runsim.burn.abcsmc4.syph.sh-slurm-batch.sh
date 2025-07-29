#!/bin/bash
#FLUX: --job-name=slurm-test
#FLUX: -t=0
#FLUX: --urgency=16

. /suppscr/csde/sjenness/spack/share/spack/setup-env.sh
module load gcc-8.2.0-gcc-4.8.5-rhsxipz
module load r-3.5.1-gcc-8.2.0-4suigve
Rscript sim.burn.abcsmc4.syph.R
