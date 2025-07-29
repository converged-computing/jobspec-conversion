#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/chhetribsurya/Encode_chipseq_pipe/submit_idr.calc_rescue_and_selfconsist_ratio.sh
