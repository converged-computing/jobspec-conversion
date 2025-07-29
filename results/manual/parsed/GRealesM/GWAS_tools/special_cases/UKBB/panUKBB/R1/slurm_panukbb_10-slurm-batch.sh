#!/bin/bash
#FLUX: --job-name=pUKBB_10
#FLUX: --queue=skylake
#FLUX: -t=28800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export I_MPI_PIN_DOMAIN='omp:compact # Domains are $OMP_NUM_THREADS cores in size'
export I_MPI_PIN_ORDER='scatter # Adjacent domains have minimal sharing of caches/sockets'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel7/default-peta4            # REQUIRED - loads the basic environment
application=""
options=""
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
export OMP_NUM_THREADS=1
np=$[${numnodes}*${mpi_tasks_per_node}]
export I_MPI_PIN_DOMAIN=omp:compact # Domains are $OMP_NUM_THREADS cores in size
export I_MPI_PIN_ORDER=scatter # Adjacent domains have minimal sharing of caches/sockets
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
urlarray=($(cat urls_panukbb.txt |tr "\n" " "))
filenamearray=($(cat names_panukbb.txt |tr "\n" " "))
for i in {1080..1199};
do
echo "Downloading "${filenamearray[$i]}""
wget -O "${filenamearray[$i]}"_PanUKBB_PanUKBBR1_1.tsv.gz "${urlarray[$i]}" 
zcat "${filenamearray[$i]}"_PanUKBB_PanUKBBR1_1.tsv.gz | grep -F -f snp_manifest_300k_hg19coord.txt | gzip > tmp10.tsv.gz && mv tmp10.tsv.gz "${filenamearray[$i]}"_PanUKBB_PanUKBBR1_1.tsv.gz 
echo "Done. File is stored in "${filenamearray[$i]}"_PanUKBB_PanUKBBR1_1.tsv.gz"
done
