#!/bin/bash
#FLUX: --job-name=astute-cupcake-0291
#FLUX: --priority=16

export NODES='$SLURM_NNODES'
export corespernode='$SLURM_CPUS_ON_NODE'
export machine='orion'
export fg_proc='$corespernode'
export fg_threads='1 '
export enkf_threads='10'
export gsi_control_threads='4'
export write_groups='4'
export write_tasks='1 '
export layout='3, 2'
export cores='`expr $NODES \* $corespernode`'
export ndates_job='1 # number of DA cycles to run in one job submission'
export RES='96   '
export RES_CTL='192'
export OCNRES='mx050'
export ORES3='`echo $OCNRES | cut -c3-5`'
export hybgain='false" # hybrid gain approach, if false use hybrid covariance'
export alpha='250 # percentage of 3dvar increment (beta_2*1000) '
export beta='1000 # percentage of enkf increment (*10)'
export recenter_control_wgt='100'
export recenter_ensmean_wgt='`expr 100 - $recenter_control_wgt`'
export exptname='jedi_C${RES}_lgetkf_sondesonly'
export replay_controlfcst='false'
export enkfonly='true' # pure EnKF'
export fg_gfs='run_ens_fv3.sh'
export ensda='enkf_run.sh'
export rungsi='run_gsi_4densvar.sh'
export rungfs='run_fv3.sh' # ensemble forecast'
export jedirun='true'
export jedidatadir='/work2/noaa/gsienkf/weihuang/jedi/case_study/Data'
export jeditemplatedir='/work2/noaa/gsienkf/weihuang/production/run/templates'
export jediblddir='/work2/noaa/gsienkf/weihuang/production/build/fv3-bundle'
export resubmit='true'
export do_cleanup='false' # if true, create tar files, delete *mem* files.'
export cleanup_fg='false'
export cleanup_ensmean='false'
export cleanup_ensmean_enkf='false'
export cleanup_anal='false'
export cleanup_controlanl='false'
export cleanup_observer='false' '
export replay_run_observer='false' # run observer on replay control forecast'
export ensmean_restart='false'
export recenter_anal='true'
export recenter_fcst='false'
export controlanal='false" # hybrid-cov high-res control analysis as in ops'
export save_hpss_subset='false" # save a subset of data each analysis time to HPSS'
export save_hpss='false'
export datapath='${datadir}/${exptname}'
export logdir='${datadir}/logs/${exptname}'
export NOSAT='YES" # if yes, no radiances assimilated'
export NOCONV='NO'
export NOTLNMC='NO" # no TLNMC in GSI in GSI EnVar'
export NOOUTERLOOP='NO" # no outer loop in GSI EnVar'
export DONST='YES'
export NST_MODEL='2'
export NST_SPINUP='0 # (will be set to 1 if cold_start=='true')'
export NST_RESV='0'
export ZSEA1='0'
export ZSEA2='0'
export NSTINFO='0          # number of elements added in obs. data array (default = 0)'
export NST_GSI='0'
export FRAC_GRID='.false.'
export LEVS='127 '
export aircraft_t_bc='.true.'
export dmesh1='145'
export dmesh2='145'
export dmesh3='100'
export DO_SPPT='T'
export SPPT='0.5'
export DO_SHUM='T'
export SHUM='0.005'
export DO_SKEB='T'
export SKEB='0.3'
export PERT_MP='.true.'
export PERT_CLDS='.true.'
export imp_physics='11 # used by GSI, not model'
export FHCYC='6 # if == 0 run global_cycle instead of gcycle inside model'
export LONA='$LONB'
export LATA='$LATB      '
export ANALINC='6'
export FHMIN='6'
export FHMAX='7'
export FHOUT='6'
export RESTART_FREQ='6'
export FHMAX_LONGER='12'
export enkfstatefhrs='`python -c "from __future__ import print_function; print(list(range(${FHMIN},${FHMAXP1},${FHOUT})))" | cut -f2 -d"[" | cut -f1 -d"]"`'
export iaufhrs='6'
export iau_delthrs='-1'
export RUN='gdas # use gdas or gfs obs'
export INCREMENTS_TO_ZERO='liq_wat_inc','icmr_inc'
export INCVARS_ZERO_STRAT='sphum_inc','liq_wat_inc','icmr_inc'
export INCVARS_EFOLD='5'
export write_fv3_increment='.false." # don't change this'
export WRITE_INCR_ZERO='incvars_to_zero= $INCREMENTS_TO_ZERO,'
export WRITE_ZERO_STRAT='incvars_zero_strat= $INCVARS_ZERO_STRAT,'
export WRITE_STRAT_EFOLD='incvars_efold= $INCVARS_EFOLD,'
export use_correlated_oberrs='.true.'
export SMOOTHINF='35 # inflation smoothing (spectral truncation)'
export covinflatemax='1.e2'
export reducedgrid='.false. # if T, used reduced gaussian analysis grid in EnKF'
export covinflatemin='1.0                                            '
export analpertwtnh='0.85'
export analpertwtsh='0.85'
export analpertwttr='0.85'
export analpertwtnh_rtpp='0.0'
export analpertwtsh_rtpp='0.0'
export analpertwttr_rtpp='0.0'
export pseudo_rh='.true.'
export write_ensmean='.true. # write out ens mean analysis in EnKF'
export letkf_flag='.true.'
export letkf_bruteforce_search='.false.'
export denkf='.true.'
export getkf='.true.'
export getkf_inflation='.false.'
export modelspace_vloc='.true.'
export letkf_novlocal='.true.'
export nobsl_max='10000'
export corrlengthnh='2000'
export corrlengthtr='2000'
export corrlengthsh='2000'
export lnsigcutoffnh='1.5'
export lnsigcutofftr='1.5'
export lnsigcutoffsh='1.5'
export lnsigcutoffpsnh='1.5'
export lnsigcutoffpstr='1.5'
export lnsigcutoffpssh='1.5'
export lnsigcutoffsatnh='1.5 '
export lnsigcutoffsattr='1.5  '
export lnsigcutoffsatsh='1.5  '
export paoverpb_thresh='0.998  # ignored for LETKF, set to 1 to use all obs in serial EnKF'
export saterrfact='1.0'
export deterministic='.true.'
export sortinc='.true.'
export beta_s0='`python -c "from __future__ import print_function; print($alpha / 1000.)"` # weight given to static B in hyb cov'
export beta_e0='`python -c "from __future__ import print_function; print($beta / 1000.)"` # weight given to ensemble B in hyb cov'
export s_ens_h='343.     # 1250 km horiz localization in GSI'
export biascorrdir='${datapath}/2020010100'
export nanals='80                                                    '
export nanals2='-1 # longer extension. Set to -1 to disable '
export nitermax='1 # number of retries'
export enkfscripts='${basedir}/scripts/${exptname}'
export homedir='$enkfscripts'
export incdate='${enkfscripts}/incdate.sh'
export hydrostatic='.false.'
export ANAVINFO='${fixgsi}/global_anavinfo.l${LEVS}.txt'
export ANAVINFO_ENKF='${ANAVINFO}'
export HYBENSINFO='${fixgsi}/global_hybens_info.l${LEVS}.txt # only used if readin_beta or readin_localization=T'
export OZINFO='${fixgsi}/global_ozinfo.txt'
export CONVINFO='${enkfscripts}/global_convinfo.txt.sondesonly'
export SATINFO='${fixgsi}/global_satinfo.txt'
export NLAT='$((${LATA}+2))'
export REALTIME='YES # if NO, use historical files set in main.sh'

