#!/bin/bash
#FLUX: --job-name=slurm-test
#FLUX: -t=7200
#FLUX: --urgency=16

. /gscratch/csde/sjenness/spack/share/spack/setup-env.sh
module load gcc-8.2.0-gcc-8.1.0-sh54wqg
module load r-3.5.2-gcc-8.2.0-sby3icq
Rscript sim.fu.ept.R
