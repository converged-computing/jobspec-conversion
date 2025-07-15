#!/bin/bash
#FLUX: --job-name=anxious-blackbean-0745
#FLUX: -c=32
#FLUX: -t=21600
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
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
