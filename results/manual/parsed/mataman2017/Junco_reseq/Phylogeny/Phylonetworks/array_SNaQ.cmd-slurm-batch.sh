#!/bin/bash
#SBATCH --job-name=runsnaq
#SBATCH --output=/projects/VONHOLDT/jsala/C_Phylo/E_Phylonetworks/OE/runsnaq_slurm%a.log
#SBATCH --error=/projects/VONHOLDT/jsala/C_Phylo/E_Phylonetworks/OE/runsnaq_slurm%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=32G
#SBATCH --time=2-12:00:00
#SBATCH --array=0-10

echo "slurm task ID = $SLURM_ARRAY_TASK_ID used as hmax"
echo "start of SNaQ parallel runs on $(hostname)"
/home/jg2334/download/julia-1.9.4/bin/julia --history-file=no -- runSNaQ.jl $SLURM_ARRAY_TASK_ID 30 > net$SLURM_ARRAY_TASK_ID_30runs.screenlog 2>&1
echo "end of SNaQ run ..."
