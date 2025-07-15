#!/bin/bash
#FLUX: --job-name=Wrapper
#FLUX: -t=54000
#FLUX: --urgency=16

module load matlab/r2021a
module load gst-libav
matlab -nodisplay -nodesktop -nosplash < makeStimDataBase.m
