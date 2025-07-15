#!/bin/bash
#FLUX: --job-name=lovely-destiny-4157
#FLUX: -c=32
#FLUX: -t=21600
#FLUX: --urgency=16

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/22.04.3 singularity/3.8
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.4.2.sif' # or .sif
my_main_nf='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/tpil_bundle_segmentation/main.nf'
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/23-02-13_bundle_segmentation_control/'
my_atlas='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/BNA-maxprob-thr0-1mm.nii.gz'
my_template='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/atlas/FSL_HCP1065_FA_1mm.nii.gz'
nextflow run $my_main_nf --input $my_input --atlas $my_atlas \
    -with-singularity $my_singularity_img --template $my_template -resume
module load nextflow/21.10.3
my_main_nf_qc='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/dmriqc_flow/main.nf'
my_input_qc='/home/pabaua/scratch/tpil_dev/results/clbp/23-02-13_accumbofrontal_segmentation/results_bundle'
NXF_VER=21.10.3 nextflow run $my_main_nf_qc -profile rbx_qc --input $my_input_qc \
    -with-singularity $my_singularity_img -resume
