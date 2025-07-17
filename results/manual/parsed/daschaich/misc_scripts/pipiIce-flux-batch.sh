#!/bin/bash
#FLUX: --job-name=chunky-pastry-0075
#FLUX: --urgency=16

if [ $# -lt 1 ]; then
  echo "Usage: $0 <config>"
  exit 1
fi
cfg=$1
L=32
Lattice="32.32.32.64"
path=`pwd`
tag=L${L}_l0.015_h0.15
N=16
per_node=2
per_task=32
MPIGrid="2.2.2.4"
time=07:00:00
N=8
per_node=2
per_task=32
MPIGrid="1.2.2.4"
time=14:00:00
N=4
per_node=2
per_task=32
MPIGrid="1.1.2.4"
time=36:00:00
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/dc-scha3/dev/hdf5/install/lib
tasks=`echo $N | awk -v each="$per_node" '{print($1*each)}'`
temp=submit.$cfg
echo "#!/bin/bash" > $temp
echo "#SBATCH -p icelake" >> $temp
echo "#SBATCH -A dirac-dp162-CPU" >> $temp
echo "#SBATCH -N $N" >> $temp
echo "#SBATCH --ntasks-per-node=$per_node" >> $temp
echo "#SBATCH --cpus-per-task=$per_task" >> $temp
echo "#SBATCH -t $time" >> $temp
echo "#SBATCH -J $tag.$cfg" >> $temp
echo "#SBATCH -o out.pipi.%j" >> $temp
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/dc-scha3/dev/hdf5/install/lib" >> $temp
bin=/home/dc-scha3/bin/pipi_multiple_sources-Ice
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
out=Out/pipi.t56.$cfg # TODO: Read in source time as input parameter
mes=mesons/wall_ll.t56.$cfg.h5
two=pipi/wall_llll.t56.$cfg.h5
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
cp -f base.xml xml.t56.$cfg
cfgEnd=$((cfg+1))
sed -i "s/_CONFIG_START_/${cfg}/g" xml.t56.$cfg
sed -i "s/_CONFIG_END_/${cfgEnd}/g" xml.t56.$cfg
sed -i "s/_RUN_ID_/${tag}/g" xml.t56.$cfg
sed -i "s#_CONFIG_PREFIX_#${latPrefix}#g" xml.t56.$cfg
echo "echo \"Job pipi.$cfg started \"\`date\`\" jobid \$SLURM_JOBID\" >> $out" >> $temp
echo "echo \"=== Running MPI application on $cores cpus ===\" >> $out" >> $temp
echo "echo \"srun --mpi=pmi2 -n $tasks $bin xml.t56.$cfg --grid $Lattice --mpi $MPIGrid --threads $per_task --comms-concurrent --comms-overlap --shm 2048\" >> $out" >> $temp
echo "srun --mpi=pmi2 -n $tasks $bin xml.t56.$cfg --grid $Lattice --mpi $MPIGrid --threads $per_task --comms-concurrent --comms-overlap --shm 2048 >> $out" >> $temp
echo "mv -iv mesons/wall_ll.$cfg.h5 $mes" >> $temp
echo "mv -iv pipi/wall_llll.$cfg.h5 $two" >> $temp
echo "echo \"=== MPI application finished at \"\`date\`\" ===\" >> $out" >> $temp
echo "echo '========================ALL DONE==========================='" >> $temp
sbatch $temp
rm -f $temp
