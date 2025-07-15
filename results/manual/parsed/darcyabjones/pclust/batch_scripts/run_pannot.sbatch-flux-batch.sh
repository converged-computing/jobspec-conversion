#!/bin/bash
#FLUX: --job-name=wobbly-arm-7113
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --priority=16

module load nextflow/18.10.1-bin
nextflow run -resume -profile pawsey_zeus ./pannot.nf --max_cpus 28 --seqs "sequences/proteins.faa" --nosignalp --nolocalizer --notargetp --notmhmm --nophobius --noeffectorp
