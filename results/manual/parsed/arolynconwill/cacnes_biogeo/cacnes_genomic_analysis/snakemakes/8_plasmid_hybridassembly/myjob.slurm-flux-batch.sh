#!/bin/bash
#FLUX: --job-name=SMplasmid.main
#FLUX: --queue=sched_mem1TB,defq
#FLUX: -t=86400
#FLUX: --urgency=16

bash snakemakeslurm.sh
echo Done!!!
