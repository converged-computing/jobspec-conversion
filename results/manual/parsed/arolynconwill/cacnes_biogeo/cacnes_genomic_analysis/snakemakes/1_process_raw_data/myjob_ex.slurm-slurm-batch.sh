#!/bin/bash
#FLUX: --job-name=hairy-animal-9770
#FLUX: --queue=defq,sched_mem1TB,quicktest
#FLUX: -t=86400
#FLUX: --urgency=16

bash snakemakeslurm.sh
echo Done!!!
