#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/djangraw/FelixScripts/PRJ08_CognitiveStateDetection/Scripts/MATLAB_SSB_CognitiveStateDetection.m
