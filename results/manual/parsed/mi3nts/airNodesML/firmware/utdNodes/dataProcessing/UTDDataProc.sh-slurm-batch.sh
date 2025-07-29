#!/bin/bash
#SBATCH --job-name=utdNodesDataProcessing
#SBATCH --output=logs/utdNodesDataProcessing.%j.out
#SBATCH --error=logs/utdNodesDataProcessing.%j.err
#SBATCH --mail-user=lhw150030@utdallas.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-31

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "raw2MatHPC("$SLURM_ARRAY_TASK_ID")"
