#!/bin/bash
#FLUX: --job-name=$jobname
#FLUX: -n=4
#FLUX: --queue=$partition
#FLUX: -t=7200
#FLUX: --urgency=16

export PATH='/jmain02/home/J2AD004/sxk40/rxw76-sxk40/.local/bin:£PATH'

export PATH="/jmain02/home/J2AD004/sxk40/rxw76-sxk40/.local/bin:£PATH"
module load cuda/11.1-gcc-9.1.0
module load gcc/9.1.0
hpcbench infolog sysinfo.json
hpcbench gpulog gpulog.json & gpuid=£!
hpcbench cpulog "'lmp'" cpulog.json & cpuid=£!
mpirun -np 4 lmp -sf gpu -pk gpu 1 -in $benchmarkinfile
kill £gpuid
kill £cpuid
hpcbench sacct £SLURM_JOB_ID accounting.json
hpcbench lmplog log.lammps run.json
hpcbench slurmlog £0 slurm.json
hpcbench extra -e "'Comment:$comment'" -e "'Machine:$machine'" meta.json
hpcbench collate -l sysinfo.json gpulog.json cpulog.json thermo.json accounting.json run.json slurm.json meta.json -o $benchout
rm restart.* benchmark.dcd
