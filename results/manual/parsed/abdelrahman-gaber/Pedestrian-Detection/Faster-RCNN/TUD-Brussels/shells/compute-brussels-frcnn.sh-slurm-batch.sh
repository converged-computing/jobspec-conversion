#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/abdelrahman-gaber/Pedestrian-Detection/Faster-RCNN/TUD-Brussels/shells/compute-brussels-frcnn.sh
