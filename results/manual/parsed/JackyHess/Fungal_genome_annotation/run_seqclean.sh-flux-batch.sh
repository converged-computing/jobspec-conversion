#!/bin/bash
#FLUX: --job-name=psycho-poo-0189
#FLUX: -c=10
#FLUX: --priority=16

$JAMG_PATH/3rd_party/bin/seqclean transcripts.fasta -c $LOCAL_CPUS -n 10000
