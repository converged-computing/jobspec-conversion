#!/bin/bash
#FLUX: --job-name=reclusive-malarkey-3471
#FLUX: -c=4
#FLUX: --queue=normal
#FLUX: -t=300
#FLUX: --priority=16

julia --project=../. $1
oom_check $?
