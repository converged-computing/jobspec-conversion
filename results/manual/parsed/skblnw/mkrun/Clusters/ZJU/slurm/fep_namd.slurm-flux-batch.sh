#!/bin/bash
#FLUX: --job-name=misunderstood-kerfuffle-5321
#FLUX: -t=86400
#FLUX: --priority=16

echo "Start time: $(date)"
echo "SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST"
echo "hostname: $(hostname)"
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
echo "Job directory: $(pwd)"
source /public/software/profile.d/apps_namd-3.0alpha9.sh
NAMD="namd3"
$NAMD +p1 +devices 0 eq/fep.eq.namd >& eq/LOG_eq
for ii in $(seq 1 1); do
    rsync -avh eq/fep.namd eq/fep.tcl eq/equilibrate.coor eq/equilibrate.vel eq/equilibrate.xsc trial${ii}
    $NAMD +p1 +devices 0 trial${ii}/fep.namd >& trial${ii}/LOG_fep
done
