#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AMReX-Astro/MAESTRO/Exec/SCIENCE/urca/wdconvect_urca-23/models/Run-2/rhoc-3.5e9_Tc-3.0e8_Mconv-0.79/wdconvect/titan.run
