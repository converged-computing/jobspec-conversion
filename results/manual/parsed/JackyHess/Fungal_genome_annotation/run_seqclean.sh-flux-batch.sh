#!/bin/bash
#FLUX: --job-name=red-car-4075
#FLUX: -c=10
#FLUX: -t=120000
#FLUX: --urgency=16

$JAMG_PATH/3rd_party/bin/seqclean transcripts.fasta -c $LOCAL_CPUS -n 10000
