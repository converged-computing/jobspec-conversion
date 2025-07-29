#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/dftfeDevelopers/dftfe-benchmarks/performanceBenchmarks/DFTFEv1.0/Summit/GroundStateCalculations/CPUGPUSpeedup/BCCMoSuperCells/multikpt/6x6x6VacGPU/output/gpurunmpiopt.lsf
