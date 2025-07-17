#!/bin/bash
#FLUX: --job-name=hairy-kitty-7111
#FLUX: -t=54000
#FLUX: --urgency=16

module load julia
srun julia PartialAutomationExperiment.jl "basic_experiment/E0_automation_only_${SLURM_ARRAY_TASK_ID}.jld" basic_experiment/E0_basic_experiment.jld ${SLURM_ARRAY_TASK_ID}
