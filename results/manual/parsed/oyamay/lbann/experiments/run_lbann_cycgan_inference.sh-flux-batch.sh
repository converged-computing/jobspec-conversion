#!/bin/bash
#FLUX: --job-name=grated-lemon-2968
#FLUX: --urgency=16

EXPERIMENT=$1
EXPERIMENT_NAME=lbann_cycgan_jag_inference
LBANN_DIR=$(git rev-parse --show-toplevel)
MODEL_PROTO="--model={${LBANN_DIR}/model_zoo/models/jag/ae_cycle_gan/cycgan_m2.prototext,${LBANN_DIR}/model_zoo/models/jag/ae_cycle_gan/vae1.prototext,${LBANN_DIR}/model_zoo/models/jag/ae_cycle_gan/vae_cyc.prototext}"
READER_PROTO="--reader=${LBANN_DIR}/model_zoo/models/jag/ae_cycle_gan/data_reader_jag_conduit_lustre.prototext"
OPTIMIZER_PROTO="--optimizer=${LBANN_DIR}/model_zoo/optimizers/opt_adam.prototext"
CKPT_DIR="--ckpt_dir=${LBANN_DIR}/experiments/${EXPERIMENT}"
BUILD=            # default: Release
NUM_NODES=      # default: number of allocated nodes (1 if none)
PROCS_PER_NODE= # default: GPUs per node (2 if cluster has no GPUs)
CLUSTER=
PARTITION=
ACCOUNT=
TIME_LIMIT=     # default: 1:00 (format is hours:minutes)
SUBMIT_JOB=       # default: YES
USE_GPU=          # default: YES (ignored if built without GPUs)
CACHE_DATASET=    # default: NO
USE_VTUNE=        # default: NO
USE_NVPROF=       # default: NO
USE_CUDAMEMCHECK= # default: NO
EXPERIMENT_HOME_DIR=${EXPERIMENT_HOME_DIR:-${LBANN_DIR}/experiments}
TRAIN_DATASET_DIR=/p/lustre2/brainusr/datasets/10MJAG/10K_A_bve/
TRAIN_DATASET_LABELS=
TEST_DATASET_DIR=/p/lustre2/brainusr/datasets/10MJAG/10K_B_bve/
TEST_DATASET_LABELS=
DATASET_TARBALLS=
CACHE_DIR=
EXPERIMENT_SCRIPT=$(readlink -f "$0")
VTUNE_EXE="amplxe-cl-mpi -collect hotspots"
NVPROF_EXE="nvprof --profile-child-processes --unified-memory-profiling off"
CUDAMEMCHECK_EXE="${LBANN_DIR}/scripts/debug/cuda-memcheck.sh"
EXPERIMENT_NAME=${EXPERIMENT_NAME:-lbann}
BUILD=${BUILD:-Release}
if [ -z "${NUM_NODES}" ]; then
    if [ -n "${SLURM_JOB_NUM_NODES}" ]; then
        NUM_NODES=${SLURM_JOB_NUM_NODES}
    else
        NUM_NODES=1
    fi
fi
TIME_LIMIT=${TIME_LIMIT:-1:00}
SUBMIT_JOB=${SUBMIT_JOB:-YES}
USE_GPU=${USE_GPU:-YES}
CACHE_DATASET=${CACHE_DATASET:-NO}
USE_VTUNE=${USE_VTUNE:-NO}
USE_NVPROF=${USE_NVPROF:-NO}
USE_CUDAMEMCHECK=${USE_CUDAMEMCHECK:-NO}
source LC_cluster_specific_defaults.sh
if [ -z "${PROCS_PER_NODE}" ]; then
    PROCS_PER_NODE=2
    case ${HAS_GPU} in
        YES|yes|TRUE|true|ON|on|1)
            case ${USE_GPU} in
                YES|yes|TRUE|true|ON|on|1)
                    PROCS_PER_NODE=${GPUS_PER_NODE}
                    ;;
            esac
            ;;
    esac
fi
NUM_PROCS=$((${NUM_NODES}*${PROCS_PER_NODE}))
CORES_PER_PROC=$((${CORES_PER_NODE}/${PROCS_PER_NODE}))
if [ -n "${TRAIN_DATASET_DIR}" ]; then
    READER_PROTO="${READER_PROTO} --data_filedir_train=${TRAIN_DATASET_DIR}"
