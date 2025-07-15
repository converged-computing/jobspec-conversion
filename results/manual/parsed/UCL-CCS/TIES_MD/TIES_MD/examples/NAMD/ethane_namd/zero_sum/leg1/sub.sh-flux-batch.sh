#!/bin/bash
#FLUX: --job-name=LIGPAIR
#FLUX: -N=4
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --urgency=16

module load namd/2.14-nosmp
nodes_per_namd=1
cpus_per_namd=128
ties_dir=/home/a/post_qa/TIES_MD/TIES_MD/examples/ethane_namd/zero_sum/leg1
cd $ties_dir/replica-confs
for stage in {0..3}; do
for lambda in 0.00 1.00; do
 for i in {0..1}; do
        /home/a/NAMD/NAMD_3.0alpha13_Linux-x86_64-multicore-CUDA/namd3 --tclmain run$stage.conf $lambda $i &
        sleep 1
done
done
wait
done
