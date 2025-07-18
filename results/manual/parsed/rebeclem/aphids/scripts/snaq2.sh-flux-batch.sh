#!/bin/bash
#FLUX: --job-name=snaq
#FLUX: -c=31
#FLUX: --queue=long
#FLUX: -t=1814400
#FLUX: --urgency=16

t1=$(date +"%s")
module load julia/1.5.3 
echo "slurm task ID = $SLURM_ARRAY_TASK_ID used as hmax"
echo "start of SNaQ parallel runs on $(hostname)"
julia --project="/home/rebecca.clement/.julia/project1/" /home/rebecca.clement/90day_aphid/aphids_github/scripts/runSNaQ2.jl $SLURM_ARRAY_TASK_ID 10 > net${SLURM_ARRAY_TASK_ID}_10runs.screenlog 2>&1
echo "end of SNaQ run ..."
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
