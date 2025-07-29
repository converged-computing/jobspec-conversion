#!/bin/bash
#SBATCH --job-name=ondemand/sys/myjobs/basic_namd_parallel
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:12:00
#SBATCH --exclusive

module load intel/19.0.5  
module load mvapich2/2.3.4
module load namd/2.13
cd $SLURM_SUBMIT_DIR
sbcast -p apoa1.namd $TMPDIR/apoa1.namd
sbcast -p par_all22_popc.xplor $TMPDIR/par_all22_popc.xplor
sbcast -p par_all22_prot_lipid.xplor $TMPDIR/par_all22_prot_lipid.xplor
sbcast -p apoa1.psf $TMPDIR/apoa1.psf
sbcast -p apoa1.pdb $TMPDIR/apoa1.pdb
cd $TMPDIR
namd2 apoa1.namd
