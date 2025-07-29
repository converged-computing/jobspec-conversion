#!/bin/bash
#SBATCH --job-name=F_mamba_pe1u_noise
#SBATCH --account=COMPUTERLAB-SL2-GPU
#SBATCH --output=./logs/exp1_mamba_pe1u_noise_config-seed-job_%A_%a.out
#SBATCH --error=./logs/exp1_mamba_pe1u_noise_config-seed-job_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=0-2

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
module unload miniconda/3
module load cuda/11.8
conda init
conda activate L65
application="python"
options="main.py --cfg configs/Experiments/peptides-struct.yaml seed $SLURM_ARRAY_TASK_ID  wandb.project Mamba_pe1u_noise_Experiments_round_1 wandb.entity l65 device cuda gt.layer_type CustomGatedGCN+MambaL65 gt.mamba_heuristics global_pe_1 gt.mamba_noise 0.1 mamba_permute_iterations 5 out_dir results/pe1u_noise"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
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
if [ "$SLURM_JOB_NODELIST" ]; then
        #! Create a machine file:
        export NODEFILE=`generate_pbs_nodefile`
        cat $NODEFILE | uniq > machine.file.$JOBID
        echo -e "\nNodes allocated:\n================"
        echo `cat machine.file.$JOBID | sed -e 's/\..*$//g'`
fi
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD 
