#!/bin/bash
#FLUX: --job-name=hadoop-cluster
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=general
#FLUX: -t=85800
#FLUX: --urgency=16

export MAGPIE_SUBMISSION_TYPE='sbatchsrun'
export MAGPIE_SCRIPTS_HOME='${HOME}/Workspace/magpie'
export MAGPIE_LOCAL_DIR='/scratch/${USER}/magpie'
export MAGPIE_JOB_TYPE='hadoop'
export SAR_SETUP='yes'
export SAR_CMD_OPTS='-A'
export SAR_RECORD_INTERVAL='5'
export SAR_LOCAL_DIR='/scratch/${USER}/sar'
export SAR_SHARED_DIR='${HOME}/sar'
export JAVA_HOME='/opt/jdk1.8.0_60/'
export HADOOP_SETUP='yes'
export HADOOP_SETUP_TYPE='MR2'
export HADOOP_VERSION='2.7.2'
export HADOOP_HOME='${HOME}/hadoop-${HADOOP_VERSION}'
export HADOOP_LOCAL_DIR='/scratch/${USER}/hadoop'
export HADOOP_MODE='terasort'
export HADOOP_FILESYSTEM_MODE='hdfs'
export HADOOP_HDFS_PATH='/scratch/${USER}/hdfs'
export HADOOP_HDFS_PATH_CLEAR='yes'
export HADOOP_HDFSOVERLUSTRE_PATH='/lustre/${USER}/hdfsoverlustre/'
export HADOOP_HDFSOVERNETWORKFS_PATH='/networkfs/${USER}/hdfsovernetworkfs/'
export HADOOP_RAWNETWORKFS_PATH='/lustre/${USER}/rawnetworkfs/'
export HADOOP_LOCALSTORE='/scratch/${USER}/localstore/'
export HADOOP_LOCALSTORE_CLEAR='yes'

export MAGPIE_SUBMISSION_TYPE="sbatchsrun"
export MAGPIE_SCRIPTS_HOME="${HOME}/Workspace/magpie"
export MAGPIE_LOCAL_DIR="/scratch/${USER}/magpie"
export MAGPIE_JOB_TYPE="hadoop"
export SAR_SETUP=yes
export SAR_CMD_OPTS="-A"
export SAR_RECORD_INTERVAL=5
export SAR_LOCAL_DIR="/scratch/${USER}/sar"
export SAR_SHARED_DIR="${HOME}/sar"
export JAVA_HOME="/opt/jdk1.8.0_60/"
export HADOOP_SETUP=yes
export HADOOP_SETUP_TYPE="MR2"
export HADOOP_VERSION="2.7.2"
export HADOOP_HOME="${HOME}/hadoop-${HADOOP_VERSION}"
export HADOOP_LOCAL_DIR="/scratch/${USER}/hadoop"
export HADOOP_MODE="terasort"
export HADOOP_FILESYSTEM_MODE="hdfs"
export HADOOP_HDFS_PATH="/scratch/${USER}/hdfs"
export HADOOP_HDFS_PATH_CLEAR="yes"
export HADOOP_HDFSOVERLUSTRE_PATH="/lustre/${USER}/hdfsoverlustre/"
export HADOOP_HDFSOVERNETWORKFS_PATH="/networkfs/${USER}/hdfsovernetworkfs/"
export HADOOP_RAWNETWORKFS_PATH="/lustre/${USER}/rawnetworkfs/"
export HADOOP_LOCALSTORE="/scratch/${USER}/localstore/"
export HADOOP_LOCALSTORE_CLEAR="yes"
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
