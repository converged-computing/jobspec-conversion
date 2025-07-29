#!/bin/bash
#FLUX: --job-name=jupyter-notebook
#FLUX: --queue=brown,red
#FLUX: -t=21600
#FLUX: --urgency=16

XDG_RUNTIME_DIR=""
slurmctld_port=$(grep "^SlurmctldPort" /etc/slurm/slurm.conf | awk '{print $2}')
slurmd_port=$(grep "^SlurmdPort" /etc/slurm/slurm.conf | awk '{print $2}')
port=$(shuf -i8000-9999 -n1)
while netstat -atn | grep -q ":$port "; do
    # Generate a new random port number if the current one is already in use
    port=$(shuf -i8000-9999 -n1)
done
node=$(hostname -s)
user=$(whoami)
cluster=$(hostname -f | awk -F"." '{print $2}')
echo -e "
MacOS or linux terminal command to create your ssh tunnel
ssh -N -L ${port}:${node}:${port} ${user}@hpc.itu.dk
Windows MobaXterm info
Forwarded port: ${port}
Remote server: ${node}
Remote port: ${port}
SSH server: hpc.itu.dk
SSH login: $user
SSH port: 22
Use a Browser on your local machine to go to:
localhost:${port}  (prefix w/ https:// if using password)
"
module --ignore-cache load singularity/3.4.1
module --ignore-cache load CUDA/11.1.1-GCC-10.2.0
singularity exec --nv container.sif jupyter lab --no-browser --port=${port} --ip=0.0.0.0
