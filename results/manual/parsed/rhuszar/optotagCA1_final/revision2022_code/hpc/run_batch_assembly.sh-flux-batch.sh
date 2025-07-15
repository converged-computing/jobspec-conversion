#!/bin/bash
#FLUX: --job-name=expensive-avocado-7267
#FLUX: --queue=cpu_short,cpu_medium,cpu_long,fn_short,fn_medium,fn_long,gpu4_short,gpu4_medium,gpu4_long,cpu_dev,gpu4_dev
#FLUX: -t=14340
#FLUX: --urgency=16

file=$1
module load matlab
matlab -singleCompThread -nodisplay  -nodesktop  -nojvm -r "runAssembly_trackVrev_condTrack('$file'); exit;"
