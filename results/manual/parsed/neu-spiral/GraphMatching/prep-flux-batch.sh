#!/bin/bash
#FLUX: --job-name=preP
#FLUX: --urgency=16

module load spark/2.3.2-hadoop2.7
module load python/2.7.15
source /scratch/armin_m/spark/conf/spark-env.sh
ulimit -u 10000
masterIP=local[56]
if [  "$7" = "exog" ]; then
    spark-submit --master $masterIP   --py-files "helpers.py,LocalSolvers.py,Characteristics.py"  --executor-memory 100g --conf "spark.driver.maxResultSize=10G" --conf "spark.network.timeout=1000s" --driver-memory 100g   preprocessor.py  $1  $2  --outputconstraintfile $3 --N $4   --outputobjectivefile  $5 --fromsnap --undirected --k $6 --constraintmethod $7 --degreedistance $6 --equalize --colors1 $8 --colors2 $9
else
    spark-submit --master $masterIP   --py-files "helpers.py,LocalSolvers.py,Characteristics.py"  --executor-memory 100g --conf "spark.driver.maxResultSize=10G" --conf "spark.network.timeout=1000s" --driver-memory 100g   preprocessor.py  $1  $2  --outputconstraintfile $3 --N $4   --outputobjectivefile  $5 --fromsnap --undirected --k $6 --constraintmethod $7 --degreedistance $6 --equalize
fi 