fi
if [ -n "${TRAIN_DATASET_LABELS}" ]; then
    READER_PROTO="${READER_PROTO} --data_filename_train=${TRAIN_DATASET_LABELS}"
fi
if [ -n "${TEST_DATASET_DIR}" ]; then
    READER_PROTO="${READER_PROTO} --data_filedir_test=${TEST_DATASET_DIR}"
fi
if [ -n "${TEST_DATASET_LABELS}" ]; then
    READER_PROTO="${READER_PROTO} --data_filename_test=${TEST_DATASET_LABELS}"
fi
LBANN_EXE="${LBANN_DIR}/build/gnu.${BUILD}.${CLUSTER}.llnl.gov/lbann/build/model_zoo/lbann_inf"
case ${USE_GPU} in
    YES|yes|TRUE|true|ON|on|1)
        case ${HAS_GPU} in
            YES|yes|TRUE|true|ON|on|1)
                MODEL_PROTO="${MODEL_PROTO} --disable_cuda=0"
                ;;
        esac
        ;;
    *)
        MODEL_PROTO="${MODEL_PROTO} --disable_cuda=1"
        EXPERIMENT_NAME=${EXPERIMENT_NAME}_nogpu
        ;;
esac
EXPERIMENT_COMMAND="${LBANN_EXE} --mini_batch_size=2048 --data_reader_percent=1.0 --share_testing_data_readers=1 ${MODEL_PROTO} ${OPTIMIZER_PROTO} ${READER_PROTO} ${CKPT_DIR}"
case ${USE_VTUNE} in
    YES|yes|TRUE|true|ON|on|1)
        DEBUGGER_COMMAND="${DEBUGGER_COMMAND} ${VTUNE_EXE} -r ./vtune --"
        EXPERIMENT_NAME=${EXPERIMENT_NAME}_vtune
        ;;
esac
case ${USE_NVPROF} in
    YES|yes|TRUE|true|ON|on|1)
        DEBUGGER_COMMAND="${DEBUGGER_COMMAND} ${NVPROF_EXE} --log-file nvprof_output-%h-%p.txt --export-profile %h-%p.prof"
        EXPERIMENT_NAME=${EXPERIMENT_NAME}_nvprof
        ;;
esac
case ${USE_CUDAMEMCHECK} in
    YES|yes|TRUE|true|ON|on|1)
        DEBUGGER_COMMAND="${DEBUGGER_COMMAND} ${CUDAMEMCHECK_EXE}"
        EXPERIMENT_NAME=${EXPERIMENT_NAME}_cudamemcheck
        ;;
esac
case ${SCHEDULER} in
    slurm)
        MPIRUN="srun --nodes=${NUM_NODES} --ntasks=${NUM_PROCS}"
        case ${CLUSTER} in
            surface|ray)
                MPIRUN="${MPIRUN} --mpibind=off --nvidia_compute_mode=default"
                ;;
            pascal)
                MPIRUN="${MPIRUN} --mpibind=off --nvidia_compute_mode=default --cpu_bind=mask_cpu:0x000001ff,0x0003fe00"
                ;;
        esac
        MPIRUN1="srun --nodes=${NUM_NODES} --ntasks=${NUM_NODES}"
        MPIRUN2="srun --nodes=${NUM_NODES} --ntasks=$((2*${NUM_NODES}))"
        ;;
    lsf)
        MPIRUN="mpirun -np ${NUM_PROCS} -N ${PROCS_PER_NODE}"
        MPIRUN1="mpirun -np ${NUM_NODES} -N 1"
        MPIRUN2="mpirun -np $((2*${NUM_NODES})) -N 2"
        ;;
esac
EXPERIMENT_NAME=${EXPERIMENT_NAME}_${CLUSTER}_${PARTITION}_N${NUM_NODES}
EXPERIMENT_DIR=${EXPERIMENT_HOME_DIR}/$(date +%Y%m%d_%H%M%S)_${EXPERIMENT_NAME}
mkdir -p ${EXPERIMENT_DIR}
case ${USE_VTUNE} in
    YES|yes|TRUE|true|ON|on|1)
        VTUNE_DIR=${EXPERIMENT_DIR}/vtune
        mkdir ${VTUNE_DIR}
        ;;
