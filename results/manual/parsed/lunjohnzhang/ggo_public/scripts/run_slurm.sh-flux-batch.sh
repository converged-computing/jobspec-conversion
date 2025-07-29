#!/bin/bash
#FLUX: --job-name=worker-${worker_id}_${DATE}
#FLUX: --queue=RM-shared
#FLUX: --urgency=16

print_header() {
echo
echo "------------- $1 -------------"
}
SINGULARITY_OPTS="--cleanenv --env MALLOC_TRIM_THRESHOLD_=0"
if [ -n "$PROJECT_DIR" ]; then
SINGULARITY_OPTS="$SINGULARITY_OPTS --bind ${PROJECT_DIR}:/project"
fi
echo "Singularity opts: ${SINGULARITY_OPTS}"
CONFIG="$1"
SEED="$2"
HPC_CONFIG="$3"
shift 3  # Remove first 3 parameters so getopts does not see them.
if [ -z "$HPC_CONFIG" ]
then
echo "Usage: bash scripts/run_slurm.sh CONFIG SEED HPC_CONFIG [-d] [-r LOGDIR]"
exit 1
fi
DRY_RUN=""
RELOAD_ARG=""
while getopts "dr:" opt; do
case $opt in
d)
echo "Using DRY RUN"
DRY_RUN="1"
;;
r)
echo "Using RELOAD: $OPTARG"
RELOAD_ARG="--reload $OPTARG"
;;
esac
done
source "$HPC_CONFIG"
if [ -z "$HPC_SLURM_ACCOUNT" ] ||
[ -z "$HPC_SLURM_TIME" ] ||
[ -z "$HPC_SLURM_NUM_NODES" ] ||
[ -z "$HPC_SLURM_CPUS_PER_NODE" ] ||
[ -z "$HPC_MASTER_WORKERS" ]
then
echo "\
HPC_CONFIG must have the following variables defined:
- HPC_SLURM_ACCOUNT
- HPC_SLURM_TIME
- HPC_SLURM_NUM_NODES
- HPC_SLURM_CPUS_PER_NODE
- HPC_MASTER_WORKERS"
exit 1
fi
if [ -z "$HPC_MASTER_GPU" ]; then
HPC_MASTER_GPU=""  # Make sure HPC_MASTER_GPU is initialized.
fi
if [ -z "$LOGDIR_ROOT_ARG" ]; then
LOGDIR_ROOT_ARG=""  # Make sure LOGDIR_ROOT_ARG is initialized.
else
LOGDIR_ROOT_ARG="--logdir_root $LOGDIR_ROOT_ARG"
fi
set -u  # Uninitialized vars are error.
JOB_IDS=""
submit_script() {
name="$1"
slurm_script="$2"
output=$(sbatch --parsable "$slurm_script")
IFS=';' read -ra tokens <<< "$output"
job_id="${tokens[0]}"
JOB_IDS="${JOB_IDS}${name};${job_id}\n"
echo "Submitted $job_id ($name)"
}
print_header "Create logging directory"
DATE="$(date +'%Y-%m-%d_%H-%M-%S')"
LOGDIR="slurm_logs/slurm_${DATE}"
echo "SLURM Log directory: ${LOGDIR}"
mkdir -p "$LOGDIR/config"
cp "$HPC_CONFIG" "$LOGDIR/config/"
print_header "Submitting scheduler"
SCHEDULER_SCRIPT="${LOGDIR}/scheduler.slurm"
SCHEDULER_OUTPUT="${LOGDIR}/scheduler.out"
SCHEDULER_FILE="${LOGDIR}/scheduler_info.json"
SCHEDULER_CPUS=$(( 2 + $HPC_MASTER_WORKERS ))
SCHEDULER_PORT=$((8786 + 10 + $SEED))
echo "Starting scheduler from: ${SCHEDULER_SCRIPT}"
echo "\
$(if [ -n "$HPC_MASTER_GPU" ]; then echo -e "#SBATCH --partition=GPU-shared\n#SBATCH --gres=gpu:v100-16:1"; else
echo -e "#SBATCH --partition=RM-shared\n"
fi)
echo
echo \"========== Start ==========\"
date
$(if [ -n "$HPC_MASTER_GPU" ]; then echo "module load gcc/11.3.0"; fi)
$(if [ -n "$HPC_MASTER_GPU" ]; then echo "module load cuda/11.7.1"; fi)
singularity exec ${SINGULARITY_OPTS} singularity/ubuntu_warehouse.sif \\
dask-scheduler \\
--port $SCHEDULER_PORT \\
--scheduler-file $SCHEDULER_FILE &
sleep 30  # Wait for scheduler to start.
address=\$(singularity exec ${SINGULARITY_OPTS} singularity/ubuntu_warehouse.sif python -c \"\\
import json
with open('$SCHEDULER_FILE', 'r') as file:
print(json.load(file)['address'])
\")
singularity exec ${SINGULARITY_OPTS} singularity/ubuntu_warehouse.sif \\
dask-worker \\
--scheduler-file $SCHEDULER_FILE \\
--nprocs $HPC_MASTER_WORKERS \\
--nthreads 1 &
singularity exec ${SINGULARITY_OPTS} $(if [ -n "$HPC_MASTER_GPU" ]; then echo "--nv"; fi) \\
singularity/ubuntu_warehouse.sif \\
python env_search/main.py \\
--config $CONFIG $RELOAD_ARG $LOGDIR_ROOT_ARG \\
--address \$address \\
--slurm-logdir $LOGDIR \\
--seed $SEED
echo
echo \"========== Done ==========\"
date" > "$SCHEDULER_SCRIPT"
if [ -z "$DRY_RUN" ]; then submit_script "scheduler" "$SCHEDULER_SCRIPT"; fi
print_header "Submitting workers"
for (( worker_id = 0; worker_id < $HPC_SLURM_NUM_NODES; worker_id++ ))
do
WORKER_SCRIPT="${LOGDIR}/worker-${worker_id}.slurm"
WORKER_OUTPUT="${LOGDIR}/worker-${worker_id}.out"
echo "Starting worker-${worker_id} from: ${WORKER_SCRIPT}"
echo "\
echo
echo \"========== Start ==========\"
date
singularity exec ${SINGULARITY_OPTS} singularity/ubuntu_warehouse.sif \\
dask-worker \\
--scheduler-file $SCHEDULER_FILE \\
--nprocs $HPC_SLURM_CPUS_PER_NODE \\
--nthreads 1
echo
echo \"========== Done ==========\"
date" > "$WORKER_SCRIPT"
if [ -z "$DRY_RUN" ]; then submit_script "worker-${worker_id}" "$WORKER_SCRIPT"; fi
done
print_header "Monitoring Instructions"
echo "\
To view output from the scheduler and main script, run:
tail -f $SCHEDULER_OUTPUT
"
if [ -n "$DRY_RUN" ]
then
print_header "Skipping cancellation, dashboard, postprocessing instructions"
exit 0
fi
echo -n -e "$JOB_IDS" > "${LOGDIR}/job_ids.txt"
print_header "Canceling"
echo "\
To cancel this job, run:
bash scripts/slurm_cancel.sh $LOGDIR
"
