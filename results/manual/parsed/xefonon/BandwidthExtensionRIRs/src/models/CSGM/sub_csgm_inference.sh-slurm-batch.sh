#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/xefonon/BandwidthExtensionRIRs/src/models/CSGM/sub_csgm_inference.sh
