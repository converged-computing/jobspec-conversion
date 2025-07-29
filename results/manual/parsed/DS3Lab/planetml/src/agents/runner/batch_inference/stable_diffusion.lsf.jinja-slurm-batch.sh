#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DS3Lab/planetml/src/agents/runner/batch_inference/stable_diffusion.lsf.jinja
