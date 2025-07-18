#!/bin/bash
#FLUX: --job-name=tmp
#FLUX: --queue=medium
#FLUX: -t=4200
#FLUX: --urgency=16

export singularity_image='$HOME/Tools/maffilter_v1.3.1dfsg-1b1-deb_cv1.sif'
export maffilter_optionfile='d1_optionfiles/1_1_optionfile_tmp.maffilter'

module purge
module load singularity/3.7.4 # singularity/3.2.1
export singularity_image="$HOME/Tools/maffilter_v1.3.1dfsg-1b1-deb_cv1.sif"
export maffilter_optionfile="d1_optionfiles/1_1_optionfile_tmp.maffilter"
singularity exec ${singularity_image} sh -c "cd '$HOME/Nectar/analysis/CNEEanalysis_2021/02_cnee_liftover' &&
maffilter param=${maffilter_optionfile}"
