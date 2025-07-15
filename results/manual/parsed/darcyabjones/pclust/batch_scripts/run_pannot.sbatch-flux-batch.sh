#!/bin/bash
#FLUX: --job-name=lovely-poodle-9510
#FLUX: -c=28
#FLUX: --queue=workq
#FLUX: -t=86400
#FLUX: --urgency=16

module load nextflow/18.10.1-bin
nextflow run -resume -profile pawsey_zeus ./pannot.nf --max_cpus 28 --seqs "sequences/proteins.faa" --nosignalp --nolocalizer --notargetp --notmhmm --nophobius --noeffectorp
