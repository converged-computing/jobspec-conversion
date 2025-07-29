#!/bin/bash
#FLUX: --job-name=kde_ppta
#FLUX: -t=720
#FLUX: --urgency=16

pyv="$(python -c 'import sys; print(sys.version_info[0])')"
if [ "$pyv" == 2 ]
then
    echo "$pyv"
    module load numpy/1.16.3-python-2.7.14
fi
srun echo $TEMPO2
srun echo $TEMPO2_CLOCK_DIR
srun python /home/bgonchar/correlated_noise_pta_2020/publ_fig_dropout_varg.py
