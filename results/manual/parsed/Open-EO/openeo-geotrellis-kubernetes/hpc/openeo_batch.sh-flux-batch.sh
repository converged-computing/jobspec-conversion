#!/bin/bash
#FLUX: --job-name=eccentric-pot-0019
#FLUX: -N=2
#FLUX: -n=3
#FLUX: -t=600
#FLUX: --urgency=16

export WORK_DIR='/project/cscale_test/Public/openeo/'
export MKL_NUM_THREADS='1'
export SPARK_IDENT_STRING='$SLURM_JOBID'
export SPARK_WORKER_DIR='$TMPDIR'
export SLURM_SPARK_MEM='$(printf "%.0f" $((${SLURM_MEM_PER_NODE} * 95/100)))'
export SPARK_HOME='/opt/spark3.2.0'
export SPARK_LOG_DIR='${WORK_DIR}'
export SPARK_CONF_DIR='/project/cscale_test/Public/openeo/openeo-geotrellis-kubernetes/hpc/conf'
export OPENEO_S1BACKSCATTER_ELEV_GEOID='/opt/openeo-vito-aux-data/egm96.grd'
export OTB_HOME='/usr'
export OTB_APPLICATION_PATH='/usr/lib/otb/applications'
export GDAL_NUM_THREADS='2'
export GDAL_CACHEMAX='200'
export GDAL_DISABLE_READDIR_ON_OPEN='EMPTY_DIR'
export GDAL_HTTP_MERGE_CONSECUTIVE_RANGES='YES'
export VSI_CACHE='TRUE'
export TRAVIS='1'
export PYTHONPATH='/opt/venv/lib64/python3.8/site-packages'
export OPENEO_CATALOG_FILES='${WORK_DIR}layercatalog.json'

printenv | grep SLURM
export WORK_DIR=/project/cscale_test/Public/openeo/
export MKL_NUM_THREADS=1
export SPARK_IDENT_STRING=$SLURM_JOBID
export SPARK_WORKER_DIR=$TMPDIR
export SLURM_SPARK_MEM=$(printf "%.0f" $((${SLURM_MEM_PER_NODE} * 95/100)))
export SPARK_HOME=/opt/spark3.2.0
export SPARK_LOG_DIR=${WORK_DIR}
export SPARK_CONF_DIR=/project/cscale_test/Public/openeo/openeo-geotrellis-kubernetes/hpc/conf
BIND='--bind /project/cscale_test'
IMAGE='/project/cscale_test/Public/openeo/openeo-yarn_latest.sif'
singularity exec $BIND $IMAGE /opt/spark3.2.0/sbin/start-master.sh
sleep 5
MASTER_URL=$(grep -Po '(?=spark://).*' $SPARK_LOG_DIR/spark-${SPARK_IDENT_STRING}-org.apache.spark.deploy.master*.out)
NWORKERS=$((SLURM_NTASKS - 2))
SPARK_NO_DAEMONIZE=1 srun -n ${NWORKERS} -N ${NWORKERS} --label --output=$SPARK_LOG_DIR/spark-%j-workers.out singularity exec $BIND $IMAGE /opt/spark3.2.0/sbin/start-worker.sh -m ${SLURM_SPARK_MEM}M -c ${SLURM_CPUS_PER_TASK} -d ${SPARK_WORKER_DIR} ${MASTER_URL} &
slaves_pid=$!
export OPENEO_S1BACKSCATTER_ELEV_GEOID=/opt/openeo-vito-aux-data/egm96.grd
export OTB_HOME=/usr
export OTB_APPLICATION_PATH=/usr/lib/otb/applications
export GDAL_NUM_THREADS=2
export GDAL_CACHEMAX=200
export GDAL_DISABLE_READDIR_ON_OPEN=EMPTY_DIR
export GDAL_HTTP_MERGE_CONSECUTIVE_RANGES=YES
export VSI_CACHE=TRUE
export TRAVIS=1
export PYTHONPATH=/opt/venv/lib64/python3.8/site-packages
export OPENEO_CATALOG_FILES=${WORK_DIR}layercatalog.json
srun -n 1 -N 1 singularity exec $BIND $IMAGE /opt/spark3.2.0/bin/spark-submit --master ${MASTER_URL} --executor-memory ${SLURM_SPARK_MEM}M --jars /opt/geotrellis-extensions-static.jar,/opt/geotrellis-backend-assembly-static.jar,/opt/openeo-logging-static.jar  /opt/venv/lib64/python3.8/site-packages/openeogeotrellis/deploy/batch_job.py ${WORK_DIR}job_specification.json ${WORK_DIR} out_file log job_metadata.json "1.0.0" "[]" spark false
kill $slaves_pid
singularity exec $IMAGE /opt/spark3.2.0/sbin/stop-master.sh
