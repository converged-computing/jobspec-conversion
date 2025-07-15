#!/bin/bash
#FLUX: --job-name=spark-yarn-hdfs-setup
#FLUX: -N=8
#FLUX: --exclusive
#FLUX: -t=10800
#FLUX: --priority=16

export MAGPIE_SUBMISSION_TYPE='sbatchsrun'
export MAGPIE_SCRIPTS_HOME='${HOME}/hadoop/magpie-master'
export MAGPIE_LOCAL_DIR='$SLURM_TMPDIR'
export MAGPIE_JOB_TYPE='interactive'
export MAGPIE_STARTUP_TIME='10'
export MAGPIE_SHUTDOWN_TIME='10'
export MAGPIE_PRE_JOB_RUN='${MAGPIE_SCRIPTS_HOME}/scripts/pre-job-run-scripts/python_start.sh'
export JAVA_HOME='/usr/lib/jvm/jre-1.8.0/'
export MAGPIE_PYTHON='/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/python/3.7.0/bin/python'
export HADOOP_SETUP='yes'
export HADOOP_SETUP_TYPE='MR'
export HADOOP_VERSION='2.7.7'
export HADOOP_HOME='${HOME}/hadoop/hadoop-${HADOOP_VERSION}'
export HADOOP_LOCAL_DIR='$SLURM_TMPDIR/hadoop'
export HADOOP_ENVIRONMENT_EXTRA_PATH='${HOME}/hadoop/python_start'
export HADOOP_JOB='terasort'
export HADOOP_FILESYSTEM_MODE='hdfsoverlustre'
export HADOOP_HDFS_PATH='/ssd/${USER}/hdfs'
export HADOOP_HDFSOVERLUSTRE_PATH='/home/${USER}/scratch/laagi/hdfsoverlustre/'
export HADOOP_HDFSOVERNETWORKFS_PATH='/networkfs/${USER}/hdfsovernetworkfs/'
export HADOOP_RAWNETWORKFS_PATH='/lustre/${USER}/rawnetworkfs/'
export SPARK_SETUP='yes'
export SPARK_SETUP_TYPE='YARN'
export SPARK_VERSION='2.4.0-bin-hadoop2.7'
export SPARK_HOME='${HOME}/hadoop/spark-${SPARK_VERSION}'
export SPARK_LOCAL_DIR='$SLURM_TMPDIR/spark'
export SPARK_DAEMON_HEAP_MAX='2000'
export SPARK_ENVIRONMENT_EXTRA_PATH='${HOME}/hadoop/python_start'
export SPARK_JOB='sparkpi'

export MAGPIE_SUBMISSION_TYPE="sbatchsrun"
module load python/3.7.0
module load scipy-stack/2018b
export MAGPIE_SCRIPTS_HOME="${HOME}/hadoop/magpie-master"
export MAGPIE_LOCAL_DIR="$SLURM_TMPDIR"
export MAGPIE_JOB_TYPE="interactive"
export MAGPIE_STARTUP_TIME=10
export MAGPIE_SHUTDOWN_TIME=10
export MAGPIE_PRE_JOB_RUN="${MAGPIE_SCRIPTS_HOME}/scripts/pre-job-run-scripts/python_start.sh"
export JAVA_HOME="/usr/lib/jvm/jre-1.8.0/"
export MAGPIE_PYTHON="/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/python/3.7.0/bin/python"
export HADOOP_SETUP=yes
export HADOOP_SETUP_TYPE="MR"
export HADOOP_VERSION="2.7.7"
export HADOOP_HOME="${HOME}/hadoop/hadoop-${HADOOP_VERSION}"
export HADOOP_LOCAL_DIR="$SLURM_TMPDIR/hadoop"
export HADOOP_ENVIRONMENT_EXTRA_PATH="${HOME}/hadoop/python_start"
export HADOOP_JOB="terasort"
export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"
export HADOOP_HDFS_PATH="/ssd/${USER}/hdfs"
export HADOOP_HDFSOVERLUSTRE_PATH="/home/${USER}/scratch/laagi/hdfsoverlustre/"
export HADOOP_HDFSOVERNETWORKFS_PATH="/networkfs/${USER}/hdfsovernetworkfs/"
export HADOOP_RAWNETWORKFS_PATH="/lustre/${USER}/rawnetworkfs/"
export SPARK_SETUP=yes
export SPARK_SETUP_TYPE="YARN"
export SPARK_VERSION="2.4.0-bin-hadoop2.7"
export SPARK_HOME="${HOME}/hadoop/spark-${SPARK_VERSION}"
export SPARK_LOCAL_DIR="$SLURM_TMPDIR/spark"
export SPARK_DAEMON_HEAP_MAX=2000
export SPARK_ENVIRONMENT_EXTRA_PATH="${HOME}/hadoop/python_start"
export SPARK_JOB="sparkpi"
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-check-inputs
if [ $? -ne 0 ]
then
    exit 1
fi
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-setup-core
if [ $? -ne 0 ]
then
    exit 1
fi
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-setup-projects
if [ $? -ne 0 ]
then
    exit 1
fi
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-setup-post
if [ $? -ne 0 ]
then
    exit 1
fi
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-pre-run
if [ $? -ne 0 ]
then
    exit 1
fi
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-run
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-cleanup
srun --no-kill -W 0 $MAGPIE_SCRIPTS_HOME/magpie-post-run
