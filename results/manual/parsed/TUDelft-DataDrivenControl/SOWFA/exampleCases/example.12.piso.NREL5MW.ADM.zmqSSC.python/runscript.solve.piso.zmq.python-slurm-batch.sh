#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/TUDelft-DataDrivenControl/SOWFA/exampleCases/example.12.piso.NREL5MW.ADM.zmqSSC.python/runscript.solve.piso.zmq.python
