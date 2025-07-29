#!/bin/bash
#SBATCH --job-name=ggr
#SBATCH --output=ggr.%j.out
#SBATCH --error=ggr.%j.err
#SBATCH --mail-user=dskim89@stanford.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=2-00:00:00
#SBATCH --partition=akundaje,khavari
#SBATCH: --exclusive

module load R/3.4.0 
module load java/1.8.0_131
module load python/3.6.1
source ~/.bashrc
source activate ggr_env
TMP_DIR=$L_SCRATCH
WORK_DIR=$PI_SCRATCH/users/dskim89/ggr/v1.1.0
echo $SLURM_JOB_CPUS_PER_NODE
ggr --cluster sherlock --threads $SLURM_JOB_CPUS_PER_NODE --out_dir $TMP_DIR
rsync -avz --progress $TMP_DIR/ $WORK_DIR/
