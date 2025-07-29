#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/TUDelft-DataDrivenControl/SOWFA/exampleCases/example.13.piso.DTU10MW.ALMAdvanced.refinements.zmqSSC/runscript.solve.piso.zmq
