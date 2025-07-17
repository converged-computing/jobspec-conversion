#!/bin/bash
#FLUX: --job-name=joyous-pancake-7818
#FLUX: -c=32
#FLUX: -t=3600
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/21.10.3 singularity/3.8
my_singularity_img='/home/pabaua/scratch/scil_dev/containers/scilus_1.3.0.sif' # or .img
my_main_nf='/home/pabaua/scratch/scil_dev/dmriqc_flow/main.nf'
my_input='/home/pabaua/scratch/tpil_dev/results/sub-DCL/22-07-07_tractoflow/results'
NXF_VER=nextflow/21.10.3 nextflow run $my_main_nf -profile tractoflow_qc_all --input $my_input \
    -with-singularity $my_singularity_img -resume
