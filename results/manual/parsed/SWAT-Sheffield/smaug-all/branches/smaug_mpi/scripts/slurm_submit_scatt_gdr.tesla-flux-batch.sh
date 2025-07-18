#!/bin/bash
#FLUX: --job-name=sscatt_ngdr
#FLUX: --queue=tesla
#FLUX: -t=7200
#FLUX: --urgency=16

export MV2_USE_CUDA='1'
export MV2_USE_GPUDIRECT='1'
export MV2_RAIL_SHARING_POLICY='FIXED_MAPPING'
export MV2_PROCESS_TO_RAIL_MAPPING='mlx5_0:mlx5_1'
export MV2_RAIL_SHARING_LARGE_MSG_THRESHOLD='1G'
export MV2_CPU_BINDING_LEVEL='SOCKET'
export MV2_CPU_BINDING_POLICY='SCATTER'
export CUDA_VISIBLE_DEVICE='0'
export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

help()
{
	echo "This program takes output smaug data and gathers into a single outputfile"
        echo "./smauggather.sh numproc start finish step"
	echo "numproc is the number of processors"
        echo "start is the starting step"
        echo "finish is the final step"
        echo "step is optional and is the interval"
	exit 1
}
numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
ppn=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module load default-wilkes                 # REQUIRED - loads the basic environment
module load cuda/5.5
module load mvapich2/gcc/2.0b/gdr
export MV2_USE_CUDA=1
export MV2_USE_GPUDIRECT=1
export MV2_RAIL_SHARING_POLICY=FIXED_MAPPING
export MV2_PROCESS_TO_RAIL_MAPPING=mlx5_0:mlx5_1
export MV2_RAIL_SHARING_LARGE_MSG_THRESHOLD=1G
export MV2_CPU_BINDING_LEVEL=SOCKET
export MV2_CPU_BINDING_POLICY=SCATTER
export CUDA_VISIBLE_DEVICE=0
application="bin/smaug"
options=" -genvall "
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
ppn=1
export OMP_NUM_THREADS=1
mpi_tasks_per_node=$[$ppn/$OMP_NUM_THREADS]
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
CMD="mpirun -ppn $mpi_tasks_per_node -np $np $application $options"
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
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, ppn=$ppn (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
start=0
end=50 
step=1
current=$start
numproc=4
        #eval $CMD
        #mpirun -np $numproc bin/smaug -o gather $current
        #mpirun -npernode $mpi_tasks_per_node -np $np $application -o gather $current
	mpirun -ppn $mpi_tasks_per_node -np $np $options $application -o scatter
        #current=`expr $current + $step`
