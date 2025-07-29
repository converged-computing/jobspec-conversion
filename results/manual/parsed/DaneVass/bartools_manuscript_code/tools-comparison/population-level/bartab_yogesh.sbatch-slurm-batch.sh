#!/bin/bash
#FLUX: --job-name=bartab_yogesh
#FLUX: -n=20
#FLUX: --queue=prod_med
#FLUX: -t=3600
#FLUX: --urgency=16

export NXF_SINGULARITY_LIBRARYDIR='/scratch/users/hholze/BARtab/singularity/"    # your singularity storage dir'

module purge
module load singularity/3.7.3
module load nextflow/23.04.1
export NXF_SINGULARITY_LIBRARYDIR="/scratch/users/hholze/BARtab/singularity/"    # your singularity storage dir
{ time ( nextflow run /researchers/henrietta.holze/splintr_tools/BARtab/BARtab.nf \
  -profile singularity \
  -params-file /dawson_genomics/Projects/bartools_bartab_paper/scripts/yogesh_comparison/bartab_yogesh_all_samples_variable_length_params.yaml \
  -w "/dawson_genomics/Projects/bartools_bartab_paper/results/yogesh_comparison/work/" ) } 2> bartab_yogesh_runtime.txt
