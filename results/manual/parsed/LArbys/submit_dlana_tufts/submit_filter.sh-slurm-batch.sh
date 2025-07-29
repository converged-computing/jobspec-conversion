#!/bin/bash
#SBATCH --job-name=dlfilter
#SBATCH --output=dlfilter.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=00:40:00
#SBATCH --array=10-1955

container=/cluster/tufts/wongjiradlab/larbys/larbys-containers/singularity_dldependencies_pytorch1.3.sing
RUN_DLANA_DIR=/cluster/tufts/wongjiradlab/larbys/run_dlana_jobs
OFFSET=0
module load singularity
srun singularity exec ${container} bash -c "cd ${RUN_DLANA_DIR} && source run_filter_test.sh $OFFSET"
