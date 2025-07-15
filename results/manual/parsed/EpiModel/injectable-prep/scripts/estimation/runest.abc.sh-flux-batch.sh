#!/bin/bash
#FLUX: --job-name=lap-estabc
#FLUX: -t=3600
#FLUX: --urgency=16

. /suppscr/csde/sjenness/spack/share/spack/setup-env.sh
module load gcc-8.1.0-gcc-4.4.7-eaajvcy
module load r-3.5.1-gcc-8.1.0-unb32sy
Rscript estim.abc.R
