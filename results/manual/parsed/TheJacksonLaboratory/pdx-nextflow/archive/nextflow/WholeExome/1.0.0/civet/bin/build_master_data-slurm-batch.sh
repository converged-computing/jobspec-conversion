#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/TheJacksonLaboratory/pdx-nextflow/archive/nextflow/WholeExome/1.0.0/civet/bin/build_master_data
