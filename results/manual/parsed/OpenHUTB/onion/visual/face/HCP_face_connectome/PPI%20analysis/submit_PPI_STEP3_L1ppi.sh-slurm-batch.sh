#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/OpenHUTB/onion/visual/face/HCP_face_connectome/PPI%20analysis/submit_PPI_STEP3_L1ppi.sh
