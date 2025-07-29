#!/bin/bash
#SBATCH --job-name=DSE-Nord3
#SBATCH --output=logs/slurm-%j.out
#SBATCH --error=logs/slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00
#SBATCH --qos=bsc_ls
#SBATCH --constraint=ntasks-per-node=16

export NXF_OPTS='-Xms500M -Xmx2G'

source_dir="$(pwd)"
report_dir="${source_dir}/reports"
module load nextflow/21.04.1
export NXF_OPTS="-Xms500M -Xmx2G"
nextflow run "${source_dir}/main.nf" \
	-with-report "${report_dir}/report.html" \
        -with-trace "${report_dir}/trace.txt" \
        -with-timeline "${report_dir}/timeline.html" \
	-with-dag "${report_dir}/flowchart.png" \
	-profile slurm \
	#-resume awesome_banach
