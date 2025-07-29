#!/bin/bash
#FLUX: --job-name=noLB-AMBER
#FLUX: -N=4
#FLUX: --queue=main
#FLUX: -t=1800
#FLUX: --urgency=16

ml PDC
ml GROMACS/2020.5-cpeCray-21.11
ml Anaconda3/2021.05
path_string_method_gmxapi=../../../../string-method-gmxapi/
iteration=$(ls -vd strings/string[0-9]*.txt|tail -n 1| sed  "s:strings/string\([0-9]*\).txt:\1:")
iterations_per_job=1
max_iteration=$((($iteration+$iterations_per_job)))
sed -i "s/\"max_iterations\": [0-9]*/\"max_iterations\": $max_iteration/" config.json
cmd="`which python`  ${path_string_method_gmxapi}/stringmethod/main.py --config_file=config.json"
echo "Command Run:"
echo $cmd
echo "Started at:"
date
$cmd
echo "Finished at:"
date
