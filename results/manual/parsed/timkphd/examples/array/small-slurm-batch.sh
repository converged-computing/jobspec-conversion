#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --account=hpcapps
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=00:05:00
#SBATCH --partition=standard
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-24

export input='`head -n $SLURM_ARRAY_TASK_ID $SLURM_SUBMIT_DIR/list | tail -1`'

module purge
module load slurm
module use /projects/hpcapps/tkaiser2/011923_b/lmod/linux-rocky8-x86_64/gcc/12.1.0/
module load python/3.11.1
mkdir -p $SLURM_ARRAY_JOB_ID/$SLURM_ARRAY_TASK_ID
cd $SLURM_ARRAY_JOB_ID/$SLURM_ARRAY_TASK_ID
export input=`head -n $SLURM_ARRAY_TASK_ID $SLURM_SUBMIT_DIR/list | tail -1`
echo $input > input
$SLURM_SUBMIT_DIR/invertp.py `cat input` > output