export NODES=$SLURM_NNODES
export corespernode=$SLURM_CPUS_ON_NODE
export machine='orion'
if [ $NODES -eq 10 ]; then
  # 10 nodes, 2 threads
  export control_threads=2
  export control_proc=400
  export write_groups_ctl=4 # write groups for control forecast.
  export write_tasks_ctl=4
  export layout_ctl="4,8" # layout_x,layout_y (total # mpi tasks = $layout_x*$layout_y*6=($fg_proc/$fg_threads) - $write_tasks*$write_groups)
elif [ $NODES -eq 20 ]; then
  # 20 nodes, 2 threads
  export control_threads=2
  export control_proc=800
  export write_groups_ctl=4 # write groups for control forecast.
  export write_tasks_ctl=4
  export layout_ctl="8,8" # layout_x,layout_y (total # mpi tasks = $layout_x*$layout_y*6=($fg_proc/$fg_threads) - $write_tasks*$write_groups)
elif [ $NODES -eq 40 ]; then
  # 40 nodes, 4 threads
  export control_threads=4 
  export control_proc=1600 
  export write_groups_ctl=4
  export write_tasks_ctl=4
  export layout_ctl="8, 8"
  # 32 nodes, 4 threads
  #export control_threads=4 
  #export control_proc=1280 
  #export write_groups_ctl=4
  #export write_tasks_ctl=8
  #export layout_ctl="8, 6"
