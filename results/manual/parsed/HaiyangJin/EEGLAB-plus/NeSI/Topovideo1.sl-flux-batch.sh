#!/bin/bash
#FLUX: --job-name=topomovie1
#FLUX: --queue=prepost
#FLUX: -t=7200
#FLUX: --urgency=16

module load MATLAB/2017b
matlab -nodisplay -r Topovideo1
