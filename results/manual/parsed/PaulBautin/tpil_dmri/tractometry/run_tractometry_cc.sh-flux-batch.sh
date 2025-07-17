#!/bin/bash
#FLUX: --job-name=astute-truffle-5644
#FLUX: -c=32
#FLUX: -t=10800
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.4.2.sif' # or .sif
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_dmri/tractometry/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23-02-13_tractometry_clbp/'
nextflow run $my_main_nf --input $my_input --nb_points 20 \
    -with-singularity $my_singularity_img -resume --use_provided_centroids false
