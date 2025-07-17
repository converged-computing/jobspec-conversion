#!/bin/bash
#FLUX: --job-name=amg2013_rdd
#FLUX: -c=24
#FLUX: --exclusive
#FLUX: --queue=haswell
#FLUX: -t=3600
#FLUX: --urgency=16

export SCOREP_PROFILING_FORMAT='cube_tuple'
export SCOREP_METRIC_PAPI='PAPI_TOT_INS,PAPI_L3_TCM'
export SCOREP_FILTERING_FILE='scorep.filt'

module purge
source ./readex_env/set_env_rdd.source
INPUT_FILE=in3.data #in.lj.miniMD
RDD_t=0.001
RDD_p=INTEGRATE_RUN_LOOP
RDD_c=10
RDD_v=10
RDD_w=10
export SCOREP_PROFILING_FORMAT=cube_tuple
export SCOREP_METRIC_PAPI=PAPI_TOT_INS,PAPI_L3_TCM
export SCOREP_FILTERING_FILE=scorep.filt
rm -rf scorep-*
rm readex_config.xml
srun ./miniMD_openmpi_rdd -i $INPUT_FILE
readex-dyn-detect -t $RDD_t -p $RDD_p -c $RDD_c -v $RDD_v -w $RDD_w scorep-*/profile.cubex
echo "RDD result = $?"
echo "run RDD done."