elif [ $NODES -eq 80 ]; then
  # 80 nodes, 8 threads
  export control_threads=8 
  export control_proc=3200 
  export write_groups_ctl=4
  export write_tasks_ctl=4
  export layout_ctl="8, 8"
else
  echo "processor layout for $NODES nodes not set"
  exit 1
fi
export fg_proc=$corespernode
export fg_threads=1 
export enkf_threads=10
export gsi_control_threads=4
export write_groups=4
export write_tasks=1 
export layout="3, 2"
export cores=`expr $NODES \* $corespernode`
echo "running on $machine using $NODES nodes and $cores CORES"
export ndates_job=1 # number of DA cycles to run in one job submission
export RES=96   
export RES_CTL=192
export OCNRES=mx050
export ORES3=`echo $OCNRES | cut -c3-5`
export hybgain="false" # hybrid gain approach, if false use hybrid covariance
export alpha=250 # percentage of 3dvar increment (beta_2*1000) 
export beta=1000 # percentage of enkf increment (*10)
export recenter_control_wgt=100
export recenter_ensmean_wgt=`expr 100 - $recenter_control_wgt`
export exptname="jedi_C${RES}_lgetkf_sondesonly"
export replay_controlfcst='false'
export enkfonly='true' # pure EnKF
export fg_gfs="run_ens_fv3.sh"
export ensda="enkf_run.sh"
export rungsi='run_gsi_4densvar.sh'
export rungfs='run_fv3.sh' # ensemble forecast
export jedirun='true'
export jedidatadir=/work2/noaa/gsienkf/weihuang/jedi/case_study/Data
export jeditemplatedir=/work2/noaa/gsienkf/weihuang/production/run/templates
export jediblddir=/work2/noaa/gsienkf/weihuang/production/build/fv3-bundle
export resubmit='true'
export do_cleanup='false' # if true, create tar files, delete *mem* files.
export cleanup_fg='false'
export cleanup_ensmean='false'
export cleanup_ensmean_enkf='false'
export cleanup_anal='false'
export cleanup_controlanl='false'
export cleanup_observer='false' 
export replay_run_observer='false' # run observer on replay control forecast
if [ $machine == "orion" ]; then
   export save_hpss_subset="false" # save a subset of data each analysis time to HPSS
   export save_hpss="false"
else
   export save_hpss_subset="true" # save a subset of data each analysis time to HPSS
   export save_hpss="true"
fi
export ensmean_restart='false'
export recenter_anal="true"
export recenter_fcst="false"
export controlanal="false" # hybrid-cov high-res control analysis as in ops
export save_hpss_subset="false" # save a subset of data each analysis time to HPSS
export save_hpss="false"
source $MODULESHOME/init/sh
if [ "$machine" == 'hera' ]; then
   export basedir=/scratch2/BMC/gsienkf/${USER}
   export datadir=$basedir
   export hsidir="/ESRL/BMC/gsienkf/2year/whitaker/${exptname}"
   export obs_datapath=/scratch1/NCEPDEV/global/glopara/dump
   module purge
   module use /scratch2/NCEPDEV/nwprod/hpc-stack/libs/hpc-stack/modulefiles/stack
   module load hpc/1.1.0
   module load hpc-intel/18.0.5.274
   module load hpc-impi/2018.0.4
   module load hdf5/1.10.6
   module load netcdf/4.7.4
   module load pio/2.5.2
   module load esmf/8_2_0_beta_snapshot_14
   module load fms/2021.03
   module load wgrib
   export WGRIB=`which wgrib`
