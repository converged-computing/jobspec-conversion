#!/bin/bash
#FLUX: --job-name=fat-hope-9810
#FLUX: -c=32
#FLUX: --urgency=16

export TUNE_MAX_PENDING_TRIALS_PG='32'
export XLA_PYTHON_CLIENT_PREALLOCATE='false'
export OMP_NUM_THREADS='1'

export TUNE_MAX_PENDING_TRIALS_PG=32
export XLA_PYTHON_CLIENT_PREALLOCATE=false
numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
module load python-3.9.6-gcc-5.4.0-sbr552h
module load cuda/11.1
module load cudnn/8.0_cuda-11.1
group_name="${dataset}_${optimiser}_cheap"
write_path="/rds/user/authorid/hpc-work/LearningSecondOrderOptimiser/runs/${group_name}"
application="source .venv_3.9/bin/activate && "
declare -a seeds=("2119213981" "1608860012" "1021032354" "280853612" "1415121920" "503407898" "995043888" "333388907" "1971069637" "1335198443" "285161167" "894408494" "952170761" "704127742" "168220153" "48936849" "1822305184" "1550130155" "812730049" "833357148" "1043290698" "369867697" "1119789429" "495194068" "806185573" "980810461" "1323666201" "1112576223" "33383858" "735190115" "2114747825" "153301904" "1417633242" "572670284" "71283607" "545220238" "1708331336" "31319830" "795335164" "698059710" "1298677938" "1248108292" "129243081" "869963795" "1378116027" "73798405" "1729011228" "1539271366" "999822958" "1251819451")
num_parallel_calls=${num_parallel_calls}
options="echo ${seeds[@]:${start_seed_index}:${seed_offset}} | xargs -n 1 -P ${num_parallel_calls} python train.py -c configs/${dataset}_cheap/${dataset}.yaml configs/${dataset}_cheap/${optimiser}.json -g ${group_name} -n ${optimiser} --seed"
echo "Running x50 for ${optimiser} on ${dataset} for seeds ${start_seed_index} to ${seed_offset}"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
CMD="$application $options"
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
	mv machine.file.$JOBID $write_path/machine.file.$JOBID
fi
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD 
