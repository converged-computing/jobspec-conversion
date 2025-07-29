#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ninhleba/scPASU_pipeline/Scripts/Templates/3_peak_ref_cleanup/3e_identify_fragmented_peaks.lsf
