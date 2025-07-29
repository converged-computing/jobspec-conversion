#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/TUDelft-DataDrivenControl/SOWFA/exampleCases/other/Doekemeijer_RenewableEnergy2019/6turb_runs/opt/runscript.solve.zmq
