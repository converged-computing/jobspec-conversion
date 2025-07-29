#!/bin/bash
#SBATCH --job-name=utdNodesAll
#SBATCH --output=utdNodesAll.%j.out
#SBATCH --error=utdNodesAll.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-15

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "try utdNodesOptSolo3("$SLURM_ARRAY_TASK_ID"); catch; end; quit"
