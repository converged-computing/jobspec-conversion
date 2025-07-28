#!/bin/bash
#FLUX: --job-name=postproc_smash
#FLUX: -n=160
#FLUX: -c=2
#FLUX: --queue=main
#FLUX: -t=5400
#FLUX: --urgency=16

container=$LH/fedora_38_std.sif
datadir=$LH/compare_pythia_versions_in_smash/RUNS/
vers_old=8.311
vers_new=8.312
for i in {1..80}
do
singularity exec $container python3 compute_observables.py $datadir/results_$vers_old\_$i.dat $datadir/run_200_$vers_old\_$i/out_{1..10}/particle_lists.oscar &> log_$vers_old\_$i &
singularity exec $container python3 compute_observables.py $datadir/results_$vers_new\_$i.dat $datadir/run_200_$vers_new\_$i/out_{1..10}/particle_lists.oscar &> log_$vers_new\_$i &
done
wait
sleep 60
