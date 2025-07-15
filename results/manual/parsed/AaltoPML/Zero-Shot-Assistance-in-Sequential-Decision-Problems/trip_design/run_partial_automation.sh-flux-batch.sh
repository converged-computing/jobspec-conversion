#!/bin/bash
#FLUX: --job-name=bumfuzzled-puppy-8448
#FLUX: -t=54000
#FLUX: --priority=16

module load julia
srun julia PartialAutomationExperiment.jl "basic_experiment/E0_automation_only_${SLURM_ARRAY_TASK_ID}.jld" basic_experiment/E0_basic_experiment.jld ${SLURM_ARRAY_TASK_ID}
