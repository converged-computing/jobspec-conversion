#!/bin/bash
#FLUX: --job-name=Tony_DPRV
#FLUX: --queue=ampere
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

numnodes=$SLURM_JOB_NUM_NODES
numtasks=$SLURM_NTASKS
mpi_tasks_per_node=$(echo "$SLURM_TASKS_PER_NODE" | sed -e  's/^\([0-9][0-9]*\).*$/\1/')
. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
source /usr/local/software/archive/linux-scientific7-x86_64/gcc-9/miniconda3-4.7.12.1-rmuek6r3f6p3v6fdj7o2klyzta3qhslh/bin/activate /home/ty308/.conda/envs/RAVQA2
export OMP_NUM_THREADS=1
JOBID=$SLURM_JOB_ID
LOG="/home/ty308/rds/hpc-work/myvqa/logs/logfile.$JOBID.log"
ERR="/home/ty308/rds/hpc-work/myvqa/logs/to/errorfile.$JOBID.err"
application="python src/tools/prepare_faiss_index.py"
options="--csv_path /home/ty308/rds/rds-cvnlp-hirYTW1FQIw/shared_space/vqa_data/KBVQA_data/ok-vqa/pre-extracted_features/passages/okvqa_full_corpus_title.csv \
    --output_dir /home/ty308/rds/hpc-work/data/ok-vqa/pre-extracted_features/faiss/ok-vqa-passages-full-new-framework \
    --dpr_ctx_encoder_model_name /home/ty308/rds/hpc-work/myvqa/Experiments/V_DPR/train/saved_model/epoch5/item_encoder \
    --dpr_ctx_encoder_tokenizer_name /home/ty308/rds/hpc-work/myvqa/Experiments/V_DPR/train/saved_model/epoch5/item_encoder_tokenizer"
workdir="$SLURM_SUBMIT_DIR"  # The value of SLURM_SUBMIT_DIR sets workdir to the directory
                             # in which sbatch is run.
np=$[${numnodes}*${mpi_tasks_per_node}]
CMD="$application $options"
cd $workdir
echo -e "Changed directory to `pwd`.\n"
JOBID=$SLURM_JOB_ID
echo -e "JobID: $JOBID\n======" > $LOG
echo "Time: `date`" >> $LOG
echo "Running on master node: `hostname`" >> $LOG
echo "Current directory: `pwd`"
echo "Time: `date`" >> $LOG
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
