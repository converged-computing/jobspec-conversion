#!/bin/bash
#SBATCH --job-name=filtering
#SBATCH --account=h3abionet
#SBATCH --output=/home/groups/h3abionet/RefGraph/results/NeginV_Test_Summer2021/slurm_output/slurm-%A.out
#SBATCH --mail-user=valizad2@illinois.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=18G

cd /home/groups/h3abionet/RefGraph/results/NeginV_Test_Summer2021
module load nextflow/21.04.1-Java-1.8.0_152
nextflow run HPCBio-Refgraph_pipeline/filter.nf \
-c HPCBio-Refgraph_pipeline/filter-config.conf \
-qs 3 -resume \
-with-report nextflow_reports/filter_nf_report.html \
-with-timeline nextflow_reports/filter_nf_timeline.html \
-with-trace nextflow_reports/filter_nf_trace.txt
 #   then 
  #      echo "The filtering has not been done correctly. Please check your blastncontam script"
   # fi
