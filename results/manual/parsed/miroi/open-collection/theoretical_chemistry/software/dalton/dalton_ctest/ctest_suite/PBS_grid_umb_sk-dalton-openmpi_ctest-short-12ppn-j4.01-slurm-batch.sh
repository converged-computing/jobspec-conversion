#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/miroi/open-collection/theoretical_chemistry/software/dalton/dalton_ctest/ctest_suite/PBS_grid_umb_sk-dalton-openmpi_ctest-short-12ppn-j4.01
