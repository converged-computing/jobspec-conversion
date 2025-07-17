#!/bin/bash
#FLUX: --job-name=gpujob
#FLUX: --queue=ampere
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
source /home/${USER}/.bashrc
conda activate QChemGPU
application="python -u run.py"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
cd $workdir
echo -e "Changed directory to `pwd`.\n"
mkdir -p logs
options="--standardization=mad --predict_all=True --model_name=egnn --num_towers=0 --hidden_channels=128 --num_layers=7"
CMD="python -u run.py $options"
log_file="logs/MAD_EGNN_spatial_alltargets_run1.$SLURM_JOB_ID"
echo "Executing: $CMD > $log_file"
eval $CMD > $log_file
