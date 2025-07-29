#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/stevecassidy/cnn-for-voice-antispoofing/gadi-jobs/wideband768-job.sh
