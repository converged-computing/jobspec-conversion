#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jedbrown/sweet/archive/benchmarks_plane/rexi_tests_stfc/test_nxq/test.sh
