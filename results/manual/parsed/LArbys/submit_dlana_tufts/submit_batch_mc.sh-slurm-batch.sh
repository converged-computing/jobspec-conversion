#!/bin/bash
#SBATCH --job-name=dlana_batch_mc
#SBATCH --output=dlana_batch_mc_tmw.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=1-00:00:00
#SBATCH --array=0-250

container=/cluster/tufts/wongjiradlab/larbys/larbys-containers/singularity_dldependencies_pytorch1.3.sing
RUN_DLANA_DIR=/cluster/tufts/wongjiradlab/larbys/run_dlana_jobs
OFFSET=0
STRIDE=10
SAMPLE_NAME=mcc9_v28_wctagger_run3_bnb1e19                         # 2504 files
module load singularity
srun singularity exec ${container} bash -c "cd ${RUN_DLANA_DIR} && source run_batch_mc.sh $OFFSET $STRIDE $SAMPLE_NAME"
