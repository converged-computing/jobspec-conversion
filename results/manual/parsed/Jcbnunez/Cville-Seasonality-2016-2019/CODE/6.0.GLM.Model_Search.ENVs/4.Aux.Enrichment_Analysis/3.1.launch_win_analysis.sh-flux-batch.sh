#!/bin/bash
#FLUX: --job-name=joyous-blackbean-7556
#FLUX: --priority=16

module load spack/spack-0.18.1
spack load r@4.2.1 r-sf
Rscript \
--vanilla \
3.Window.level.enrrichment.r
date
echo "done"
