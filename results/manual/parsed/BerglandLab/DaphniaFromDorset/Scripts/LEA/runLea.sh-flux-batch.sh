#!/bin/bash
#FLUX: --job-name=arid-leader-5348
#FLUX: --urgency=16

module load intel/18.0 intelmpi/18.0 R/3.6.3
wd=/scratch/aob2x/daphnia_hwe_sims/
Rscript ${wd}/DaphniaPulex20162017Sequencing/AlanAnalysis/LEA/runLea.R
