#!/bin/bash
#FLUX: --job-name=frigid-lemur-5633
#FLUX: --priority=16

module load matlab
matlab -batch  "cd /work/09197/raghav/ls6/Accelerated-Network-Analysis/2PNWaveform; rungwpso"
