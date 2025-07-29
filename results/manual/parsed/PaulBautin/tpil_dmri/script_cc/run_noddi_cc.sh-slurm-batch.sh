#!/bin/bash
#SBATCH --mail-user=paul.bautin@polymtl.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=250G
#SBATCH --time=2-00:00:00

                               # See the comment for the cpus-per-task. One general rule could be
                               # that if you have more subjects than cores/cpus (ex, if you process 38
                               # subjects on 32 cpus-per-task), you could ask for one more node.
                               # https://docs.computecanada.ca/wiki/B%C3%A9luga/en#Node_Characteristics
                               # all the node, you can keep 0.
module load StdEnv/2020 java/14.0.2 nextflow/22.10.8 apptainer/1.1.8
my_singularity_img='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/containers/scilus_1.6.0.sif' # or .img
my_input='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_tpil/data/24-04-30_fw_noddi/'
my_main_nf_noddi='/home/pabaua/projects/def-pascalt-ab/pabaua/dev_scil/noddi_flow/main.nf'
nextflow run $my_main_nf_noddi --input $my_input \
    -with-singularity $my_singularity_img -resume -with-report report.html
