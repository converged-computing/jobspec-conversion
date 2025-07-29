#!/bin/bash
#SBATCH --job-name=cnn_gpus_nn
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=00:20:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=2
#SBATCH --no-requeue

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
echo -n '<1. starting python script > ' && date
echo '-- output -----------------------------'
srun python cnn_gpus.py --epochs 5 --batch-size 16
echo '-- end --------------------------------'
echo -n '<2. quit>                    ' && date
