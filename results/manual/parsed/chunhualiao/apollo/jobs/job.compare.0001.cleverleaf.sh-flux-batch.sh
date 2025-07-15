#!/bin/bash
#FLUX: --job-name="APOLLO:COMPARE.1.cleverleaf.test"
#FLUX: --exclusive
#FLUX: --priority=16

export EXPERIMENT_JOB_TITLE='COMPARE.0001.cleverleaf"  # <-- creates output path!'
export APPLICATION_RANKS='1"         # ^__ make sure to change SBATCH node counts!'
export SOS_AGGREGATOR_COUNT='1"      # <-- actual aggregator count'
export EXPERIMENT_NODE_COUNT='2"     # <-- is SBATCH -N count, incl/extra agg. node'
export EXPERIMENT_BASE='/p/lustre2/${USER}/experiments/apollo'
export SOS_WORK='${EXPERIMENT_BASE}/${EXPERIMENT_JOB_TITLE}.${SLURM_JOB_ID}'
export SOS_EVPATH_MEETUP='${SOS_WORK}/daemons'
export RETURN_PATH='`pwd`'
export CLEVERLEAF_APOLLO_BINARY=' ${SOS_WORK}/bin/cleverleaf-apollo-release '
export CLEVERLEAF_NORMAL_BINARY=' ${SOS_WORK}/bin/cleverleaf-normal-release '
export CLEVERLEAF_TRACED_BINARY=' ${SOS_WORK}/bin/cleverleaf-traced-release '
export CLEVERLEAF_INPUT='${SOS_WORK}/cleaf_triple_pt_25.in'
export SRUN_CLEVERLEAF=' '
export SRUN_CLEVERLEAF+=' -r 1 '
export KMP_WARNINGS='0'
export KMP_AFFINITY='${KMP_AFFINITY},24,25,26,27,28,29,30,31,32,33,34,35]'
export OPENMP_TRACE_OUTPUT_FILE='${SOS_WORK}/output/traced.32.static.csv'
export OMP_NUM_THREADS='32'
export OMP_SCHEDULE='static'
export OPENMP_TRACE_AS_POLICY='6'

