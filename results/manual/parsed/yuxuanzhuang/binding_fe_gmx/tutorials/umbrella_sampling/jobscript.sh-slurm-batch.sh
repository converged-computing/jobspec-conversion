#!/bin/bash
#SBATCH --job-name=us_epj
#SBATCH --output=job-%j.out
#SBATCH --error=job-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=1-00:00:00
#SBATCH --partition=lindahl1,lindahl2,lindahl3,lindahl4

module unload gromacs
module switch gromacs/2023 gromacs=gmx_mpi
module switch cuda/11.8
module unload openmpi
module load openmpi
cd us
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{0..3} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{4..7} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{8..11} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{12..15} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{16..19} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{20..23} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{24..27} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{28..31} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{32..35} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
srun -n 4 gmx_mpi mdrun -deffnm pulling_md -cpi pulling_md -multidir run_{36..39} -pme gpu -bonded gpu -nb gpu -px pullx -pf pullf -maxh 23
