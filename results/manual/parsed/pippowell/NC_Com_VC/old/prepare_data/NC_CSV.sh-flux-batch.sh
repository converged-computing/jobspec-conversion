#!/bin/bash
#FLUX: --job-name=carnivorous-staircase-3071
#FLUX: -t=43200
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/p/ppowell/miniconda3/envs/EEG_Vis_CL/lib/'

echo "running in shell: " "$SHELL"
echo "*** loading spack modules ***"
source ~/.bashrc
conda activate EEG_Vis_CL
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/p/ppowell/miniconda3/envs/EEG_Vis_CL/lib/
echo $LD_LIBRARY_PATH
echo "*** set workdir ***"
/home/student/p/ppowell/miniconda3/envs/EEG_Vis_CL/bin/python create_nc_csv.py "$@"
