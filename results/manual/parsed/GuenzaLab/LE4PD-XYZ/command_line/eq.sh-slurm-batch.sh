#!/bin/bash
#SBATCH --job-name=eq
#SBATCH --account=uoo104
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

BD=`cat BD.txt`
protname=`cat ${BD}/em/protname.txt`
GRO="${BD}/em/after_em_${protname}.gro"
module load openmpi/4.0.4
module load gromacs/2020.4
gmx_mpi grompp -v -f npt.mdp -c ${GRO} -o npt.tpr -p ${BD}/em/sys.top -r ${GRO} -maxwarn 5
mpirun -n $SLURM_NTASKS gmx_mpi mdrun -v -s npt.tpr -deffnm npt -ntomp 1
cd ${BD}
mkdir -v prod
cp -v ${BD}/prod.sh ${BD}/pro.mdp ${BD}/em/*.itp ${BD}/em/protname.txt ${BD}/BD.txt prod/
cd prod
rm -rfv runno
sbatch prod.sh
