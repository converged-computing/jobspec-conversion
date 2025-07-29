#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ademerlis/temperaturevariability2023/gene_expression/archive/HP_pipeline/Acer/3_hisat2_index_alignment.sh
