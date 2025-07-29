#!/bin/bash
#SBATCH --job-name=snaq2_myzus
#SBATCH --output=snaq_%A_%a.out
#SBATCH --error=snaq_%A_%a.err
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --time=7-00:00:00
#SBATCH --partition=medium
#SBATCH --array=0-10

t1=$(date +"%s")
module load julia/1.5.3 
echo "slurm task ID = $SLURM_ARRAY_TASK_ID used as hmax"
echo "start of SNaQ parallel runs on $(hostname)"
julia --project="/home/rebecca.clement/.julia/project1/" /home/rebecca.clement/90day_aphid/aphids_github/scripts/runSNaQ2myzus.jl $SLURM_ARRAY_TASK_ID 30 > net$SLURM_ARRAY_TASK_ID_30runs.screenlog 2>&1
echo "end of SNaQ run ..."
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
