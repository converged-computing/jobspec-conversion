#!/bin/bash
#FLUX: --job-name=carnivorous-banana-6201
#FLUX: -N=3
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module load spark/2.1.1
start-all.sh
shifter spark-submit --conf spark.eventLog.enabled=true --conf spark.eventLog.dir=$SCRATCH/spark/  --conf spark.driver.maxResultSize=120g --driver-memory 120G --executor-memory 120G /global/homes/q/qpzhang/Github/jgi-ViCA/scripts/spark_prediction.py /global/projectb/scratch/qpzhang/TARA/Libsvm/all_2k.libsvm /global/projectb/scratch/qpzhang/Run_Genelearn/Full_nextflow/virus_non_euk_non_virus_training.svmlib.spark_model/  /global/projectb/scratch/qpzhang/Run_Genelearn/Full_nextflow/virus_non_euk_non_virus_training.svmlib.spark_scaler/ /global/projectb/scratch/qpzhang/TARA/Libsvm/all_2k.libsvm.prediction_non_euk_non_virus_and_virus
stop-all.sh
