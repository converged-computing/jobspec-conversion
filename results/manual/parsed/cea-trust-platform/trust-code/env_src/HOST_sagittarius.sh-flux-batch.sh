#!/bin/bash
#FLUX: --job-name=expressive-despacito-2708
#FLUX: --urgency=16

define_modules_config()
{
   env=$TRUST_ROOT/env/machine.env
   module="slurm intel/compilers/2019.3.199 openmpi/intel/3.1.3 mkl/2019.3.199 hwloc" # openmpi/gcc bloque
   module="slurm" # Version gcc plus rapide en zone (et uniformite par rapport aux devs sur PC)
   #module="slurm gcc/6.5.0 openmpi/gcc-6.5.0/4.0.1 hwloc/2.7.1 texlive/gcc/2020" # Nouvelle version a tester
   module="slurm gcc/11.2.0 openmpi/gcc11.2.0/4.1.1 hwloc/2.7.1 texlive/gcc/2020" # Nouvelle version qui passe en //
   echo "# Module $module detected and loaded on $HOST."
   echo "module purge 1>/dev/null" >> $env
   echo "module load $module 1>/dev/null" >> $env
   # echo "TRUST_ATELIER_CMAKE=0 && export TRUST_ATELIER_CMAKE # To speedup Baltik build on beefgs file system" >> $env  
   . $env
   # Creation wrapper qstat -> squeue
   echo "#!/bin/bash
squeue" > $TRUST_ROOT/bin/qstat
   chmod +x $TRUST_ROOT/bin/qstat
}
define_soumission_batch()
{
   soumission=2 && [ "$prod" = 1 ] && soumission=1
   queue=compute && [ "$bigmem" = 1 ] && queue=compute && soumission=1
   cpu=30 && [ "$prod" = 1 ] && cpu=20160
   ntasks=20
   mpirun="srun -n \$SLURM_NTASKS"
   sub=SLURM
}
