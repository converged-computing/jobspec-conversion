#!/bin/bash
#FLUX: --job-name=fugly-knife-4754
#FLUX: -c=4
#FLUX: --queue=red,brown
#FLUX: -t=7200
#FLUX: --urgency=16

echo "prune_percent=$1"
echo "metric=$2"
echo "model_name=$3"
echo "path=$4"
echo "prunetask=$5"
echo "group_metrics=$6"
echo "prune_method=$7"
python main.py $1 $2 $3 $4 $5 $6 $7
