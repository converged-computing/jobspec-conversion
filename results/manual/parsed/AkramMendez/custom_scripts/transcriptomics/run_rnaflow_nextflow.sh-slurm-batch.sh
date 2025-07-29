#!/bin/bash
#SBATCH --job-name=rnaflow
#SBATCH --account=snic2022-22-85
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

export NXF_HOME='/crex/proj/nb_storage/private/rnaflow/nextflow_home'
export CONDA_ENVS_PATH='/proj/nb_project/private/conda_envs'

module load bioinfo-tools
module load FastQC
module load fastp
module load samtools
module load subread
module load MultiQC
reads_file=$(realpath $1)
fastas_file=$(realpath $2)
gtf_file=$(realpath $3)
comparisons=$(realpath $4)
results_name=$5
outdir=$(realpath $6)
cd /crex/proj/nb_storage/private/rnaflow
export NXF_HOME=/crex/proj/nb_storage/private/rnaflow/nextflow_home
export CONDA_ENVS_PATH=/proj/nb_project/private/conda_envs
conda activate nextflow
echo "Running rnaflow"
nextflow run hoelzer-lab/rnaflow \
--reads ${reads_file} \
--genome ${fastas_file} \
--annotation ${gtf_file} \
-profile slurm,conda,latency \
--mode paired \
--strand 0 \
--skip_sortmerna \
--cores ${SLURM_NTASKS} \
--output ${results_name} \
--deg ${comparisons} \
-w ${outdir}
echo "Done."
