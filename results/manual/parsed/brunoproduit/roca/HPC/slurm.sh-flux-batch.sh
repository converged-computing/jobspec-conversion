#!/bin/bash
#FLUX: --job-name=gloopy-lemur-8265
#FLUX: --urgency=16

module load python-2.7.13
module load sage-6.1.1 
cores=4
OUTPUT=($(sage split_iteration.py $1 -j $cores))
for i in "${OUTPUT[@]}";
do 
  start=`echo $i | cut -d";" -f1`;
  stop=`echo $i | cut -d";" -f2`;
  sage optimization_hpc.py $1 $start $stop;
done
