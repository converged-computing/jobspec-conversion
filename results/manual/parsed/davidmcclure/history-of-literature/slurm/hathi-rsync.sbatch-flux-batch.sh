#!/bin/bash
#FLUX: --job-name=hathi-rsync
#FLUX: -t=36000
#FLUX: --urgency=16

rsync -av data.sharc.hathitrust.org::pd-features/basic/ \
    /scratch/PI/malgeehe/htrc/
