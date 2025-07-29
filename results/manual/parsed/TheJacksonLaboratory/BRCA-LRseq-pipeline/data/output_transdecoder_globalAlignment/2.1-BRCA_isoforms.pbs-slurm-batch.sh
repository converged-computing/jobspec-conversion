#!/bin/bash
#FLUX: --job-name=transdecoder_downstream
#FLUX: -n=32
#FLUX: --queue=batch
#FLUX: -t=43200
#FLUX: --urgency=16

set -u
dir_r=/projects/banchereau-lab/tools/3_4_4/bin
$dir_r/R CMD BATCH /projects/dveiga/analysis/git/BRCA_isoforms/transdecoder_globalAlignment/2.1-BRCA_isoforms.R
