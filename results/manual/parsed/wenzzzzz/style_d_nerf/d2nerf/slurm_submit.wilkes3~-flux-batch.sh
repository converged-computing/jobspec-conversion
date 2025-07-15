#!/bin/bash
#FLUX: --job-name=wobbly-noodle-2854
#FLUX: -t=10800
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
module load cuda/11.1
module unload cuda/8.0
source /usr/local/software/archive/linux-scientific7-x86_64/gcc-9/miniconda3-4.7.12.1-rmuek6r3f6p3v6fdj7o2klyzta3qhslh/etc/profile.d/conda.sh
conda activate d2nerf
options=""
workdir="/home/wl301/rds/hpc-work/d2nerf"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
CMD="$application $options"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======"
echo "Time: `date`"
echo "Running on master node: `hostname`"
echo "Current directory: `pwd`"
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
DATA='camera_shadow'
DATA_PATH="./data/$DATA/"
LOG_PATH="log/$DATA/test_stability_v1"
CONFIG_PATH='configs/decompose/train.gin'
echo "Log path is: $LOG_PATH"
python train.py --base_folder $LOG_PATH --gin_bindings="data_dir='$DATA_PATH'" --gin_configs $CONFIG_PATH
python eval.py --base_folder $LOG_PATH --gin_bindings="data_dir='$DATA_PATH'" --gin_configs $CONFIG_PATH
