#!/bin/bash
#FLUX: --job-name=wobbly-parsnip-0924
#FLUX: --priority=16

set -u
dir_r=/projects/banchereau-lab/tools/3_4_4/bin
$dir_r/R CMD BATCH /projects/dveiga/analysis/git/BRCA_isoforms/transdecoder_globalAlignment/2.1-BRCA_isoforms.R
