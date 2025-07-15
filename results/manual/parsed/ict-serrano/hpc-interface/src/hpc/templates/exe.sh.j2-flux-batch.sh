#!/bin/bash
#FLUX: --job-name=chocolate-nalgas-1869
#FLUX: --urgency=16

{# Template parameters - schema for the template is in openapi spec
params = {
    # kernel
    icase: -1..3
    # Select a group of kernels, belonging to a use case 
    ideko_kernel: 0..1
    inbestme_kernel: 0..1
    # Pack the output into CSV
    csv_output: 0..1
    # signal processing - if icase == 1
    filter:
        kalman: 0..1 
        fft: 0..1
        min_max: 0..1
        savitzky_golay: 0..1
        black_scholes: 0..1
        wavelet: 0..1
    # kalman filter config
    kalman:
        r: 10
    # fft filter config
    fft: {}
    # min max filter config 
    min_max: {}
    # savitzky golay filter config
    savitzky_golay: {}
    # black scholes filter config
    black_scholes: {}
    # wavelet filter config
    wavelet: {}
    # kmean config
    kmean:
        cluster_number: 2
        epsilon_criteria: 0.00001
    # knn config
    knn:
        cluster_number: 2
        k_nearest_neighbor: 7
    # benchmark state
    benchmark_state: 0
    # parallelization parameters
    num_mpi_procs: 4
    num_thread: 1
    # approximation computing techniques
    perforation_stride: 1
    # transprecision techniques
    precision_scenario: 1
    # hardware config
    num_numa: 8
    num_core_numa: 16
    # workspace
    root_dir: "${HOME}/serrano"
    workspace: "/data"
    profiling_workspace: "/profile"
    # data path
    read_input_data: "/Init_Data/raw_data_input_fft/acceleration_cycle_260.csv"
    input_data_double: "/Input_Data/Double_Data_Type/signalFilter"
    input_data_float: "/Input_Data/Float_Data_Type/signalFilter"
    inference_knn_path: "/Init_Data/inference_data_position/"
    clustering_label_path: "/Output_Data/KMean/KMean_cluster.csv"
    # exe path
    exe: "build/SERRANO"
}
icase={{ params.icase }}
IDEKO_Kernel={{ params.ideko_kernel }}
INBestMe_Kernel={{ params.inbestme_kernel }}
packing2CSVformat={{ params.csv_output }}
BenchmarkState={{ params.benchmark_state }}
Kalman_Filter={{ params.filter.kalman }}
FFT_Filter={{ params.filter.fft }}
MinMax_Transform={{ params.filter.min_max }}
SavitzkyGolay_Transform={{ params.filter.savitzky_golay }}
BlackScholes={{ params.filter.black_scholes }}
WaveletFiltering={{ params.filter.wavelet }}
R={{ params.kalman.r }}
K_nearest_neighbor={{ params.knn.k_nearest_neighbor }}
Cluster_number_KNN={{ params.knn.cluster_number }}
number_cluster_kmean={{ params.kmean.cluster_number }}
epsilon_criteria={{ "%.8f" | format(params.kmean.epsilon_criteria) }}
num_MPI_Procs={{ params.num_mpi_procs }}
num_Thread={{ params.num_thread }}
perforation_stride={{ params.perforation_stride }}
precision_scenario={{ params.precision_scenario }}
num_numa={{ params.num_numa }}
num_core_numa={{ params.num_core_numa }}
root_dir={{ params.root_dir }}
workspace=${root_dir}{{ params.workspace }}
profiling_workspace=${root_dir}{{ params.profiling_workspace }}
readInputData={{ params.read_input_data }}
inputDataDouble={{ params.input_data_double }}
inputDataFloat={{ params.input_data_float }}
inferenceKNNPath={{ params.inference_knn_path }}
clustering_label={{ params.clustering_label_path }}
EXE={{ params.exe }}
cd ${root_dir}
module load tools/cmake/3.21.5
module load compiler/gcc/11.2.0
module load mpi/openmpi/4.1.1-gcc-11.2.0
module load numlib/fftw/3.3.10-openmpi-4.1.1-gcc-11.2.0
mpirun \
    --mca pml ob1 --mca btl tcp,self \
    --bind-to core \
    -n $num_MPI_Procs \
    $EXE \
    -1 $BenchmarkState \
    $Kalman_Filter $FFT_Filter \
    $BlackScholes $SavitzkyGolay_Transform \
    $R \
    $K_nearest_neighbor $Cluster_number_KNN \
    $number_cluster_kmean $epsilon_criteria \
    $perforation_stride $precision_scenario \
    $num_numa $num_core_numa \
    $num_Thread \
    $workspace $profiling_workspace \
    $readInputData $inputDataDouble $inputDataFloat $inferenceKNNPath \
    $IDEKO_Kernel $INBestMe_Kernel 0 \
    $WaveletFiltering $clustering_label
mpirun \
    --mca pml ob1 --mca btl tcp,self \
    --bind-to core \
    -n $num_MPI_Procs \
    $EXE \
    0 $BenchmarkState \
    $Kalman_Filter $FFT_Filter \
    $BlackScholes $SavitzkyGolay_Transform \
    $R \
    $K_nearest_neighbor $Cluster_number_KNN \
    $number_cluster_kmean $epsilon_criteria \
    $perforation_stride $precision_scenario \
    $num_numa $num_core_numa \
    $num_Thread \
    $workspace $profiling_workspace \
    $readInputData $inputDataDouble $inputDataFloat $inferenceKNNPath \
    $IDEKO_Kernel $INBestMe_Kernel 0 \
    $WaveletFiltering $clustering_label
mpirun \
    --mca pml ob1 --mca btl tcp,self \
    --bind-to core \
    -n $num_MPI_Procs \
    $EXE \
    $icase $BenchmarkState \
    $Kalman_Filter $FFT_Filter \
    $BlackScholes $SavitzkyGolay_Transform \
    $R \
    $K_nearest_neighbor $Cluster_number_KNN \
    $number_cluster_kmean $epsilon_criteria \
    $perforation_stride $precision_scenario \
    $num_numa $num_core_numa \
    $num_Thread \
    $workspace $profiling_workspace \
    $readInputData $inputDataDouble $inputDataFloat $inferenceKNNPath \
    $IDEKO_Kernel $INBestMe_Kernel 0 \
    $WaveletFiltering $clustering_label
{% if params.csv_output %}
mpirun \
    --mca pml ob1 --mca btl tcp,self \
    --bind-to core \
    -n $num_MPI_Procs \
    $EXE \
    0 $BenchmarkState \
    $Kalman_Filter $FFT_Filter \
    $BlackScholes $SavitzkyGolay_Transform \
    $R \
    $K_nearest_neighbor $Cluster_number_KNN \
    $number_cluster_kmean $epsilon_criteria \
    $perforation_stride $precision_scenario \
    $num_numa $num_core_numa \
    $num_Thread \
    $workspace $profiling_workspace \
    $readInputData $inputDataDouble $inputDataFloat $inferenceKNNPath \
    $IDEKO_Kernel $INBestMe_Kernel 1 \
    $WaveletFiltering $clustering_label
{% endif %}
