#!/bin/bash
#SBATCH --job-name=utdNodesCalV2
#SBATCH --output=logs/utdNodesCalV2.%j.out
#SBATCH --error=logs/utdNodesCalV2.%j.err
#SBATCH --mail-user=lhw150030@utdallas.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-31

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "utdNodesV3("$SLURM_ARRAY_TASK_ID")"
