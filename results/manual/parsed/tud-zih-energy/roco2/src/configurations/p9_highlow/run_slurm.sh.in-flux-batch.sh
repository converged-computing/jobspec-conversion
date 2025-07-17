#!/bin/bash
#FLUX: --job-name=crunchy-platanos-7759
#FLUX: -c=176
#FLUX: --exclusive
#FLUX: --queue=ml
#FLUX: -t=7199
#FLUX: --urgency=16

export GOMP_CPU_AFFINITY='0-175'
export SCOREP_ENABLE_TRACING='1'
export SCOREP_ENABLE_PROFILING='0'
export SCOREP_TOTAL_MEMORY='4095M'
export SCOREP_METRIC_PLUGINS='ibmpowernv_plugin'
export SCOREP_METRIC_IBMPOWERNV_PLUGIN='*'
export SCOREP_METRIC_IBMPOWERNV_PLUGIN_INTERVAL='40ms'

echo "running on $(hostname)"
module restore roco2-ml
echo -n "Checking if kernel param has been successfully set (should be 0): "
sysctl kernel.perf_event_paranoid
export GOMP_CPU_AFFINITY=0-175
export SCOREP_ENABLE_TRACING=1
export SCOREP_ENABLE_PROFILING=0
export SCOREP_TOTAL_MEMORY=4095M
export SCOREP_METRIC_PLUGINS=ibmpowernv_plugin
export SCOREP_METRIC_IBMPOWERNV_PLUGIN='*'
export SCOREP_METRIC_IBMPOWERNV_PLUGIN_INTERVAL=40ms
echo "Checking env..."
echo "  GOMP_CPU_AFFINITY                        = $GOMP_CPU_AFFINITY"
echo "  OMP_PLACES                               = $OMP_PLACES"
echo "  OMP_PROC_BIND                            = $OMP_PROC_BIND"
echo "  SCOREP_ENABLE_TRACING                    = $SCOREP_ENABLE_TRACING"
echo "  SCOREP_ENABLE_PROFILING                  = $SCOREP_ENABLE_PROFILING"
echo "  SCOREP_TOTAL_MEMORY                      = $SCOREP_TOTAL_MEMORY"
echo "  SCOREP_METRIC_PLUGINS                    = $SCOREP_METRIC_PLUGINS"
echo "  SCOREP_METRIC_IBMPOWERNV_PLUGIN          = $SCOREP_METRIC_IBMPOWERNV_PLUGIN"
echo "  SCOREP_METRIC_IBMPOWERNV_PLUGIN_INTERVAL = $SCOREP_METRIC_IBMPOWERNV_PLUGIN_INTERVAL"
echo ""
echo "Executing roco2..."
${CMAKE_CURRENT_BINARY_DIR}/roco2_p9_highlow
echo "Done."
