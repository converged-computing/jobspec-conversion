#!/bin/bash
#FLUX: --job-name=sn-sg
#FLUX: -c=10
#FLUX: --exclusive
#FLUX: --queue=nvidia_small
#FLUX: -t=3600
#FLUX: --urgency=16

echo '========================================'
echo '- Job ID:' $SLURM_JOB_ID
echo '- # of nodes in the job:' $SLURM_JOB_NUM_NODES
echo '- # of tasks per node:' $SLURM_NTASKS_PER_NODE
echo '- # of tasks:' $SLURM_NTASKS
echo '- # of cpus per task:' $SLURM_CPUS_PER_TASK
echo '- Dir from which sbatch was invoked:' ${SLURM_SUBMIT_DIR##*/}
echo -n '- Nodes allocated to the job: '
nodeset -e $SLURM_JOB_NODELIST
cd $SLURM_SUBMIT_DIR
module load gcc/8.3
source /scratch/proj/name.user/miniconda3/bin/activate
conda activate myenv
echo -n '<1. Starting python script > ' && date
echo '-- output -----------------------------'
srun python dcgan.py
echo '-- end --------------------------------'
echo -n '<2. quit>                    ' && date
