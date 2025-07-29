#!/bin/bash
#SBATCH --job-name=utdNodesHistoric
#SBATCH --output=logs/utdNodesHistoric.%j.out
#SBATCH --error=logs/utdNodesHistoric.%j.err
#SBATCH --mail-user=lhw150030@utdallas.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --array=1-15

ml load matlab
echo Running calibration scripts for UTD Node: "$SLURM_ARRAY_TASK_ID"
echo Running on host: `hostname`
matlab -nodesktop -nodisplay -nosplash -r "liveRun2021Daily("$SLURM_ARRAY_TASK_ID",'mintsDefinitions.yaml','WSPre','predictrnn')"
