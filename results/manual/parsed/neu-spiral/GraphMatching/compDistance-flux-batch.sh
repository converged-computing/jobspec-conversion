#!/bin/bash
#FLUX: --job-name=distance
#FLUX: --priority=16

module load spark/2.3.2-hadoop2.7
module load python/2.7.15
source /scratch/armin_m/spark/conf/spark-env.sh
ulimit -u 10000
spark-submit --master local[40]   --py-files "helpers.py"  --executor-memory 100g --driver-memory 100g   Distance.py   $1  $2   $3   --connection_graph $4 --equalize --N $5 
