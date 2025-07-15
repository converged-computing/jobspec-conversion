#!/bin/bash
#FLUX: --job-name=Hypersolver
#FLUX: -c=8
#FLUX: --queue=batch
#FLUX: -t=223200
#FLUX: --urgency=16

srun singularity run -B /user/share/projects:/user/share/projects --nv hyperverlet.sif python3 -m hyperverlet.main --config-path configurations/integrator_experiments/three_body_spring_mass/hyperverlet.json plot
srun singularity run -B /user/share/projects:/user/share/projects --nv hyperverlet.sif python3 -m hyperverlet.main --config-path configurations/integrator_experiments/three_body_spring_mass/velocityverlet.json plot
