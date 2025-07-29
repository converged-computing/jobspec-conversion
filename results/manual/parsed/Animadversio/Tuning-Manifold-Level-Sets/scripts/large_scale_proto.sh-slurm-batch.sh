#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Animadversio/Tuning-Manifold-Level-Sets/scripts/large_scale_proto.sh
