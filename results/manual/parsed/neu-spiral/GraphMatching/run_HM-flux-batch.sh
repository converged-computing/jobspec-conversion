#!/bin/bash
#FLUX: --job-name=HM
#FLUX: --exclusive
#FLUX: --urgency=16

module load spark/2.3.2-hadoop2.7
module load python/2.7.15
source /scratch/armin_m/spark/conf/spark-env.sh
ulimit -u 10000
G1=$1
G2=$2
N=1000
lambda_lin=0.0
PSolver=ParallelSolver2norm
LSolver=LocalLSSolver
p=2
spark-submit --master local[40]  --py-files "preprocessor.py"  --executor-memory 100g --conf "spark.driver.maxResultSize=10G" --conf "spark.network.timeout=1000s" --driver-memory 100g   heatMap.py  data/RDDs/$3   data/$G1/graph data/$G2/graph  --N 30 --outfile HMArrays/$3
