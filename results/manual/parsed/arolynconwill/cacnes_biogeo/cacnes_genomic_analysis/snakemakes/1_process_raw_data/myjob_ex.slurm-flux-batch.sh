#!/bin/bash
#FLUX: --job-name=stinky-house-1719
#FLUX: --queue=defq,sched_mem1TB,quicktest
#FLUX: -t=86400
#FLUX: --urgency=16

bash snakemakeslurm.sh
echo Done!!!
