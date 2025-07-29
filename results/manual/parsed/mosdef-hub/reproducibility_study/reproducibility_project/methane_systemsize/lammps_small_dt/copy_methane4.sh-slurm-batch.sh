#!/bin/bash
#FLUX: --job-name=copy_methane4
#FLUX: -t=86700
#FLUX: --urgency=16

. /home/rs/anaconda3/etc/profile.d/conda.sh
conda activate mosdef-study38
rsync -av /home/rs/space/projects/final_repro_methane/reproducibility_study/reproducibility_project/methane_systemsize_subproject4/* .
