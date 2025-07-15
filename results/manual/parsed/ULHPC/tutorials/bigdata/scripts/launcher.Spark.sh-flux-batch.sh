#!/bin/bash
#FLUX: --job-name=dirty-banana-5274
#FLUX: --exclusive
#FLUX: --queue=batch
#FLUX: -t=3600
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='${SLURM_CPUS_PER_TASK}'
export SPARK_HOME='$EBROOTSPARK'
export SPARK_IDENT_STRING='${SLURM_JOBID}'
export SPARK_LOG_DIR='${SPARK_LOG_DIR:-$HOME/.spark/logs}'
export SPARK_WORKER_DIR='${SPARK_WORKER_DIR:-$HOME/.spark/worker}'
export SPARK_LOCAL_DIRS='${SPARK_LOCAL_DIRS:-/tmp/spark}'
export SPARK_WORKER_CORES='${SLURM_CPUS_PER_TASK:-1}'
export DAEMON_MEM='${SLURM_MEM_PER_CPU:=4096}'
export SPARK_MEM='$(( ${DAEMON_MEM}*(${SPARK_WORKER_CORES} -1) ))'
export SPARK_DAEMON_MEMORY='${DAEMON_MEM}m'
export SPARK_WORKER_MEMORY='${SPARK_MEM}m'
export SPARK_EXECUTOR_MEMORY='${SPARK_MEM}m'
export SPARK_MASTER_WEBUI_PORT='8082'
export SPARK_MASTER_HOST='$(hostname -s)'
export SPARK_MASTER_OPTS=''
export SPARK_WORKER_OPTS=''

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -n "${SLURM_SUBMIT_DIR}" ]; then
    [[ "${SCRIPTDIR}" == *"slurmd"* ]] && RUNDIR=${SLURM_SUBMIT_DIR} || RUNDIR=${SCRIPTDIR}
else
    RUNDIR=${SCRIPTDIR}
fi
SETUP_MASTER="y"
SETUP_SLAVE="y"
MODE_SUBMIT="y"
print_error_and_exit() { echo "***ERROR*** $*"; exit 1; }
usage(){
    cat <<EOF
NAME
  $0 -- Spark Standalone Mode launcher
  This launcher will setup a Spark cluster composed of 1 master and <N> workers,
  where <N> is the number of (full) nodes reserved (i.e. \$SLURM_NNODES).
  Then a spark application is submitted (using spark-submit) to the cluster
  By default, \$EBROOTSPARK/examples/src/main/python/pi.py is executed.
SYNOPSIS
  $0 -h
  $0 [-i] [path/to/spark_app]
OPTIONS
  -i --interactive
    Interactive mode: setup the cluster and give back the hand
    Only mean with interactive jobs
  -m --master
    Setup a spark master (only)
  -c --client
    Setup spark worker(s)/slave(s). This assumes a master is running
  -n --no-setup
    Do not bootstrap the spark cluster
AUTHOR
  UL HPC Team <hpc-sysadmins@uni.lu>
COPYRIGHT
  This is free software; see the source for copying conditions.  There is
  NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
EOF
}
if [ -f  /etc/profile ]; then
    .  /etc/profile
fi
while [ $# -ge 1 ]; do
    case $1 in
        -h | --help)  usage;   exit 0;;
        #-a | --all)         SETUP_MASTER="$1"; SETUP_SLAVE="$1"; MODE_SUBMIT="$1"; MODE_CLEAN="$1";;
        -i | --interactive) MODE_INTERACTIVE="$1";;
        -m | --master)      SETUP_MASTER="$1";  MODE_INTERACTIVE="$1";;
        -c | --client)      SETUP_SLAVE="$1";   MODE_INTERACTIVE="$1";;
        -s | --stop)        MODE_STOP="$1";;
        -n | --no-setup)    SETUP_MASTER=; SETUP_SLAVE=;;
        *) APP=$*; OPTS=;;
    esac
    shift
done
echo "SLURM_JOBID  = ${SLURM_JOBID}"
echo "SLURM_JOB_NODELIST = ${SLURM_JOB_NODELIST}"
echo "SLURM_NNODES = ${SLURM_NNODES}"
echo "SLURM_NTASK  = ${SLURM_NTASKS}"
echo "Submission directory = ${SLURM_SUBMIT_DIR}"
export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}
module purge || print_error_and_exit "Unable to find the 'module' command"
module use $HOME/.local/easybuild/${ULHPC_CLUSTER}/${RESIF_VERSION_PROD}/${RESIF_ARCH}/modules/all
module load devel/Spark ||  print_error_and_exit "Cannot load properly devel/Spark"
export SPARK_HOME=$EBROOTSPARK
APP=$SPARK_HOME/examples/src/main/python/pi.py
OPTS=1000
export SPARK_IDENT_STRING=${SLURM_JOBID}
export SPARK_LOG_DIR=${SPARK_LOG_DIR:-$HOME/.spark/logs}
export SPARK_WORKER_DIR=${SPARK_WORKER_DIR:-$HOME/.spark/worker}
export SPARK_LOCAL_DIRS=${SPARK_LOCAL_DIRS:-/tmp/spark}
mkdir -p ${SPARK_LOG_DIR} ${SPARK_WORKER_DIR}
export SPARK_WORKER_CORES=${SLURM_CPUS_PER_TASK:-1}
export DAEMON_MEM=${SLURM_MEM_PER_CPU:=4096}
export SPARK_MEM=$(( ${DAEMON_MEM}*(${SPARK_WORKER_CORES} -1) ))
export SPARK_DAEMON_MEMORY=${DAEMON_MEM}m
export SPARK_WORKER_MEMORY=${SPARK_MEM}m
export SPARK_EXECUTOR_MEMORY=${SPARK_MEM}m
export SPARK_MASTER_WEBUI_PORT=8082
SPARK_SLAVE_LAUNCHER=${SPARK_WORKER_DIR}/spark-start-slaves-${SLURM_JOBID}.sh
OUTPUTFILE=result_${SLURM_JOB_NAME}-${SLURM_JOB_ID}.out
export SPARK_MASTER_HOST=$(hostname -s)
export SPARK_MASTER_OPTS=
if [ -n "${SETUP_MASTER}" ]; then
    start-master.sh --host ${SPARK_MASTER_HOST} --webui-port ${SPARK_MASTER_WEBUI_PORT}
    sleep 2
