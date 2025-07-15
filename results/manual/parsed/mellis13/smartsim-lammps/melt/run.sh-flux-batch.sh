#!/bin/bash
#FLUX: --job-name=SS-LAMMPS
#FLUX: -N=10
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --priority=16

export SMARTSIM_LOG_LEVEL='debug'

launcher=slurm   # launcher for the run (slurm or cobalt)
simnodes=8       # number of nodes for LAMMPS (mind resources listed above)
simppn=48        # procs per node for LAMMPS
simsteps=10000   # number of steps for LAMMPS
simscale=1       # scale factor for LAMMPS (max = 16)
dbnodes=1        # number of DB nodes (if 3 or greater, you must change cluster flag in analysis script)
dbport=6780      # port for the DB
vis_workers=48   # number of workers to pull data for the visualization (max = nproc on single node)
module unload atp
export SMARTSIM_LOG_LEVEL=debug
python run-melt.py --launcher=$launcher --sim_nodes=$simnodes --sim_ppn=$simppn --sim_steps=$simsteps --sim_scale=$simscale \
--db_nodes=$dbnodes --db_port=$dbport --vis_workers=$vis_workers --save
