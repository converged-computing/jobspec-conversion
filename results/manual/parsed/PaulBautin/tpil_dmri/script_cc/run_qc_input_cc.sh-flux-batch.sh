#!/bin/bash
#FLUX: --job-name=cowy-cherry-3873
#FLUX: -c=32
#FLUX: -t=3600
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/21.10.3 singularity/3.8
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.3.0.sif' # or .img
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/dmriqc_flow/main.nf'
my_input='/home/pabaua/scratch/tpil_dev/results/clbp/22-11-25_bundle_seg/results_bundle/'
nextflow run $my_main_nf -profile rbx_qc --input $my_input \
    -with-singularity $my_singularity_img -resume
