#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kotatsumuri/2023GraduationResearch/QD-FFT-OMP-GPU/batch/StockhamGPUBenchFFTSpeed.sh
