#!/bin/bash
#FLUX: --job-name=crusty-mango-6137
#FLUX: --queue=cluster
#FLUX: -t=600
#FLUX: --urgency=16

source experiments.sh
function run_experiments {
 N=10
 OSUEXE=mpi/startup/osu_init
 for n in $(seq 1 $N); do run_osu_experiment; done
 OSUEXE=mpi/collective/osu_allgather
 for n in $(seq 1 $N); do run_osu_experiment; done
}
native_openmpi_setup_env
run_experiments
native_intelmpi_setup_env
run_experiments
singularity_mpich_setup_env
run_experiments