fi
MASTER_URL=$(grep -Po '(?=spark://).*' \
                  ${SPARK_LOG_DIR}/spark-${SPARK_IDENT_STRING}-org.*master*.out)
echo "=========================================="
echo "============== Spark Master =============="
echo "=========================================="
echo "url: ${MASTER_URL}"
echo "Web UI: http://${SPARK_MASTER_HOST}:${SPARK_MASTER_WEBUI_PORT}"
echo ""
export SPARK_WORKER_OPTS=
echo "==========================================="
echo "============ ${SLURM_NTASKS} Spark Workers =============="
echo "==========================================="
echo "export SPARK_HOME=\$EBROOTSPARK"
echo "export MASTER_URL=${MASTER_URL}"
echo "export SPARK_DAEMON_MEMORY=${SPARK_DAEMON_MEMORY}"
echo "export SPARK_WORKER_CORES=${SPARK_WORKER_CORES}"
echo "export SPARK_WORKER_MEMORY=${SPARK_WORKER_MEMORY}"
echo "export SPARK_EXECUTOR_MEMORY=${SPARK_EXECUTOR_MEMORY}"
echo ""
echo " - create slave launcher script '${SPARK_SLAVE_LAUNCHER}'"
cat << 'EOF' > ${SPARK_SLAVE_LAUNCHER}
CORE=${SLURM_CPUS_PER_TASK:-1}
MASTER_URL="spark://$(scontrol show hostname $SLURM_NODELIST | head -n 1):7077"
if [[ ${SLURM_PROCID} -eq 0 ]]; then
   # Start one slave with one less core than the others on this node
   export SPARK_WORKER_CORES=$((${SLURM_CPUS_PER_TASK}-1))
fi
${SPARK_HOME}/sbin/start-slave.sh ${MASTER_URL}
EOF
chmod +x ${SPARK_SLAVE_LAUNCHER}
if [ -n "${SETUP_SLAVE}" ]; then
    # See sbin/spark-daemon.sh
    # SPARK_NO_DAEMONIZE: If set, will run the proposed command in the foreground.
    export SPARK_NO_DAEMONIZE=1
    ## sbin/start-slave.sh - Starts a slave instance on the machine the script is executed on.
    ## srun  --output=${SPARK_LOG_DIR}/spark-%j-workers.out --label \
        ##       start-slave.sh ${MASTER_URL} &
    srun --output=${SPARK_LOG_DIR}/spark-%j-workers.out \
         --label \
         ${SPARK_SLAVE_LAUNCHER} &
fi
if [ -n "${MODE_INTERACTIVE}" ]; then
    echo "=========================================="
    echo "        *** Interactive mode ***"
    echo "=========================================="
    echo "Ex of submission command:"
    cat << 'EOF'
    module load devel/Spark
    export SPARK_HOME=$EBROOTSPARK
    spark-submit \
        --master spark://$(scontrol show hostname $SLURM_NODELIST | head -n 1):7077 \
        --conf spark.driver.memory=${SPARK_DAEMON_MEMORY} \
        --conf spark.executor.memory=${SPARK_EXECUTOR_MEMORY} \
        --conf spark.python.worker.memory=${SPARK_WORKER_MEMORY} \
        $SPARK_HOME/examples/src/main/python/pi.py 1000
EOF
    exit 0
fi
echo "==========================================="
echo "=> running '${APP} ${OPTS}' on Spark cluster"
echo "=> output file: ${OUTPUTFILE}"
cat << EOF
spark-submit \
    --master spark://$(scontrol show hostname $SLURM_NODELIST | head -n 1):7077 \
    --conf spark.driver.memory=${SPARK_DAEMON_MEMORY} \
    --conf spark.executor.memory=${SPARK_EXECUTOR_MEMORY} \
    --conf spark.python.worker.memory=${SPARK_WORKER_MEMORY} \
    ${APP} ${OPTS}
EOF
spark-submit \
    --master ${MASTER_URL} \
    --conf spark.driver.memory=${SPARK_DAEMON_MEMORY} \
    --conf spark.executor.memory=${SPARK_EXECUTOR_MEMORY} \
    --conf spark.python.worker.memory=${SPARK_WORKER_MEMORY} \
    ${APP} ${OPTS} > ${OUTPUTFILE}
echo "==========================================="
echo "=> check the output file: ${OUTPUTFILE}"
echo
if [ -n "${SETUP_SLAVE}" ]; then
    echo "=> stopping worker(s)"
    scancel ${SLURM_JOBID}.0
    #srun --label stop-slave.sh
fi
if [ -n "${SETUP_MASTER}" ]; then
    echo "=> stopping spark master"
    stop-master.sh
fi
