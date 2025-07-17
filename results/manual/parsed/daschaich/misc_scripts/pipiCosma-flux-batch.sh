#!/bin/bash
#FLUX: --job-name=lovable-sundae-0548
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'

if [ $# -lt 1 ]; then
  echo "Usage: $0 <config>"
  exit 1
fi
cfg=$1
L=24
Lattice="24.24.24.64"
path=`pwd`
tag=L${L}_l0.15_h0.15
N=1
per_node=8
per_task=16
MPIGrid="1.1.2.4"
time=08:00:00
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
module add intel_comp/2018
module add intel_mpi/2018
module add hdf5/1.12.0
tasks=`echo $N | awk -v each="$per_node" '{print($1*each)}'`
temp=submit.$cfg
echo "#!/bin/bash" > $temp
echo "#SBATCH -D ./" >> $temp
echo "#SBATCH --export=ALL" >>$temp
echo "#SBATCH -N $N" >> $temp
echo "#SBATCH --ntasks-per-node=$per_node" >> $temp
echo "#SBATCH --cpus-per-task=$per_task" >> $temp
echo "#SBATCH -p cosma8" >>$temp
echo "#SBATCH -A dp162" >>$temp
echo "#SBATCH --exclusive" >>$temp
echo "#SBATCH -t $time" >>$temp
echo "#SBATCH -J $tag.$cfg" >> $temp
echo "#SBATCH -o out.pipi.%j" >> $temp
echo "export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so" >> $temp
echo "module add intel_comp/2018" >> $temp
echo "module add intel_mpi/2018" >> $temp
echo "module add hdf5/1.12.0" >> $temp
bin=/cosma/home/durham/dc-scha3/bin/pipi_multiple_sources
echo "echo '=====================JOB DIAGNOTICS========================'" >> $temp
echo "date" >> $temp
echo "echo -n 'This machine is ';hostname" >> $temp
echo "echo -n 'My jobid is '; echo \$SLURM_JOBID" >> $temp
echo "echo 'My path is:' " >> $temp
echo "echo \$PATH" >> $temp
echo "echo 'My job info:'" >> $temp
echo "squeue -j \$SLURM_JOBID" >> $temp
echo "echo 'Machine info'" >> $temp
echo "sinfo -s" >> $temp
echo "echo '=====================JOB STARTING=========================='" >> $temp
latPrefix=$path/Configs/ckpoint_lat
lat=$latPrefix.$cfg
out=Out/pipi.t40.$cfg # TODO: Read in source time as input parameter
mes=mesons/wall_ll.t40.$cfg.h5
two=pipi/wall_llll.t40.$cfg.h5
if [ ! -e $lat ]; then
  echo "Error: lattice not found"
  echo "file: $lat"
  rm -f $temp
  exit 1
fi
if [ -e $out ]; then
  echo "Error: output file $out exists"
  rm -f $temp
  exit 1
fi
if [ -e $mes ]; then
  echo "Error: output file $mes exists"
  rm -f $temp
  exit 1
fi
if [ -e $two ]; then
  echo "Error: output file $two exists"
  rm -f $temp
  exit 1
fi
if [ ! -e base.xml ]; then
  echo "Error: base xml not found"
  rm -f $temp
  exit 1
fi
cp -f base.xml xml.t40.$cfg
cfgEnd=$((cfg+1))
sed -i "s/_CONFIG_START_/${cfg}/g" xml.t40.$cfg
sed -i "s/_CONFIG_END_/${cfgEnd}/g" xml.t40.$cfg
sed -i "s/_RUN_ID_/${tag}/g" xml.t40.$cfg
sed -i "s#_CONFIG_PREFIX_#${latPrefix}#g" xml.t40.$cfg
echo "echo \"Job pipi.$cfg started \"\`date\`\" jobid \$SLURM_JOBID\" >> $out" >> $temp
echo "echo \"=== Running MPI application on $cores cpus ===\" >> $out" >> $temp
echo "echo \"srun --mpi=pmi2 -n $tasks $bin xml.t40.$cfg --grid $Lattice --mpi $MPIGrid --threads $per_task --comms-concurrent --comms-overlap --shm 2048\" >> $out" >> $temp
echo "srun --mpi=pmi2 -n $tasks $bin xml.t40.$cfg --grid $Lattice --mpi $MPIGrid --threads $per_task --comms-concurrent --comms-overlap --shm 2048 >> $out" >> $temp
echo "mv -iv mesons/wall_ll.$cfg.h5 $mes" >> $temp
echo "mv -iv pipi/wall_llll.$cfg.h5 $two" >> $temp
echo "echo \"=== MPI application finished at \"\`date\`\" ===\" >> $out" >> $temp
echo "echo '========================ALL DONE==========================='" >> $temp
sbatch $temp
rm -f $temp
