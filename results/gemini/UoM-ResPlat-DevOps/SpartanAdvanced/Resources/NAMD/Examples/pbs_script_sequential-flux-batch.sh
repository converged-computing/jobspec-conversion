#!/bin/bash
# flux launching script
# -to run multiple sequential namd jobs after an initial minimization step

# Flux Directives
#FLUX: -N 8
#FLUX: -t 24h
#FLUX: --job-name=_example_sequential_production_
#FLUX: --output=JobLog/flux_%j_example_sequential_production.out
#FLUX: --error=Job