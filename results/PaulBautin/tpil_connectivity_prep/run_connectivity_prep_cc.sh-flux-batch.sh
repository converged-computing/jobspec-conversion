#!/bin/bash

# Flux script for TPIL Bundle Segmentation Pipeline
# Original Slurm directives translated for Flux.
# Note: Mail notification options from Slurm (--mail-user, --mail-type)
# are typically handled outside the Flux batch script itself,
# e.g., using `flux job attach` or options to `flux mini submit`.

# This would run the TPIL Bundle Segmentation Pipeline with the following resources:
#     Prebuild Singularity images: https://scil.usherbrooke.ca/pages/containers/
#     Brainnetome atlas in MNI space: https://atlas.brainnetome.org/download.html
#     FA template in MNI space: https://brain.labsolver.org/hcp_template.html

#FLUX: -N 1                   # Request 1 node
#FLUX: -c 32                  # Request 32 cores on the node for the job
                              # This corresponds to Slurm's --cpus-per-task=32 (assuming 1 task)
                              # The job will have access to all memory on the allocated node,
                              # similar to Slurm's --mem=0 on a single requested node.
#FLUX: -t 6h00m00             # Set walltime to 6 hours

#FLUX: --output=tpil_pipeline.out    # Standard output file
#FLUX: --error=tpil_pipeline.err     # Standard error file


module load StdEnv/2020 java/14.0.2 nextflow/22.10.8 apptainer/1.1.8


my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/singularity_container.sif' # or .sif
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_connectivity_prep/main_accumbofrontal.nf'
my_input_tr_con='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23-07-05_tractoflow_bundling_con/results'
my_input_fs_con='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23_02_09_control_freesurfer_output'
my_input_tr_clbp='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23-07-05_tractoflow_bundling/results'
my_input_fs_clbp='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-09-21_t1_clbp_freesurfer_output'
my_licence_fs='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_connectivity_prep/freesurfer_data/license.txt'
my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/mni_masked.nii.gz'


nextflow run $my_main_nf  \
  --input_tr $my_input_tr_clbp \
  --input_fs $my_input_fs_clbp \
  --licence_fs $my_licence_fs \
  --template $my_template \
  -with-singularity $my_singularity_img \
  -profile compute_canada \
  -resume


# module load StdEnv/2020 java/14.0.2 nextflow/21.10.3 apptainer/1.1.8


# my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.5.0.sif' # or .img
# my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/connectoflow/main.nf'
# my_input_con_BN='/home/pabaua/scratch/tpil_dev/results/control/23-08-17_connectflow/results'
# my_input_clbp_BN='/home/pabaua/scratch/tpil_dev/results/clbp/23-08-17_connectflow/results'
# my_input_con_schaefer='/home/pabaua/scratch/tpil_dev/results/control/23-08-17_connectflow_schaefer/results'
# my_input_clbp_schaefer='/home/pabaua/scratch/tpil_dev/results/clbp/23-08-17_connectflow_schaefer/results'
# my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/mni_masked.nii.gz'
# my_labels_list_BN='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_connectivity_prep/freesurfer_data/atlas_brainnetome_first_label_list.txt'
# my_labels_list_schaefer='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_connectivity_prep/freesurfer_data/atlas_schaefer_200_first_label_list.txt'

# NXF_DEFAULT_DSL=1 nextflow run $my_main_nf \
#   --input $my_input_con_BN \
#   --labels_list $my_labels_list_BN \
#   --labels_img_prefix 'BN_' \
#   --template $my_template \
#   --apply_t1_labels_transfo false \
#   -with-singularity $my_singularity_img \
#   -resume