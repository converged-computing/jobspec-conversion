#!/bin/bash
#FLUX: --job-name=fat-poodle-1108
#FLUX: --urgency=16

Help(){ # Display Help
echo "Running Simulation."
echo
echo "Syntax: run.sh [-a apps | -b barrier | -c chiplet_width | -d datasets | -e proxy_width | -f force_proxy_ratio | -g large_queue | -j write_thru | -k board_width | -l ruche | -m grid_conf | -n name | -o NOC | -p dry_run | -q queue_mode | -r assert_mode | -s machine_to_run | -t max_threads | -u noc_conf | -v verbose | -w SRAM-per-tile (KiBs) | -x num_phy_nocs | -y dcache | -z proxy_routing]"
echo "options:"
echo "a     Application [0:SSSP; 1:PAGE; 2:BFS; 3:WCC; 4:SPMV, 5:Histogram, 6: FFT, 8:SPMM]"
echo "b     Barrier Mode [0:no barrier, 1:global barrier, 2:barrier merge reduction tree]"
echo "c     Chiplet width"
echo "d     Datasets to run [Kron16..., amazon-2003 ego-Twitter liveJournal wikipedia]"
echo "e     Proxy width"
echo "f     Force proxy ratio"
echo "g     Large queue"
echo "j     Write-propagation"
echo "k     Node Board width [Default: same as grid size]"
echo "l     Ruche Skip-tile for monolithic, or inter-die channels for multi-chiplet systems"
echo "m     Grid size [Powers of 2]"
echo "n     Name of the experiment."
echo "o     NoC type [0:mesh, 1:torus]"
echo "p     Dry run (no simulation, only print configuration) [Default 0]"
echo "q     Queue priority mode [Default 0:dalorex, 1:time-sorted, 2:round-robin]"
echo "r     Assert mode on: activates the runtime assertion checks (lower speed), only run this if suspecting programming error. This mode also has more debug output"
echo "s     If running on the local machine, set to 1. If running on a slurm local_run, set to 0."
echo "t     Max number of threads"
echo "u     NoC width configuration [0, 1, 2, 3] (see run.sh for details)"
echo "v     Verbose mode: If activated (1), then it prints the current thread status (processed edges, nodes and idle time) at each sample time. A value of (2) gives inter router queue output too."
echo "w     SRAM-per-tile (KiBs)"
echo "x     Num Physical NoCs"
echo "y     Configuration mode of data cache and prefetching"
echo "z     Proxy routing"
echo
}
function log2 {
    local x=0
    for (( y=$1-1 ; $y > 0; y >>= 1 )) ; do
        let x=$x+1
    done
    echo $x
}
bin="FF"
verbose=0
assert_mode=0
folder="sim_logs"
sbatch_folder="sim_sbatch"
max_threads=16
local_run=0
let torus=1
ruche=99
let phy_nocs=1 #default 1
let noc_conf=2
let loop_chunk=64
let queue_prio=0
let powers_sample_time=0
let dry_run=0
let proxy_w=0
let chiplet_w=0
let board_w=0
let sram_memory=256*512 # 512 KiB
let dcache=0
let force_proxy_ratio=0
grid_x=8
functional=1
proxy_routing=4
write_thru=99
barrier=99
large_queue=0
steal=0
while getopts ":hs:n:a:d:m:b:t:r:o:x:p:q:v:f:e:c:k:w:y:g:i:j:u:l:z:" flag
do
  case "${flag}" in
    a) apps=${OPTARG};;
    b) barrier=${OPTARG};;
    c) chiplet_w=${OPTARG};;
    d) datasets=${OPTARG};;
    e) proxy_w=${OPTARG};;
    f) force_proxy_ratio=${OPTARG};;
    g) large_queue=${OPTARG};;
    h) Help; exit;;
    # i) steal=${OPTARG};;
    j) write_thru=${OPTARG};;
    k) board_w=${OPTARG};;
    l) ruche=${OPTARG};;
    m) grid_x=${OPTARG};;
    n) bin=${OPTARG};;
    o) torus=${OPTARG};;
    p) dry_run=${OPTARG};;
    q) queue_prio=${OPTARG};;
    r) assert_mode=${OPTARG};;
    s) local_run=${OPTARG};;
    t) max_threads=${OPTARG};;
    u) noc_conf=${OPTARG};;
    v) verbose=${OPTARG};;
    w) sram_memory=${OPTARG};;
    x) phy_nocs=${OPTARG};;
    y) dcache=${OPTARG};;
    z) proxy_routing=${OPTARG};;
    \?) echo "Error: Invalid option"; exit;;
  esac
