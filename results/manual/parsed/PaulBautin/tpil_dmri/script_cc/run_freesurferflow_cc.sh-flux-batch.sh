#!/bin/bash
#FLUX: --job-name=scruptious-latke-8848
#FLUX: -c=32
#FLUX: -t=86400
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/freesurfer_flow/scil_freesurfer_cc.img' # or .img
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/freesurfer_flow/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-09-21_t1_clbp_freesurfer_output'
atlas_utils='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/freesurfer_flow/FS_BN_GL_SF_utils'
NXF_DEFAULT_DSL=1 nextflow $my_main_nf --root_fs_output $my_input --atlas_utils_folder $atlas_utils \
    -with-singularity $my_singularity_img -resume -with-report report.html \
    --compute_lausanne_multiscale false
