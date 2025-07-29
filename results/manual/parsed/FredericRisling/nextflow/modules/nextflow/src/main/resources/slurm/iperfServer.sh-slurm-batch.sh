#!/bin/bash
#FLUX: --job-name=wobbly-fork-4693
#FLUX: -t=1200
#FLUX: --urgency=16

srun iperf -s
