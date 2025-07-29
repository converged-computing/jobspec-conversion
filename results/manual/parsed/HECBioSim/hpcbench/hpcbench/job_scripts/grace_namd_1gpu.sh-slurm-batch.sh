#!/bin/bash
#FLUX: --job-name=$jobname
#FLUX: --queue=gh
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='/users/robertwelch/miniforge3/bin:£PATH'

num_gpus=0
module load cuda/12.3.2 gcc/12.2
export PATH="/users/robertwelch/miniforge3/bin:£PATH"
gpus=(£(seq -s , 0 £num_gpus  ))
hpcbench infolog sysinfo.json
hpcbench gpulog -p gpu.pid gpulog.json &
hpcbench cpulog -p cpu.pid "'namd3'" cpulog.json &
hpcbench syslog -p sys.pid -i 1 -s /sys/class/hwmon/hwmon1/device/power1_average:totalpower:0.000001 -s /sys/class/hwmon/hwmon2/device/power1_average:gracepower:0.000001 -s /sys/class/hwmon/hwmon3/device/power1_average:cpupower:0.000001 -s /sys/class/hwmon/hwmon4/device/power1_average:iopower:0.000001 -t "'Total Energy (J)'" -t "'Total Grace Energy (J)'" -t "'Total CPU Energy (J)'" -t "'Total IO Energy (J)'" -o power.json &
~/software/NAMD_3.0b6_Source/Linux-ARM64-g++/namd3 +idlepoll +p 72 +devices £gpus benchmark.in | tee namdlog.txt
kill £(< gpu.pid)
kill £(< cpu.pid)
kill £(< sys.pid)
hpcbench namdlog -a power.json namdlog.txt run.json
hpcbench slurmlog £0 slurm.json
hpcbench extra -e "'MD:GROMACS2024'" -e "'Machine:Grace Hopper Testbed'" -e "'comment:$comment'" meta.json
hpcbench namdenergy benchmark.log thermo.json
hpcbench collate -l sysinfo.json gpulog.json cpulog.json thermo.json power.json run.json slurm.json meta.json -o $benchout
rm benchmark.coor* benchmark.dcd benchmark.pdb benchmark.psf benchmark.vel.*
