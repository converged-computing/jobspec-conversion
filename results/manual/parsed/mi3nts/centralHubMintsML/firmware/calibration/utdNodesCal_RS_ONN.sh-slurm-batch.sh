#!/bin/bash
#SBATCH --job-name=utdNodesCalONN_01
#SBATCH --output=logs/utdNodesCalONN_01.%j.out
#SBATCH --error=logs/utdNodesCalONN_01.%j.err
#SBATCH --mail-user=lhw150030@utdallas.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-15

echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "utdNodesCal_RS_ONN_01("$SLURM_ARRAY_TASK_ID")"