elif [ "$machine" == 'orion' ]; then
  #export basedir=/work2/noaa/gsienkf/${USER}
  #export basedir=/work2/noaa/gsienkf/weihuang/gsi
   export basedir=/work2/noaa/da/weihuang/cycling
   export datadir=$basedir
   export hsidir="/ESRL/BMC/gsienkf/2year/whitaker/${exptname}"
   export obs_datapath=/work/noaa/rstprod/dump
   ulimit -s unlimited
   source $MODULESHOME/init/sh
   module use /apps/contrib/NCEP/libs/hpc-stack/modulefiles/stack
   module load hpc/1.1.0
   module load hpc-intel/2018.4
   module unload mkl/2020.2
   module load mkl/2018.4
   module load hpc-impi/2018.4
   module load python/3.7.5
   module load hdf5/1.10.6-parallel
   module load wgrib/1.8.0b
  #export PYTHONPATH=/home/jwhitake/.local/lib/python3.7/site-packages
   export PYTHONPATH=/work2/noaa/gsienkf/weihuang/anaconda3/lib
   export HDF5_DISABLE_VERSION_CHECK=1
   export WGRIB=`which wgrib`
elif [ "$machine" == 'gaea' ]; then
   export basedir=/lustre/f2/dev/${USER}
   export datadir=/lustre/f2/scratch/${USER}
   export hsidir="/ESRL/BMC/gsienkf/2year/whitaker/${exptname}"
   #export hsidir="/3year/NCEPDEV/GEFSRR/${exptname}"
   export obs_datapath=/lustre/f2/dev/Jeffrey.S.Whitaker/dumps
else
   echo "machine must be 'hera', 'orion' or 'gaea' got $machine"
   exit 1
fi
export datapath="${datadir}/${exptname}"
export logdir="${datadir}/logs/${exptname}"
export NOSAT="YES" # if yes, no radiances assimilated
export NOCONV="NO"
export NOTLNMC="NO" # no TLNMC in GSI in GSI EnVar
export NOOUTERLOOP="NO" # no outer loop in GSI EnVar
export DONST="YES"
export NST_MODEL=2
export NST_SPINUP=0 # (will be set to 1 if cold_start=='true')
export NST_RESV=0
export ZSEA1=0
export ZSEA2=0
export NSTINFO=0          # number of elements added in obs. data array (default = 0)
export NST_GSI=3          # default 0: No NST info at all;
                          #         1: Input NST info but not used in GSI;
                          #         2: Input NST info, used in CRTM simulation, no Tr analysis
                          #         3: Input NST info, used in both CRTM simulation and Tr analysis
export DONST="NO"
export NST_MODEL=0
export NST_GSI=0
export DONST="YES"
export NST_MODEL=2
export NST_GSI=0
export FRAC_GRID=.false.
if [ $NST_GSI -gt 0 ]; then export NSTINFO=4; fi
if [ $NOSAT == "YES" ]; then export NST_GSI=0; fi # don't try to do NST in GSI without satellite data
export LEVS=127 
export aircraft_t_bc=.true.
export aircraft_t_bc=.true.
if [ $LEVS -eq 64 ]; then
  export nsig_ext=12
  export gpstop=50
  export GRIDOPTS="nlayers(63)=3,nlayers(64)=6,"
  if [ $DONST == "YES" ]; then
     export SUITE="FV3_GFS_v15p2"
  else
     export SUITE="FV3_GFS_v15p2_no_nsst"
  fi
elif [ $LEVS -eq 127 ]; then
  export nsig_ext=56
  export gpstop=55
  export GRIDOPTS="nlayers(63)=1,nlayers(64)=1,"
  if [ $DONST == "YES" ]; then
     export SUITE="FV3_GFS_v17_p8"
     export SUITE="FV3_GFS_v16"
  else
     export SUITE="FV3_GFS_v17_p8_nonsst"
     export SUITE="FV3_GFS_v16_no_nsst"
     #export SUITE="FV3_GFS_v16_coupled_nsstNoahmpUGWPv1"
  fi
else
  echo "LEVS must be 64 or 127"
  exit 1
fi
export dmesh1=145
export dmesh2=145
export dmesh3=100
export DO_SPPT=T
export SPPT=0.5
export DO_SHUM=T
export SHUM=0.005
export DO_SKEB=T
export SKEB=0.3
export PERT_MP=.true.
export PERT_CLDS=.true.
export imp_physics=11 # used by GSI, not model
if [ $RES -eq 384 ]; then
   export JCAP=766
   export LONB=1536
   export LATB=768
   export dt_atmos=225 # for n_split=6
   export cdmbgwd="1.1,0.72,1.0,1.0"
