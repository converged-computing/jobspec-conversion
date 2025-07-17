#!/bin/bash
#FLUX: --job-name=hairy-lemon-4242
#FLUX: -c=32
#FLUX: -t=3600
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8
my_singularity_img='/home/pabaua/dev_scil/containers/scilus_1_3_0.img' # or .sif
my_main_nf='/home/pabaua/dev_scil/tpil_bundle_segmentation/main.nf'
my_input='/home/pabaua/dev_tpil/data/data_new_bundle'
my_atlas='/home/pabaua/dev_tpil/data/data_new_bundle/BNA-maxprob-thr0-1mm.nii.gz'
my_template='/home/pabaua/dev_tpil/data/data_new_bundle/FSL_HCP1065_FA_1mm.nii.gz'
nextflow run $my_main_nf --input $my_input --atlas $my_atlas \
    -with-singularity $my_singularity_img --template $my_template -resume
