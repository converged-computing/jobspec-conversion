#!/bin/bash
#SBATCH --job-name=Hypersolver
#SBATCH --mail-user=MI1012F21@cs.aau.dk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=2-14:00:00
#SBATCH --qos=allgpus

srun singularity run -B /user/share/projects:/user/share/projects --nv hyperverlet.sif python3 -m hyperverlet.main --config-path configurations/integrator_experiments/three_body_spring_mass/hyperverlet.json plot
srun singularity run -B /user/share/projects:/user/share/projects --nv hyperverlet.sif python3 -m hyperverlet.main --config-path configurations/integrator_experiments/three_body_spring_mass/velocityverlet.json plot
