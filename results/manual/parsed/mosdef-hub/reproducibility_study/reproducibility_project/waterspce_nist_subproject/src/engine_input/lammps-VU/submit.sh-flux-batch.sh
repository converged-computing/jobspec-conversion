#!/bin/bash
#FLUX: --job-name=test_job
#FLUX: -n=8
#FLUX: --queue=day-long-std
#FLUX: -t=86400
#FLUX: --urgency=16

echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
echo $infile $seed $T $P $rcut $tstep
module load lammps/3Aug2022
module avail
lmp -in $infile -var seed $seed -var T $T -var P $P -var rcut $rcut -var tstep $tstep
