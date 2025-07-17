#!/bin/bash
#FLUX: --job-name=fat-lamp-4620
#FLUX: -c=6
#FLUX: --queue=wjg,biochem,sfgf
#FLUX: -t=3600
#FLUX: --urgency=16

export MATLABPATH='/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPscripts/:/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPlibs/'

source ~/.bashrc
conda activate py36
module load matlab
export MATLABPATH=/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPscripts/:/home/groups/wjg/kyx/array_analysis/scripts/array_tools/CPlibs/
python $GROUP_HOME/kyx/array_analysis/scripts/array_tools/array_data_processing/getRegistrationOffsets.py -id $GROUP_SCRATCH/kyx/NNNlib2b_Nov11/data/fiducial_images_20220314/ -sd /scratch/groups/wjg/kyx/NNNlib2b_Nov11/data/filtered_tiles/ -gv /oak/stanford/groups/wjg/kyx/software -f FID -od $GROUP_SCRATCH/kyx/NNNlib2b_Nov11/data/registration -op registration_offset_20220314