esac
pushd ${EXPERIMENT_DIR}
cp ${EXPERIMENT_SCRIPT} ${EXPERIMENT_DIR}
BATCH_SCRIPT=${EXPERIMENT_DIR}/batch.sh
LOG_FILE=${EXPERIMENT_DIR}/output.txt
NODE_LIST=${EXPERIMENT_DIR}/nodes.txt
echo "#!/bin/sh"                                         > ${BATCH_SCRIPT}
case ${SCHEDULER} in
    slurm)
        echo "#SBATCH --job-name=${EXPERIMENT_NAME}"    >> ${BATCH_SCRIPT}
        echo "#SBATCH --nodes=${NUM_NODES}"             >> ${BATCH_SCRIPT}
        echo "#SBATCH --partition=${PARTITION}"         >> ${BATCH_SCRIPT}
        if [ "${CLUSTER}" != "flash" ]; then
            echo "#SBATCH --account=${ACCOUNT}"         >> ${BATCH_SCRIPT}
        fi
        echo "#SBATCH --workdir=${EXPERIMENT_DIR}"      >> ${BATCH_SCRIPT}
        echo "#SBATCH --output=${LOG_FILE}"             >> ${BATCH_SCRIPT}
        echo "#SBATCH --error=${LOG_FILE}"              >> ${BATCH_SCRIPT}
        echo "#SBATCH --time=${TIME_LIMIT}:00"          >> ${BATCH_SCRIPT}
        ;;
    lsf)
        echo "#BSUB -J ${EXPERIMENT_NAME}"              >> ${BATCH_SCRIPT}
        echo "#BSUB -n ${NUM_PROCS}"                    >> ${BATCH_SCRIPT}
        echo "#BSUB -R \"span[ptile=${PROCS_PER_NODE}]\"" >> ${BATCH_SCRIPT}
        echo "#BSUB -R \"affinity[core(${CORES_PER_PROC}):cpubind=core:distribute=balance]\"" >> ${BATCH_SCRIPT}
        echo "#BSUB -q ${PARTITION}"                    >> ${BATCH_SCRIPT}
        echo "#BSUB -G ${ACCOUNT}"                      >> ${BATCH_SCRIPT}
        echo "#BSUB -cwd ${EXPERIMENT_DIR}"             >> ${BATCH_SCRIPT}
        echo "#BSUB -o ${LOG_FILE}"                     >> ${BATCH_SCRIPT}
        echo "#BSUB -e ${LOG_FILE}"                     >> ${BATCH_SCRIPT}
        echo "#BSUB -W ${TIME_LIMIT}"                   >> ${BATCH_SCRIPT}
        echo "#BSUB -x"                                 >> ${BATCH_SCRIPT}
        ;;
