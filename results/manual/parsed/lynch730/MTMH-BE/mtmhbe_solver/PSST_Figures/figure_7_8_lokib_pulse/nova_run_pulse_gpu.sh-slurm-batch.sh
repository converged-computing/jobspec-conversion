#!/bin/bash
#FLUX: --job-name=pulse_test
#FLUX: --queue=gpu
#FLUX: -t=2700
#FLUX: --urgency=16

module load matlab/R2022a
cd /home/lynch/boltzmann_solvers/mtmhbe_solver/performance/pulse_loki_b/
matlab -nodisplay -nosplash -nodesktop -r "time_convergence;exit;"
