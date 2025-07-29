#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AMReX-Astro/MAESTRO/Exec/SCIENCE/urca/wdconvect_urca-23/models/Run-1/Mconv-0.5_rhoc-4.5e9/Tc-3.0e8/grid-8192/sponge-tests/sponge-F/burn-F/titan.run
