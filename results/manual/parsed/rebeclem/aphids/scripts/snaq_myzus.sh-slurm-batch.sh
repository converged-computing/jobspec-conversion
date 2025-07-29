#!/bin/bash
#SBATCH --job-name=snaq_myzus
#SBATCH --output=snaq_%A_%a.out
#SBATCH --error=snaq_%A_%a.err
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=short
#SBATCH --array=0-5

t1=$(date +"%s")
module load julia/1.5.3 
echo "slurm task ID = $SLURM_ARRAY_TASK_ID used as hmax"
echo "start of SNaQ parallel runs on $(hostname)"
julia /home/rebecca.clement/90day_aphid/scripts/runSNaQmyzus.jl $SLURM_ARRAY_TASK_ID 30 > net$SLURM_ARRAY_TASK_ID_30runs.screenlog 2>&1
echo "end of SNaQ run ..."
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
