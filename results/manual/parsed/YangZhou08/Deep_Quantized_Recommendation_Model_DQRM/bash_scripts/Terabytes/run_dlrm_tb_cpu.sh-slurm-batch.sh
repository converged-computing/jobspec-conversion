#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/YangZhou08/Deep_Quantized_Recommendation_Model_DQRM/bash_scripts/Terabytes/run_dlrm_tb_cpu.sh