done
let log2grid_x=$(log2 $grid_x)
run_batch(){
  echo \#APP=$a
  echo \#DATASET=$d
  echo \#MESH=$grid_x-x-$grid_x
  d_sub=${d:0:1}
  d_sub2=${d:4:6}
  bin_name="${bin}a${a}g${grid_x}-${d_sub}${d_sub2}.run"
  echo $bin_name
  barrier_post=$barrier
  binary="bin/$bin_name"
  if [ $barrier_post -eq 99 ]; then # If barrier not defined in the options, set it based on the app
    if [ $a -eq 1 ] || [ $a -eq 10 ]; then
      barrier_post=1
    else
      barrier_post=0
    fi
  fi
  write_thru_post=$write_thru
  # 1: Write Thru, 0: Write Back
  # If variable not set in the options, give default value for different apps!! If set, then use that value!
  if [ $write_thru_post -eq 99 ]; then
    if [ $a -eq 1 ] || [ $a -eq 4 ] || [ $a -eq 5 ] || [ $a -eq 7 ] || [ $a -eq 8 ]; then
      #Apps without frontier or with barrier, use write back policy
      write_thru_post=0
    else # Apps: 0 2 3, i.e., SSSP, BFS, WCC, use the write thru policy
      write_thru_post=1
    fi
  fi
  if [ $steal -eq 1 ]; then
    let steal_w=4
  else
    let steal_w=1
  fi
  # Default value for $chiplet_w is $grid_x
  if [ $chiplet_w -eq 0 ]; then
    chiplet_w=$grid_x
  fi
  let chiplet_h=$chiplet_w
  # Default value for $proxy_w is $grid_x
  if [ $proxy_w -eq 0 ]; then
    proxy_w=$grid_x
  fi
  # If no proxy, we make sure the proxy routing is off!
  if [ $proxy_w -eq $grid_x ]; then 
    proxy_routing=0
  fi
  threads=1 # Round down to the nearest power of 2
  while [ $((threads * 2)) -le $max_threads ]; do
    threads=$((threads * 2))
  done
  if [[ $grid_x -lt $threads ]]; then
    threads=$grid_x*2
  fi
  echo \#MAX_THREADS=$max_threads
  echo \#SIM_THREADS=$threads
  options=""
  if [ $phy_nocs -gt 1 ]; then
    options="-DPHY_NOCS=$phy_nocs"
  fi
  # Macros not actively used: -DSTEAL_W=$steal_w -DSHUFFLE=$shuffle -DQUEUE_PRIO=$queue_prio 
  options="-DMAX_THREADS=$threads -DASSERT_MODE=$assert_mode -DPRINT=$verbose -DDCACHE=$dcache -DSRAM_SIZE=$sram_memory -DGLOBAL_BARRIER=$barrier_post -DTORUS=$torus -DGRID_X_LOG2=$log2grid_x -DAPP=$a -DDIE_W=$chiplet_w -DDIE_H=$chiplet_h -DPROXY_W=$proxy_w -DTEST_QUEUES=$large_queue -DWRITE_THROUGH=$write_thru_post -DNOC_CONF=$noc_conf -DLOOP_CHUNK=$loop_chunk -DPROXY_ROUTING=$proxy_routing -DFUNC=$functional $options"
  if [ $force_proxy_ratio -gt 0 ]; then
    options="$options -DFORCE_PROXY_RATIO=$force_proxy_ratio"
  fi
  # Only set ruche if it is not the default value
  if [ $ruche -lt 99 ]; then
    options="$options -DRUCHE_X=$ruche"
  fi
  # Default value for $board_w is $grid_x
  if [ $board_w -gt 0 ]; then
    options="$options -DBOARD_W=$board_w"
  fi
  compiler=${CXX:-g++} # It has been tested with clang++ g++ or icpx (Intel CPUs)
  par_lib="-lpthread" #Alternatively could use OpenMP by setting: par_lib="-fopenmp -DUSE_OMP=1"
  compiler_args=""; target=""
  cluster=0  # 0:any, 1: intel-cascade-64, 2:intel-icelake-32,  3:amd
  if [ $local_run -eq 0 ]; then
    if [ $grid_x -gt 256 ] || [ $max_threads -gt 48 ]; then
      cluster=1
    else
      cluster=2
    fi
    if [ $cluster -eq 1 ]; then
      target="cascade"; compiler_args=" -march=cascadelake -mtune=cascadelake"
    elif [ $cluster -eq 2 ]; then
      target="icelake"; compiler_args=" -march=$target-server -mtune=$target-server"
    elif [ $cluster -eq 3 ]; then
      compiler_args=" -march=znver1 -mtune=znver1"
      target="rome"
    fi
  fi
  compile="$compiler src/main.cpp $par_lib ${compiler_args} -o $binary $options -O3 -std=c++11"
  echo $compile
  $compile
  output_file="DATA-$d--$grid_x-X-$grid_x--B$bin-A$a.log"
  result_file="RES-$d--$grid_x-X-$grid_x--B$bin-A$a.log"
  echo $output_file
  echo $result_file
  dataset_folder="datasets"
  # check if local_run > 0
  if [ $local_run -gt 2 ]; then
    echo "Error: local_run must be 0, 1 or 2"
  elif [ $local_run -gt 0 ]; then
    cmd="$binary $dataset_folder/$d/ > $folder/$output_file"
    echo $cmd; echo
    #check if local_run is 1 or 2
    if [ $local_run -eq 1 ]; then
      bin/$bin_name $dataset_folder/$d/ $bin $dry_run > $folder/DATA-$d--$grid_x-X-$grid_x--B$bin-A$a.log &
    else
      bin/$bin_name $dataset_folder/$d/ $bin $dry_run output.txt > $folder/DATA-$d--$grid_x-X-$grid_x--B$bin-A$a.log
    fi
  else # cluster (local_run=0)
    hours=24
    total_mem=512
    if [ $grid_x -gt 512 ]; then
      hours=144 # 144
      total_mem=2048
    elif [ $grid_x -gt 256 ]; then
      hours=72
      total_mem=1024
    elif [ $grid_x -gt 128 ] || ([ $grid_x -gt 64 ] && [ $a -eq 1 ]); then
      hours=72
      total_mem=512
    fi
    slurm_file="SLURM-$d--$grid_x-X-$grid_x--B$bin-A$a.log"
    echo "#!/bin/bash"                        > batch.sh
    echo "#SBATCH --time=$hours:00:00"           >> batch.sh
    echo "#SBATCH --output=$sbatch_folder/$slurm_file" >> batch.sh
    echo "#SBATCH --nodes=1"               >> batch.sh
    echo "#SBATCH --ntasks=1"              >> batch.sh
    echo "#SBATCH --cpus-per-task=$max_threads"   >> batch.sh
    echo "#SBATCH --job-name=A$a-G$grid_x-$d-B$bin" >> batch.sh
    if [ $cluster -gt 0 ]; then
      echo "#SBATCH --constraint=$target  "   >> batch.sh
      if [ $cluster -gt 1 ]; then
          echo "#SBATCH --gres=gpu:a100:0" >> batch.sh
          echo "#SBATCH --mem-per-cpu=16G" >> batch.sh
      else # cluster==1
          echo "#SBATCH --mem=${total_mem}G" >> batch.sh
      fi
    fi
    #echo "#SBATCH --mail-type=begin"       >> batch.sh        # send email when job begins
    #echo "#SBATCH --mail-type=end"          >> batch.sh        # send email when job ends
    #echo "module load gcc-toolset/10"       >> batch.sh
    cmd="srun ./$binary $PWD/$dataset_folder/$d/ $bin $dry_run > $folder/$output_file"
    echo $cmd; echo $cmd >> batch.sh; sbatch batch.sh;
    squeue -u `whoami` --format="%.18i %.9P %.50j %.8u %.2t %.10M %.6D %R"
  fi
}
echo "apps=$apps"
echo "datasets=$datasets"
for d in $datasets
do
  for a in $apps
  do
    echo "RUNNING $a $d"
    run_batch
  done
done
