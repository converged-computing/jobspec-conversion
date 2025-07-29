#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JaneliaSciComp/vaa3d_tools/bigneuron_ported/bench_testing/lbnl/script_non_MPI/gen_bench_job_aprun_scripts.sh
