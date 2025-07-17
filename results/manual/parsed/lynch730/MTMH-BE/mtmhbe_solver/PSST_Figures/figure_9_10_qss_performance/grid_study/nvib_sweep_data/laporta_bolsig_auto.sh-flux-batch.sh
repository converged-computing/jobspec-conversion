#!/bin/bash
#FLUX: --job-name=glap_bol_auto
#FLUX: -t=3600
#FLUX: --urgency=16

export omp_num_threads='8'

module load matlab/R2022a
module load intel
export omp_num_threads=8
cd /home/lynch/boltzmann_solvers/mtmhbe_solver/performance/laporta/grid_study/nvib_sweep_data/
matlab -nodisplay -nosplash -nodesktop -r "laporta_bolsig_auto;exit;"
