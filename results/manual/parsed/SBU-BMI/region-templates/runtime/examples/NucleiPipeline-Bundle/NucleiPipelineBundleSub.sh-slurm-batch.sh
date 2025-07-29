#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SBU-BMI/region-templates/runtime/examples/NucleiPipeline-Bundle/NucleiPipelineBundleSub.sh
