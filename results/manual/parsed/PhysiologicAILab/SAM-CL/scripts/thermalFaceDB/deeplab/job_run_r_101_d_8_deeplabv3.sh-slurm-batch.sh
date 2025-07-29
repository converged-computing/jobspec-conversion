#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/PhysiologicAILab/SAM-CL/scripts/thermalFaceDB/deeplab/job_run_r_101_d_8_deeplabv3.sh
