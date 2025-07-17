#!/bin/bash
#FLUX: --job-name=frigid-latke-6293
#FLUX: -c=32
#FLUX: -t=7200
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.4.2.sif' # or .img
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_dmri/preparation_connectflow/registration/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-11-14_connectflow_prep_control/'
my_atlas='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-11-14_connectflow_prep_clbp/BNA-maxprob-thr0-1mm.nii.gz'
my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/22-11-14_connectflow_prep_clbp/FSL_HCP1065_FA_1mm.nii.gz'
nextflow run $my_main_nf --input $my_input --atlas $my_atlas \
    -with-singularity $my_singularity_img --template $my_template -resume
