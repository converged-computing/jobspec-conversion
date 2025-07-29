#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tfzhou/ProtoSeg/scripts/cityscapes/hrnet/job_run_h_48_d_4_proto.sh