export EXPERIMENT_JOB_TITLE="COMPARE.0001.cleverleaf"  # <-- creates output path!
export APPLICATION_RANKS="1"         # ^__ make sure to change SBATCH node counts!
export SOS_AGGREGATOR_COUNT="1"      # <-- actual aggregator count
export EXPERIMENT_NODE_COUNT="2"     # <-- is SBATCH -N count, incl/extra agg. node
export  EXPERIMENT_BASE="/p/lustre2/${USER}/experiments/apollo"
export  SOS_WORK=${EXPERIMENT_BASE}/${EXPERIMENT_JOB_TITLE}.${SLURM_JOB_ID}
export  SOS_EVPATH_MEETUP=${SOS_WORK}/daemons
echo ""
echo "  JOB TITLE.....: ${EXPERIMENT_JOB_TITLE}"
echo "  WORKING PATH..: ${SOS_WORK}"
echo ""
export RETURN_PATH=`pwd`
source ${RETURN_PATH}/common_unsetenv.sh
source ${RETURN_PATH}/common_setenv.sh
source ${RETURN_PATH}/common_copy_files.sh
source ${RETURN_PATH}/common_launch_sos.sh
source ${RETURN_PATH}/common_srun_cmds.sh
cp ${HOME}/src/apollo/jobs/cleaf*.in   ${SOS_WORK}
cd ${SOS_WORK}
echo ""
echo ">>>> Launching experiment codes..."
echo ""
export CLEVERLEAF_APOLLO_BINARY=" ${SOS_WORK}/bin/cleverleaf-apollo-release "
export CLEVERLEAF_NORMAL_BINARY=" ${SOS_WORK}/bin/cleverleaf-normal-release "
export CLEVERLEAF_TRACED_BINARY=" ${SOS_WORK}/bin/cleverleaf-traced-release "
export CLEVERLEAF_INPUT="${SOS_WORK}/cleaf_triple_pt_25.in"
export SRUN_CLEVERLEAF=" "
export SRUN_CLEVERLEAF+=" --cpu-bind=none "
export SRUN_CLEVERLEAF+=" -c 36 "
export SRUN_CLEVERLEAF+=" -o ${SOS_WORK}/output/cleverleaf.%4t.stdout "
export SRUN_CLEVERLEAF+=" -N ${WORK_NODE_COUNT} "
export SRUN_CLEVERLEAF+=" -n ${APPLICATION_RANKS} "
export SRUN_CLEVERLEAF+=" -r 1 "
echo ">>>> Comparing cleverleaf-normal and cleverleaf-apollo..."
echo ""
echo "========== EXPERIMENTS STARTING =========="
echo ""
function wipe_all_sos_data_from_database() {
    SOS_SQL=${SQL_DELETE_VALS} srun ${SRUN_SQL_EXEC}
    SOS_SQL=${SQL_DELETE_DATA} srun ${SRUN_SQL_EXEC}
    SOS_SQL=${SQL_DELETE_PUBS} srun ${SRUN_SQL_EXEC}
    SOS_SQL="VACUUM;" srun ${SRUN_SQL_EXEC}
}
function run_cleverleaf_with_model() {
    export APOLLO_INIT_MODEL="${SOS_WORK}/$3"
    #wipe_all_sos_data_from_database
    cd output
    printf "\t%4s, %-20s, %-30s, " ${APPLICATION_RANKS} \
        $(basename -- ${CLEVERLEAF_INPUT}) $(basename -- ${APOLLO_INIT_MODEL})
    /usr/bin/time -f %e -- srun ${SRUN_CLEVERLEAF} $1 $2
    cd ${SOS_WORK}
}
export KMP_WARNINGS="0"
export KMP_AFFINITY="noverbose,nowarnings,norespect,granularity=fine,explicit"
export KMP_AFFINITY="${KMP_AFFINITY},proclist=[0,1,2,3,4,5,6,7,8,9,10,11"
export KMP_AFFINITY="${KMP_AFFINITY},12,13,14,15,16,17,18,19,20,21,22,23"
export KMP_AFFINITY="${KMP_AFFINITY},24,25,26,27,28,29,30,31,32,33,34,35]"
set +m
export OPENMP_TRACE_OUTPUT_FILE="${SOS_WORK}"
run_cleverleaf_with_model ${CLEVERLEAF_NORMAL_BINARY} ${CLEVERLEAF_INPUT} "normal---------default"
run_cleverleaf_with_model ${CLEVERLEAF_TRACED_BINARY} ${CLEVERLEAF_INPUT} "traced---------default"
run_cleverleaf_with_model ${CLEVERLEAF_APOLLO_BINARY} ${CLEVERLEAF_INPUT} "model.static.0.default"
export OMP_NUM_THREADS=32
export OMP_SCHEDULE="static"
export OPENMP_TRACE_OUTPUT_FILE="${SOS_WORK}/output/traced.32.static.csv"
export OPENMP_TRACE_AS_POLICY=6
run_cleverleaf_with_model ${CLEVERLEAF_NORMAL_BINARY} ${CLEVERLEAF_INPUT} "normal.${OMP_NUM_THREADS}.${OMP_SCHEDULE}"
run_cleverleaf_with_model ${CLEVERLEAF_TRACED_BINARY} ${CLEVERLEAF_INPUT} "traced.${OMP_NUM_THREADS}.${OMP_SCHEDULE}"
cd ${SOS_WORK}
echo ""
echo "========== EXPERIMENTS COMPLETE =========="
echo ""
source ${RETURN_PATH}/common_parting.sh
set -m
echo " >>>>"
echo " >>>>"
echo " >>>> Press ENTER or wait 120 seconds to shut down SOS.   (C-c to stay interactive)"
echo " >>>>"
read -t 120 -p " >>>> "
echo ""
echo " *OK* Shutting down interactive experiment environment..."
echo ""
${SOS_WORK}/sosd_stop.sh
sleep 8
echo ""
echo ""
echo "--- Done! End of job script. ---"
