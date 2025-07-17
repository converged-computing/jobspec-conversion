#!/bin/bash
#FLUX: --job-name=optim_102
#FLUX: -n=112
#FLUX: --queue=sapphire
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$HOME/.conda/envs/pylammps/lib:$LD_LIBRARY_PATH '
export PATH='$HOME/lammps/src/:$PATH'
export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh
module purge
module load rhel8/default-icl
module load intel-oneapi-mkl
module load fftw
conda activate pylammps
export LD_LIBRARY_PATH=$HOME/lammps/src:$LD_LIBRARY_PATH 
export LD_LIBRARY_PATH=$HOME/.conda/envs/pylammps/lib:$LD_LIBRARY_PATH 
export PATH=$HOME/lammps/src/:$PATH
application="python Python_Scripts/python_gmm_optim.py"
options="optim_param.json"
workdir=/home/ir-tiru1/Samanyu/WHHe_Fitting/git_folder
export OMP_NUM_THREADS=1
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
echo -e "\nnumtasks=$numtasks, numnodes=$numnodes, mpi_tasks_per_node=$mpi_tasks_per_node (OMP_NUM_THREADS=$OMP_NUM_THREADS)"
echo -e "\nExecuting command:\n==================\n$CMD\n"
eval $CMD
 heart 1
