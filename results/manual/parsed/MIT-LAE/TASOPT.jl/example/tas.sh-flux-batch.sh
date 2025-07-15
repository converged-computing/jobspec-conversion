#!/bin/bash
#FLUX: --job-name=quirky-signal-0146
#FLUX: -c=4
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --urgency=16

julia --project=../. $1
oom_check $?
