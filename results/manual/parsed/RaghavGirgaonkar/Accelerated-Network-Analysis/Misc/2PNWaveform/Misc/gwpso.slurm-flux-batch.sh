#!/bin/bash
#FLUX: --job-name=rungwpso
#FLUX: --queue=normal
#FLUX: -t=10800
#FLUX: --urgency=16

module load matlab
matlab -batch  "cd /work/09197/raghav/ls6/Accelerated-Network-Analysis/2PNWaveform; rungwpso"
