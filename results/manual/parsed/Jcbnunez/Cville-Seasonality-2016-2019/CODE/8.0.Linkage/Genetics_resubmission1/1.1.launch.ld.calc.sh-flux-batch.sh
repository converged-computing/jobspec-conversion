#!/bin/bash
#FLUX: --job-name=ornery-despacito-3897
#FLUX: --priority=16

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
Rscript \
--vanilla \
1.0.calculate_linkage_w_inversion.r
date
echo "done"
