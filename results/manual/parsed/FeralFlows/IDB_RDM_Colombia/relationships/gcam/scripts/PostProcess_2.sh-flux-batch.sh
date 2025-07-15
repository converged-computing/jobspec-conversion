#!/bin/bash
#FLUX: --job-name=quirky-pot-7597
#FLUX: --urgency=16

export CXX='g++'
export BOOST_INCLUDE='/cluster/tufts/lamontagnelab/byarla01/libs/boost_1_67_0'
export BOOST_LIB='/cluster/tufts/lamontagnelab/byarla01/libs/boost_1_67_0/stage/lib'
export XERCES_INCLUDE='/cluster/tufts/lamontagnelab/byarla01/libs/xercesc/include'
export XERCES_LIB='/cluster/tufts/lamontagnelab/byarla01/libs/xercesc/lib '
export JARS_LIB='/cluster/tufts/lamontagnelab/byarla01/libs/jars/*'
export JAVA_INCLUDE='${JAVA_HOME}/include'
export JAVA_LIB='${JAVA_HOME}/jre/lib/amd64/server'
export EIGEN_INCLUDE='/cluster/tufts/lamontagnelab/byarla01/libs/eigen'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/shared/ansys_inc/v193/v195/tp/qt/5.9.6/linx64/lib/'

module purge
module load java/1.8.0_60
module load R/4.0.0
module load git
module load gcc/9.3.0
module load intel-oneapi-tbb/2021.1.1-gcc-9.3.0
export CXX=g++
export BOOST_INCLUDE=/cluster/tufts/lamontagnelab/byarla01/libs/boost_1_67_0
export BOOST_LIB=/cluster/tufts/lamontagnelab/byarla01/libs/boost_1_67_0/stage/lib
export XERCES_INCLUDE=/cluster/tufts/lamontagnelab/byarla01/libs/xercesc/include
export XERCES_LIB=/cluster/tufts/lamontagnelab/byarla01/libs/xercesc/lib 
export JARS_LIB=/cluster/tufts/lamontagnelab/byarla01/libs/jars/*
export JAVA_INCLUDE=${JAVA_HOME}/include
export JAVA_LIB=${JAVA_HOME}/jre/lib/amd64/server
export EIGEN_INCLUDE=/cluster/tufts/lamontagnelab/byarla01/libs/eigen
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/shared/ansys_inc/v193/v195/tp/qt/5.9.6/linx64/lib/
echo 'Running second post processing script in parallel for each query'
echo "Started at $(date)"
echo "nodes: $SLURM_JOB_NODELIST"
tid=$SLURM_ARRAY_TASK_ID
proj_function_arg=1
echo "My SLURM_ARRAY_TASK_ID: $tid"
f="create_query_proj_file.R"
PostProcFn=$1
fpath="$PostProcFn$f"
post_proc_outpath=$2
echo "Rscript --vanilla $fpath --args $tid $proj_function_arg $PostProcFn $post_proc_outpath"
Rscript --vanilla $fpath --args $tid $proj_function_arg $PostProcFn $post_proc_outpath
echo "Ended at $(date)"
