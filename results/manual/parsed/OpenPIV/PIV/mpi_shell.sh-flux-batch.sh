#!/bin/bash
#FLUX: --job-name=arid-peanut-butter-1533
#FLUX: --priority=16

mpirun -np 128 --mca orte_base_help_aggregate 0 python PIV_MPI_cluster.py \
		"/n/home03/ngravish/Data/TandemFanning/5_GoodRuns_140VAmp_105mmLens_Wake15khz/PhaseEffects0_-0.62832_pi_140V_100Hz_23-Apr-2015_1_11/" \
		 > output.txt 2> errors.txt
