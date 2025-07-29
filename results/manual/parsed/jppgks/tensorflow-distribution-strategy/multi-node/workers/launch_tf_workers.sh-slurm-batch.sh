#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jppgks/tensorflow-distribution-strategy/multi-node/workers/launch_tf_workers.sh
