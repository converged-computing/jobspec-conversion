#!/bin/bash
#FLUX: --job-name=__job_name__
#FLUX: --urgency=16

SCRIPTS_DIR="__scripts_dir__"
WORK_DIR="__working_dir__"
RESULTS_DIR="__results_dir__"
HARNESS_ID="__harness_id__"
BUILD_DIR="__build_dir__"
echo "Printing test directory environment variables:"
env | fgrep RGT_APP_SOURCE_
env | fgrep RGT_TEST_
echo
cd $SCRIPTS_DIR
source ${BUILD_DIR}/Common_Scripts/setup_env.sh
module -t list
if [ ! -e $WORK_DIR ]
then
    mkdir -p $WORK_DIR
fi
cd $WORK_DIR
env &> job.environ
scontrol show hostnames > job.nodes
LAMMPS_EXE=${BUILD_DIR}/lammps/bin/lmp_${RGT_GPU_ARCH}
ldd ${LAMMPS_EXE} &> ldd.log
if [ -d ${SCRIPTS_DIR}/input_files ]; then
    cp ${SCRIPTS_DIR}/input_files/* ./
else
    echo "No directory of input files found: ${SCRIPTS_DIR}/input_files"
    exit 1
fi
input_file=`ls ./in.*`
if [ ! -z $LAMMPS_BENCHMARK ] && [ "${LAMMPS_BENCHMARK}" == "REAX" ]; then
    # Then we're in the Reax example and need to change things in the input file
    echo 'processors * * * grid twolevel 8 2 2 2' > ${input_file}.kokkos
    sed 's#reax/c dual#reax/c#g' ${input_file} >> ${input_file}.kokkos
else
    cp ${input_file} ${input_file}.kokkos
fi
log_binary_execution_time.py --scriptsdir $SCRIPTS_DIR --uniqueid $HARNESS_ID --mode start
node_inc=`python -c "print(int(${SLURM_NNODES} / 4))"`
if [ ${SLURM_NNODES} -le 4 ]; then node_inc=1; fi
run_local(){
    nodect=$1
    NRANKS=`expr ${RGT_TASKS_PER_NODE} \* ${nodect}`
    # Original system is __atoms_per_system__ atoms
    if [ -z $LAMMPS_ATOMS_PER_TASK ]; then
        # test-specific. For Reax, there's 300 per system. For TIP3P, theres 45000
        # So these tests will have different values of default_systems_per_task
        REP_SYSTEMS_PER_TASK=__default_systems_per_task__
    else
        # calculate REP_SYSTEMS_PER_TASK, rounds down
        REP_SYSTEMS_PER_TASK=`python -c "print(int(${LAMMPS_ATOMS_PER_TASK} / __atoms_per_system__)"`
    fi
    total_size=`expr ${NRANKS} \* ${REP_SYSTEMS_PER_TASK}`
    v_multipliers=`${BUILD_DIR}/Common_Scripts/find_n_close_factors.py 3 ${total_size}`
    x_size="-v x `echo ${v_multipliers} | cut -d' ' -f1`"
    y_size="-v y `echo ${v_multipliers} | cut -d' ' -f2`"
    z_size="-v z `echo ${v_multipliers} | cut -d' ' -f3`"
    if [ "__check_memory__" == "1" ]; then
        echo '#!/bin/bash' > check_mem.sh
        echo 'for i in $(seq 0 7); do' >> check_mem.sh
        echo '    echo "MEMCHECK $(hostname).${i}: $(cat /sys/class/drm/card${i}/device/mem_info_vram_used)"' >> check_mem.sh
        echo 'done' >> check_mem.sh
        chmod u+x check_mem.sh
        echo "MEMCHECK pre-check on ${nodect} nodes"
        srun -N ${nodect} -n ${nodect} ./check_mem.sh
        sleep 10s
        echo "MEMCHECK pre-check on ${nodect} nodes + 10s"
        srun -N ${nodect} -n ${nodect} ./check_mem.sh
    fi
    set -x
    srun -N ${nodect} -m *,nopack -n ${NRANKS} \
        --gpus-per-node=${RGT_TASKS_PER_NODE} --gpu-bind=closest --cpu-bind=map_cpu:57,33,25,1,9,17,41,49 \
        ${LAMMPS_EXE} -k on g 1 \
        -sf kk -pk kokkos gpu/aware on ${LMP_PKG_KOKKOS_CMD} \
        -in ${input_file}.kokkos -log log.`echo ${input_file} | sed -e "s|./in.||"`.n${nodect} \
        ${x_size} ${y_size} ${z_size} ${steps_cmd} \
        2>&1 >> stdout.txt
    if [ ! "$?" == "0" ]; then set +x; return 1; fi
    set +x
}
ct_failed=0
run_local 1
if [ ! "$?" == "0" ]; then ct_failed=`$ct_failed + 1`; fi
for ind in 1 2 3 4; do
    nct=`expr ${ind} \* ${node_inc}`
    if [ ${nct} -le ${SLURM_NNODES} ]; then
        run_local ${nct}
        if [ ! "$?" == "0" ]; then ct_failed=`expr $ct_failed + 1`; fi
    fi
done
final_ct=`expr 4 \* ${node_inc}`
if [ $final_ct -lt ${SLURM_NNODES} ]; then
    run_local ${SLURM_NNODES}
    if [ ! "$?" == "0" ]; then ct_failed=`expr $ct_failed + 1`; fi
fi
log_binary_execution_time.py --scriptsdir $SCRIPTS_DIR --uniqueid $HARNESS_ID --mode final
cd $SCRIPTS_DIR
cp -rf $WORK_DIR/* $RESULTS_DIR
check_executable_driver.py -p $RESULTS_DIR -i $HARNESS_ID
case __resubmit__ in
    0)
       echo "No resubmit";;
    1)
       test_harness_driver.py -r;;
esac
exit ${ct_failed}
