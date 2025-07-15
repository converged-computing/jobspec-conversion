#!/bin/bash
#FLUX: --job-name=reclusive-hobbit-6010
#FLUX: -c=10
#FLUX: --urgency=16

$JAMG_PATH/3rd_party/bin/seqclean transcripts.fasta -c $LOCAL_CPUS -n 10000
