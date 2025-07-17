#!/bin/bash
#FLUX: --job-name={job_name}
#FLUX: -N=2
#FLUX: --queue=compute
#FLUX: -t=172800
#FLUX: --urgency=16

module load cpu/0.17.3b
module load gcc/10.2.0/npcyll4
module load openmpi/4.1.1
if [ ! -f "atoms.txt" ] || [ $(ls -1 restart/ | wc -l) -eq 0 ];
then
    {create_poly_cmd}
fi
srun -n $SLURM_NTASKS /home/yingyou/lammps/build/lmp -in {lammps_script}
