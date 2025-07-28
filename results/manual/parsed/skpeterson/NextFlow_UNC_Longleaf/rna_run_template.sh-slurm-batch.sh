#!/bin/bash
#FLUX: --job-name=rna_nf
#FLUX: -n=16
#FLUX: -t=172800
#FLUX: --urgency=16

cd /work/users/path/to/work
module load nextflow/23.04.2;
module load apptainer/1.2.2-1;
nextflow run nf-core/rnaseq -r 3.14.0 -profile unc_longleaf -params-file /path/to/parameter_file.yaml
