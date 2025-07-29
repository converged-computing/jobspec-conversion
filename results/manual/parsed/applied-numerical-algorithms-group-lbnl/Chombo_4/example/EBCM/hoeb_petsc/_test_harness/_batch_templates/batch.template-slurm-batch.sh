#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/applied-numerical-algorithms-group-lbnl/Chombo_4/example/EBCM/hoeb_petsc/_test_harness/_batch_templates/batch.template
