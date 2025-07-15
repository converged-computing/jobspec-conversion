#!/bin/bash
#FLUX: --job-name=muffled-noodle-2289
#FLUX: --urgency=16

module load matlab
matlab -batch  "cd /work/09197/raghav/ls6/Accelerated-Network-Analysis/2PNWaveform; rungwpso"
