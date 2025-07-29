#!/bin/bash
#SBATCH --job-name=$jobname
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:$num_gpus
#SBATCH --time=00:50:00

export PATH='/jmain02/home/J2AD004/sxk40/rxw76-sxk40/anaconda3/bin:£PATH'

module load namd/3.0-alpha7
export PATH="/jmain02/home/J2AD004/sxk40/rxw76-sxk40/anaconda3/bin:£PATH"
gpus=(£(seq -s , 0 $num_gpus  ))
hpcbench infolog sysinfo.json
hpcbench gpulog gpulog.json & gpuid=£!
hpcbench cpulog "'namd3'" cpulog.json & cpuid=£!
namd3 +idlepoll +p 4 +devices £gpus $benchmarkinfile | tee namdlog.txt
kill £gpuid
kill £cpuid
hpcbench sacct £SLURM_JOB_ID accounting.json
hpcbench namdlog namdlog.txt run.json
hpcbench slurmlog £0 slurm.json
hpcbench extra -e "'Comment:$comment'" -e "'Machine:$machine'" meta.json
hpcbench namdenergy benchmark.log thermo.json
hpcbench collate -l sysinfo.json gpulog.json cpulog.json thermo.json accounting.json run.json slurm.json meta.json -o $benchout
rm benchmark.coor* benchmark.dcd benchmark.pdb benchmark.psf benchmark.vel.*
