#!/bin/bash
#FLUX: --job-name=ep_vs_mhcn
#FLUX: -t=864000
#FLUX: --urgency=16

module load R Python/3.8.2-GCCcore-9.3.0 binutils ImageMagick X11 libX11 xprop
make
