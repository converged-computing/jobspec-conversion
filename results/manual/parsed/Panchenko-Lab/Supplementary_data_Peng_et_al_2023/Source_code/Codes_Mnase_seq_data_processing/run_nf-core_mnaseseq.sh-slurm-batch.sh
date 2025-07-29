#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Panchenko-Lab/Supplementary_data_Peng_et_al_2023/Source_code/Codes_Mnase_seq_data_processing/run_nf-core_mnaseseq.sh