elif [ $RES -eq 192 ]; then
   export JCAP=382 
   export LONB=768   
   export LATB=384  
   export dt_atmos=450
   #export dt_atmos=225
   export cdmbgwd="0.23,1.5,1.0,1.0"
elif [ $RES -eq 128 ]; then
   export JCAP=254 
   export LONB=512   
   export LATB=256  
   export dt_atmos=720
   export cdmbgwd="0.19,1.6,1.0,1.0"  
elif [ $RES -eq 96 ]; then
   export JCAP=190
   export LONB=384   
   export LATB=192  
  #export dt_atmos=600   #Original setup. It blows up at 2020010618.
   export dt_atmos=600
  #export dt_atmos=300
   export cdmbgwd="0.14,1.8,1.0,1.0"  # mountain blocking, ogwd, cgwd, cgwd src scaling
elif [ $RES -eq 48 ]; then
   export JCAP=94
   export LONB=192   
   export LATB=96   
   export dt_atmos=1800
   export cdmbgwd="0.071,2.1,1.0,1.0"  
else
   echo "model parameters for ensemble resolution C$RES not set"
   exit 1
fi
if [ $RES_CTL -eq 768 ]; then
   export cdmbgwd_ctl="4.0,0.15,1.0,1.0"
   export JCAP_CTL=1534
   export LONB_CTL=3072
   export LATB_CTL=1536
   export dt_atmos_ctl=150    
elif [ $RES_CTL -eq 384 ]; then
   export dt_atmos_ctl=225
   export cdmbgwd_ctl="1.1,0.72,1.0,1.0"
   export JCAP_CTL=766
   export LONB_CTL=1536
   export LATB_CTL=768
elif [ $RES_CTL -eq 192 ]; then
   export dt_atmos_ctl=450
   export cdmbgwd_ctl="0.23,1.5,1.0,1.0"
   export JCAP_CTL=382
   export LONB_CTL=768  
   export LATB_CTL=384
elif [ $RES_CTL -eq 96 ]; then
   export dt_atmos_ctl=900
   export cdmbgwd="0.14,1.8,1.0,1.0"  # mountain blocking, ogwd, cgwd, cgwd src scaling
   export JCAP_CTL=188
   export LONB_CTL=384  
   export LATB_CTL=192
else
   echo "model parameters for control resolution C$RES_CTL not set"
   exit 1
fi
export FHCYC=6 # if == 0 run global_cycle instead of gcycle inside model
export LONA=$LONB
export LATA=$LATB      
export ANALINC=6
export FHMIN=6
export FHMAX=7
export FHOUT=6
export RESTART_FREQ=6
FHMAXP1=`expr $FHMAX + 1`
export FHMAX_LONGER=12
export enkfstatefhrs=`python -c "from __future__ import print_function; print(list(range(${FHMIN},${FHMAXP1},${FHOUT})))" | cut -f2 -d"[" | cut -f1 -d"]"`
export iaufhrs="3,6,9"
export iau_delthrs="6" # iau_delthrs < 0 turns IAU off
export iaufhrs="6"
export iau_delthrs=-1
export RUN=gdas # use gdas or gfs obs
export INCREMENTS_TO_ZERO="'liq_wat_inc','icmr_inc'"
export INCVARS_ZERO_STRAT="'sphum_inc','liq_wat_inc','icmr_inc'"
export INCVARS_EFOLD="5"
export write_fv3_increment=".false." # don't change this
export WRITE_INCR_ZERO="incvars_to_zero= $INCREMENTS_TO_ZERO,"
export WRITE_ZERO_STRAT="incvars_zero_strat= $INCVARS_ZERO_STRAT,"
export WRITE_STRAT_EFOLD="incvars_efold= $INCVARS_EFOLD,"
export use_correlated_oberrs=".true."
export SMOOTHINF=35 # inflation smoothing (spectral truncation)
export covinflatemax=1.e2
export reducedgrid=.false. # if T, used reduced gaussian analysis grid in EnKF
export covinflatemin=1.0                                            
export analpertwtnh=0.85
export analpertwtsh=0.85
export analpertwttr=0.85
export analpertwtnh_rtpp=0.0
export analpertwtsh_rtpp=0.0
export analpertwttr_rtpp=0.0
export pseudo_rh=.true.
export write_ensmean=.true. # write out ens mean analysis in EnKF
if [[ $write_ensmean == ".true." ]]; then
   export ENKFVARS="write_ensmean=${write_ensmean},"
