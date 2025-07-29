#!/bin/bash
#SBATCH --job-name=NextflowWithSlurm
#SBATCH --output=/shares/von-mering.imls.uzh/tao/nextflow/slurm_reports/output_%A_%a.txt
#SBATCH --error=/shares/von-mering.imls.uzh/tao/nextflow/slurm_reports/error_%A_%a.txt
#SBATCH --mail-user=tao.fang@uzh.ch
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=5-00:00:00

module load anaconda3
module load singularityce
source activate /data/tfang/conda-envs/nf-training
cd /home/tfang/PPI_Prediction_byCoevolution/scripts
pwd
echo $CONDA_DEFAULT_ENV
nextflow run Query_coevolutionComputation_workflow.nf --root_folder "/shares/von-mering.imls.uzh/tao" -c nextflow.config -profile slurm_withSingularity  -resume
