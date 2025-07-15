#!/bin/bash
#FLUX: --job-name=chunky-spoon-2850
#FLUX: -N=4
#FLUX: -c=14
#FLUX: --exclusive
#FLUX: --queue=broadwell
#FLUX: -t=3600
#FLUX: --urgency=16

export SCOREP_PROFILING_FORMAT='cube_tuple'

echo "run RDD begin."
cd ..
module purge
source ./readex_env/set_env_rdd.source
RDD_t=0.1 #100 ms
RDD_p=main_phase
RDD_c=10
RDD_v=10
RDD_w=10
export SCOREP_PROFILING_FORMAT=cube_tuple
rm -rf scorep-*
rm -f readex_config.xml
srun --cpu_bind=verbose,sockets --nodes 4 --ntasks-per-node 2 --cpus-per-task 14 ./test/amg2013_rdd -P 2 2 2 -r 40 40 40
readex-dyn-detect -t $RDD_t -p $RDD_p -c $RDD_c -v $RDD_v -w $RDD_w scorep-*/profile.cubex
echo "RDD result = $?"
echo "run RDD done."