fi
export letkf_flag=.true.
export letkf_bruteforce_search=.false.
export denkf=.true.
export getkf=.true.
export getkf_inflation=.false.
export modelspace_vloc=.true.
export letkf_novlocal=.true.
export nobsl_max=10000
export corrlengthnh=2000
export corrlengthtr=2000
export corrlengthsh=2000
export lnsigcutoffnh=1.5
export lnsigcutofftr=1.5
export lnsigcutoffsh=1.5
export lnsigcutoffpsnh=1.5
export lnsigcutoffpstr=1.5
export lnsigcutoffpssh=1.5
export lnsigcutoffsatnh=1.5 
export lnsigcutoffsattr=1.5  
export lnsigcutoffsatsh=1.5  
export paoverpb_thresh=0.998  # ignored for LETKF, set to 1 to use all obs in serial EnKF
export saterrfact=1.0
export deterministic=.true.
export sortinc=.true.
export beta_s0=`python -c "from __future__ import print_function; print($alpha / 1000.)"` # weight given to static B in hyb cov
export beta_e0=`python -c "from __future__ import print_function; print($beta / 1000.)"` # weight given to ensemble B in hyb cov
export s_ens_h=343.     # 1250 km horiz localization in GSI
if [ $LEVS -eq 64 ]; then
  export s_ens_v=5.4 # 14 levels
elif [ $LEVS -eq 127 ]; then
  export s_ens_v=7.7 # 20 levels
fi
export biascorrdir=${datapath}/2020010100
export nanals=80                                                    
export nanals2=-1 # longer extension. Set to -1 to disable 
export nitermax=1 # number of retries
export enkfscripts="${basedir}/scripts/${exptname}"
export homedir=$enkfscripts
export incdate="${enkfscripts}/incdate.sh"
if [ "$machine" == 'hera' ]; then
   export FIXDIR=/scratch1/NCEPDEV/nems/emc.nemspara/RT/NEMSfv3gfs/input-data-20220414
   #export FIXDIR_gcyc=$FIXDIR
   export FIXDIR_gcyc=/scratch1/NCEPDEV/global/glopara/fix_NEW # for GFSv16
   export python=/contrib/anaconda/2.3.0/bin/python
   export gsipath=${basedir}/gsi/GSI
   export fixgsi=${gsipath}/fix
   export fixcrtm=/scratch2/NCEPDEV/nwprod/NCEPLIBS/fix/crtm_v2.3.0
   export execdir=${enkfscripts}/exec_${machine}
   export enkfbin=${execdir}/global_enkf
   export gsiexec=${execdir}/global_gsi
   export CHGRESEXEC=${execdir}/enkf_chgres_recenter_nc.x
elif [ "$machine" == 'orion' ]; then
   export FIXDIR=/work/noaa/nems/emc.nemspara/RT/NEMSfv3gfs/input-data-20220414
   #export FIXDIR_gcyc=$FIXDIR
   export FIXDIR_gcyc=/work/noaa/global/glopara/fix_NEW # for GFSv16
   export python=`which python`
   export fv3gfspath=/work/noaa/global/glopara
   export FIXFV3=$fv3gfspath/fix_nco_gfsv16/fix_fv3_gmted2010
   export FIXGLOBAL=$fv3gfspath/fix_nco_gfsv16/fix_am
   export gsipath=/work/noaa/gsienkf/whitaker/GSI
   export fixgsi=${gsipath}/fix
   #export fixcrtm=${basedir}/fix/crtm/v2.2.6/fix
   export fixcrtm=$fv3gfspath/crtm/crtm_v2.3.0
   export execdir=${enkfscripts}/exec_${machine}
   export enkfbin=${execdir}/global_enkf
   export gsiexec=${execdir}/global_gsi
   export CHGRESEXEC=${execdir}/enkf_chgres_recenter_nc.x
