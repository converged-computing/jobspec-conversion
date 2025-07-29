#!/bin/bash
#FLUX --job-name=muffled-punk-1049
#FLUX -c=10
#FLUX -t=120000
#FLUX --urgency=16

$JAMG_PATH/3rd_party/bin/seqclean transcripts.fasta -c $LOCAL_CPUS -n 10000
