#!/bin/bash

# Flux directives translated from PBS:
# Original PBS: #PBS -l mem=126gb,nodes=1:ppn=16,walltime=96:00:00
#FLUX: -N 1                                      # Number of nodes
#FLUX: -n 1                                      # Number of tasks (this script itself is the main task)
#FLUX: -c 16                                     # CPUs per task (