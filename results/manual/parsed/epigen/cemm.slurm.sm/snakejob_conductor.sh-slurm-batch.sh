#!/bin/bash
#SBATCH --job-name=analysis_project_name
#SBATCH --output=</path/to/logs/>snakejob_conductor_%j.log
#SBATCH --error=</path/to/logs/>snakejob_conductor_%j.err
#SBATCH --mail-user=<username>@cemm.at
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --time=16:00:00
#SBATCH --partition=longq
#SBATCH --qos=longq

echo "======================"
echo $SLURM_SUBMIT_DIR
echo $SLURM_JOB_NAME
echo $SLURM_JOB_PARTITION
echo $SLURM_NTASKS
echo $SLURM_NPROCS
echo $SLURM_JOB_ID
echo $SLURM_JOB_NUM_NODES
echo $SLURM_NODELIST
echo $SLURM_CPUS_ON_NODE
echo "======================"
source <path/to/conda>/miniconda3/etc/profile.d/conda.sh
conda activate <snakemake_environment_name>
cd <path/to/workflow>
date
snakemake -p --use-conda
date