esac
echo ""                                                 >> ${BATCH_SCRIPT}
echo "# ======== Experiment parameters ========"        >> ${BATCH_SCRIPT}
echo "# Batch script generated by ${EXPERIMENT_SCRIPT}" >> ${BATCH_SCRIPT}
echo "# Directory: ${EXPERIMENT_DIR}"                   >> ${BATCH_SCRIPT}
echo "# Time: $(date "+%Y-%m-%d %H:%M:%S")"             >> ${BATCH_SCRIPT}
echo "# EXPERIMENT_NAME: ${EXPERIMENT_NAME}"            >> ${BATCH_SCRIPT}
echo "# LBANN_DIR: ${LBANN_DIR}"                        >> ${BATCH_SCRIPT}
echo "# EXPERIMENT_COMMAND: ${EXPERIMENT_COMMAND}"      >> ${BATCH_SCRIPT}
echo "# NUM_NODES: ${NUM_NODES}"                        >> ${BATCH_SCRIPT}
echo "# PROCS_PER_NODE: ${PROCS_PER_NODE}"              >> ${BATCH_SCRIPT}
echo "# CLUSTER: ${CLUSTER}"                            >> ${BATCH_SCRIPT}
echo "# PARTITION: ${PARTITION}"                        >> ${BATCH_SCRIPT}
echo "# ACCOUNT: ${ACCOUNT}"                            >> ${BATCH_SCRIPT}
echo "# SUBMIT_JOB: ${SUBMIT_JOB}"                      >> ${BATCH_SCRIPT}
echo "# USE_GPU: ${USE_GPU}"                            >> ${BATCH_SCRIPT}
echo "# CACHE_DATASET: ${CACHE_DATASET}"                >> ${BATCH_SCRIPT}
echo "# USE_VTUNE: ${USE_VTUNE}"                        >> ${BATCH_SCRIPT}
echo "# USE_NVPROF: ${USE_NVPROF}"                      >> ${BATCH_SCRIPT}
echo "# USE_CUDAMEMCHECK: ${USE_CUDAMEMCHECK}"          >> ${BATCH_SCRIPT}
echo "# EXPERIMENT_HOME_DIR: ${EXPERIMENT_HOME_DIR}"    >> ${BATCH_SCRIPT}
echo "# CACHE_DIR: ${CACHE_DIR}"                        >> ${BATCH_SCRIPT}
echo ""                                                 >> ${BATCH_SCRIPT}
echo "# ======== Useful info and initialization ========" >> ${BATCH_SCRIPT}
echo "date"                                             >> ${BATCH_SCRIPT}
echo "${MPIRUN} hostname > ${NODE_LIST}"                >> ${BATCH_SCRIPT}
echo "sort --unique --output=${NODE_LIST} ${NODE_LIST}" >> ${BATCH_SCRIPT}
case ${CLUSTER} in
    pascal)
        echo "export OMP_NUM_THREADS=8"                 >> ${BATCH_SCRIPT}
        echo "export AL_PROGRESS_RANKS_PER_NUMA_NODE=2" >> ${BATCH_SCRIPT}
        ;;
esac
echo "export MV2_USE_RDMA_CM=0"                         >> ${BATCH_SCRIPT}
echo "export MV2_USE_LAZY_MEM_UNREGISTER=0"             >> ${BATCH_SCRIPT}
echo ""                                                 >> ${BATCH_SCRIPT}
case ${CACHE_DATASET} in
    YES|yes|TRUE|true|ON|on|1)
        COPY="/collab/usr/global/tools/stat/file_bcast/${SYS_TYPE}/fbcast/file_bcast_par13 1MB"
        echo "# ======== Cache dataset ========" >> ${BATCH_SCRIPT}
        echo "echo \"Caching dataset...\"" >> ${BATCH_SCRIPT}
        for TARBALL in ${DATASET_TARBALLS}
        do
            CACHE_TARBALL=${CACHE_DIR}/$(basename ${TARBALL})
            OUTPUT_DIR=${CACHE_DIR}/$(basename ${TARBALL} .tar)
            echo "[ -e ${CACHE_TARBALL} ] || \\" >> ${BATCH_SCRIPT}
            echo "  ${MPIRUN2} ${COPY} ${TARBALL} ${CACHE_TARBALL} > /dev/null" >> ${BATCH_SCRIPT}
            echo "echo \"Copied ${TARBALL} to ${CACHE_TARBALL}...\"" >> ${BATCH_SCRIPT}
            echo "[ -d ${OUTPUT_DIR} ] || \\" >> ${BATCH_SCRIPT}
            echo "  ${MPIRUN1} tar xf ${CACHE_TARBALL} -C ${CACHE_DIR}" >> ${BATCH_SCRIPT}
            echo "echo \"Untarred ${CACHE_TARBALL}...\"" >> ${BATCH_SCRIPT}
        done
        echo "echo \"Done caching dataset...\"" >> ${BATCH_SCRIPT}
        echo "" >> ${BATCH_SCRIPT}
        ;;
esac
echo "# ======== Experiment ========" >> ${BATCH_SCRIPT}
echo "${MPIRUN} ${DEBUGGER_COMMAND} ${EXPERIMENT_COMMAND}" >> ${BATCH_SCRIPT}
SUBMIT_EXE=sh
case ${SCHEDULER} in
    slurm)
        if [ -z "${SLURM_JOB_ID}" ]; then
            SUBMIT_EXE=sbatch
        fi
        ;;
    lsf)
        SUBMIT_EXE="bsub <"
        ;;
esac
case ${SUBMIT_JOB} in
    YES|yes|TRUE|true|ON|on|1)
        eval "${SUBMIT_EXE} ${BATCH_SCRIPT} 2>&1 | tee ${LOG_FILE}"
        ;;
esac
dirs -c