elif [ "$machine" == 'gaea' ]; then
   export python=/ncrc/sw/gaea/PythonEnv-noaa/1.4.0/.spack/opt/spack/linux-sles12-x86_64/gcc-4.8/python-2.7.14-zyx34h36bfp2c6ftp5bhdsdduqjxbvp6/bin/python
   #export PYTHONPATH=/ncrc/home2/Jeffrey.S.Whitaker/anaconda2/lib/python2.7/site-packages
   #export fv3gfspath=/lustre/f1/pdata/ncep_shared/fv3/fix-fv3gfs/
   export fv3gfspath=/lustre/f2/dev/Jeffrey.S.Whitaker/fv3_reanl/fv3gfs/global_shared.v15.0.0
   export FIXFV3=${fv3gfspath}/fix/fix_fv3_gmted2010
   export FIXGLOBAL=${fv3gfspath}/fix/fix_am
   export gsipath=/lustre/f2/dev/Jeffrey.S.Whitaker/GSI-github-jswhit
   export fixgsi=${gsipath}/fix
   export fixcrtm=/lustre/f2/pdata/ncep_shared/NCEPLIBS/lib/crtm/v2.2.6/fix
   #export fixcrtm=${fixgsi}/crtm_v2.2.3
   export execdir=${enkfscripts}/exec_${machine}
   export enkfbin=${execdir}/global_enkf
   export gsiexec=${execdir}/global_gsi
   export CHGRESEXEC=${execdir}/enkf_chgres_recenter_nc.x
else
   echo "${machine} unsupported machine"
   exit 1
fi
export hydrostatic=.false.
if [ $hydrostatic == ".true." ]; then
   export FCSTEXEC=${execdir}/fv3-hydro.exe
else
   export FCSTEXEC=${execdir}/fv3-nonhydro.exe
fi
export ANAVINFO=${fixgsi}/global_anavinfo.l${LEVS}.txt
export ANAVINFO_ENKF=${ANAVINFO}
export HYBENSINFO=${fixgsi}/global_hybens_info.l${LEVS}.txt # only used if readin_beta or readin_localization=T
export OZINFO=${fixgsi}/global_ozinfo.txt
export CONVINFO=${enkfscripts}/global_convinfo.txt.sondesonly
export SATINFO=${fixgsi}/global_satinfo.txt
export NLAT=$((${LATA}+2))
export REALTIME=YES # if NO, use historical files set in main.sh
cd $enkfscripts
echo "run main driver script"
if [ $controlanal == "true" ]; then
   # run as in NCEP ops, with high-res control forecast updated by GSI hyb 4denvar,
   # and enkf analysis recentered around upscaled control analysis.
   # use static B weights and localization scales for GSI from files.
   # (s_ens_h, s_ens_v, beta_s0, beta_e0 will be ignored)
   export readin_localization=".true."
   export readin_beta=".true."
   export replay_controlfcst=".false."
   export hybgain=".false." # controlanal takes precedence over hybgain
   export HYBENSINFO=${fixgsi}/global_hybens_info.l${LEVS}.txt # only used if readin_beta or readin_localization=T
   # uncomment to smooth ensemble perturbations
   #export HYBENSMOOTHINFO=${fixgsi}/global_hybens_smoothinfo.l${LEVS}.txt
   sh ./main_controlanal.sh
else
   # GSI sees ensemble mean background (high-res control forecast is a replay to ens mean analysis)
   # (s_ens_h, s_ens_v, beta_s0, beta_e0, alpha, beta used)
   if [ $hybgain == "false" ]; then
      # use static B weights and localization scales for GSI from files.
      # (beta_s0, beta_e0 ignored)
      #export readin_localization=".true."
      #export readin_beta=".true."
      # use constant values (beta_s0,beta_e0 parameters)
      export readin_beta=.false.
      export readin_localization=.false.
      # these only used for hybrid covariance (hyb 4denvar) in GSI
      export beta_s0=`python -c "from __future__ import print_function; print($alpha / 1000.)"` # weight given to static B in hyb cov
      # beta_e0 parameter (ensemble weight) in my GSI branch (not in GSI/develop)
      export beta_e0=`python -c "from __future__ import print_function; print($beta / 1000.)"` # weight given to ensemble B in hyb cov
   else
      export beta_s0=1.000 # 3dvar
      export beta_e0=0.0
      export readin_beta=.false.
      export readin_localization=.false.
   fi
   sh ./main.sh
fi
