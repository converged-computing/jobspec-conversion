#!/bin/bash
#FLUX: --job-name=reg_offsets
#FLUX: --queue=biochem,normal
#FLUX: -t=3600
#FLUX: --priority=16

module load python/3.6.1
source $py3env/bin/activate
module load matlab/R2017b
MATLABPATH="$IMAGING_DIR/CPlibs:/$IMAGING_DIR/CPscripts"
export MATLABPATH
FID_image_dir="<path to images>/09_imageTilesBothColors_green"
FID_tile_dir="<path to split_tile fid>/FID"
out_dir="<output path where log files and registration offsets will go>"
python $SCRIPT_DIR/getRegistrationOffsets.py -id $FID_image_dir -sd $FID_tile_dir -gv $IMAGING_DIR -f FID -od $out_dir 1> $out_dir/logfile.txt 2> $out_dir/errfile.txt
