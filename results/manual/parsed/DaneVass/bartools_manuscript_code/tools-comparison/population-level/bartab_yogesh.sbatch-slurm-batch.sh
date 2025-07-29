#!/bin/bash
#SBATCH --job-name=bartab_yogesh
#SBATCH --output=logs/%x.%j.out
#SBATCH --error=logs/%x.%j.err
#SBATCH --mail-user=henrietta.holze@petermac.org
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32GB
#SBATCH --time=01:00:00
#SBATCH --partition=prod_med

export NXF_SINGULARITY_LIBRARYDIR='/scratch/users/hholze/BARtab/singularity/"    # your singularity storage dir'

module purge
module load singularity/3.7.3
module load nextflow/23.04.1
export NXF_SINGULARITY_LIBRARYDIR="/scratch/users/hholze/BARtab/singularity/"    # your singularity storage dir
{ time ( nextflow run /researchers/henrietta.holze/splintr_tools/BARtab/BARtab.nf \
  -profile singularity \
  -params-file /dawson_genomics/Projects/bartools_bartab_paper/scripts/yogesh_comparison/bartab_yogesh_all_samples_variable_length_params.yaml \
  -w "/dawson_genomics/Projects/bartools_bartab_paper/results/yogesh_comparison/work/" ) } 2> bartab_yogesh_runtime.txt
