#!/bin/bash
#SBATCH --job-name={job_name}
#SBATCH --account=TG-MCB090163
#SBATCH --output=logs/output.txt
#SBATCH --error=logs/error.txt
#SBATCH --mail-user=yingyouma@brandeis.edu
#SBATCH --mail-type=end
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=249208M
#SBATCH --time=2-00:00:00
#SBATCH --partition=compute
#SBATCH --constraint=ntasks-per-node=128

module load cpu/0.17.3b
module load gcc/10.2.0/npcyll4
module load openmpi/4.1.1
if [ ! -f "atoms.txt" ] || [ $(ls -1 restart/ | wc -l) -eq 0 ];
then
    {create_poly_cmd}
fi
srun -n $SLURM_NTASKS /home/yingyou/lammps/build/lmp -in {lammps_script}
