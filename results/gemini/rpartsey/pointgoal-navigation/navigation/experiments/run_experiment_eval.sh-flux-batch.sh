#!/bin/bash
#FLUX --job-name=pointgoal_nav
#FLUX -N 1
#FLUX -n 1
#FLUX -c 10
#FLUX --gpus-per-task=1
# Note: The following line attempts to translate Slurm's --constraint=volta32gb.
# This requires 'volta32gb' to be a queryable node feature in Flux's resource database.
# The exact syntax might vary based on site-specific Flux configuration.
#FLUX --requires=node-feature:volta32gb
# Note: The following line attempts to transl