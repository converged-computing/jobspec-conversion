#!/bin/bash
#FLUX: --job-name=outstanding-staircase-8211
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -t=7200
#FLUX: --urgency=16

export MV2_RAIL_SHARING_POLICY='FIXED_MAPPING'
export MV2_PROCESS_TO_RAIL_MAPPING='mlx5_0:mlx5_1'
export MV2_RAIL_SHARING_LARGE_MSG_THRESHOLD='1G'
export MV2_CPU_BINDING_LEVEL='SOCKET'
export MV2_CPU_BINDING_POLICY='SCATTER'
export MV2_USE_CUDA='1'
export MV2_USE_GPUDIRECT='1'
export CUDA_VISIBLE_DEVICE='0'
export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
ppn=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module load default-wilkes                 # REQUIRED - loads the basic environment
module load mvapich2-GDR/gnu/2.0-8_cuda-6.5
module load cuda/6.5
export MV2_RAIL_SHARING_POLICY=FIXED_MAPPING
export MV2_PROCESS_TO_RAIL_MAPPING=mlx5_0:mlx5_1
export MV2_RAIL_SHARING_LARGE_MSG_THRESHOLD=1G
export MV2_CPU_BINDING_LEVEL=SOCKET
export MV2_CPU_BINDING_POLICY=SCATTER
export MV2_USE_CUDA=1
export MV2_USE_GPUDIRECT=1
export CUDA_VISIBLE_DEVICE=0
application="bin/smaug"
options=" -genvall "
appopts="a"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
ppn=2
export OMP_NUM_THREADS=1
mpi_tasks_per_node=$[$ppn/$OMP_NUM_THREADS]
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
CMD="mpirun -ppn 2 -np 4  $options $application $appopts"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
cd bin
cp smaug smaug_nogpud
cd ..
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
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, ppn=$ppn (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD 
