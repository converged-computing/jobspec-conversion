#!/bin/bash
#FLUX: --job-name=blank-fudge-2500
#FLUX: -c=32
#FLUX: -t=86400
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/21.10.3 apptainer/1.1.8
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.5.0.sif' # or .img
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/connectoflow/main.nf'
my_input='/home/pabaua/scratch/tpil_dev/results/clbp/23-08-15_connectivity_prep/results'
my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/mni_masked.nii.gz'
my_labels_list='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/atlas_brainnetome_first_label_list.txt'
NXF_DEFAULT_DSL=1 nextflow run $my_main_nf --input $my_input --labels_list $my_labels_list --template $my_template \
    --apply_t1_labels_transfo false -with-singularity $my_singularity_img -resume
