#!/bin/bash
#FLUX: --job-name=ex5
#FLUX: -c=2
#FLUX: -t=300
#FLUX: --urgency=16

SRCDIR=/project/def-sponsor00/photos/
FILTERS="grayscale edges emboss negate solarize flip flop monochrome add_noise"
../filterImage.exe --srcdir $SRCDIR --files $(ls $SRCDIR) --filters $FILTERS
