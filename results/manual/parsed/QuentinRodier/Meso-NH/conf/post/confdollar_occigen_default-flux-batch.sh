#!/bin/bash
#FLUX: --job-name=dinosaur-pancake-9068
#FLUX: --urgency=16

export NBP='${NBP-"1"}'
export TIME='${TIME-"3600"}'
export MNH_EXP='${MNH_EXP-"MNH_EXP"}'
export MPIRUN='${MPIRUN-"Mpirun -np ${NBP} "}'
export MONORUN='${MONORUN-"Mpirun -np 1 "}'
export CAT='${CAT-"cat"}'
export SUBDIR='${SUBDIR-"${PWD}/${CONFEXP}"}'
export EXECDIR='${EXECDIR-"/tmpdir/${USER}/${CONFEXP}"}'
export LINKFILES='${LINKFILES-"ln -sf "}'
export INDIR='${INDIR-"INDIR"}'
export OUTDIR='${OUTDIR-"${INDIR}"}'
export OUTHOST='${OUTHOST-"${INHOST}"}'
export RMSHELL='${RMSHELL-"ssh -n occigen "}'
export QSUB='${QSUB-"/usr/bin/sbatch"}'
export CORE='${CORE-24}'
export NCPUS='${CORE} MPIPROCS=${CORE}'
export NBNODES='$( echo " scale=0 ; 1 + ( ${NBP} - 1 ) / ${NCPUS} " | bc -l )'
export JOBOUT='${JOBOUT-"Sortie_${NBP}P_${CORE}C_${NBNODES}N_${VER_MPI}.%j"}'
export JOBNAME='${JOBNAME-"job_${CONFEXP}"}'
export JOBMULTI='\'
export JOBMONO='\'
export JOBSTAT='${JOBSTAT-"squeue \${SLURM_JOBID} "}'
export PREP_PGD_FILES='${PREP_PGD_FILES-"${HOME}/PREP_PGD_FILES_WWW"}'
export OUT_CPGDFILE='${OUT_CPGDFILE-"OUT_CPGDFILE"}'
export INP_CPGDFILE_FATHER='${INP_CPGDFILE_FATHER-"INP_CPGDFILE_FATHER"}'
export INP_YPGD1='${INP_YPGD1-"INP_YPGD1"}'
export INP_YPGD2='${INP_YPGD2-"INP_YPGD2"}'
export INP_YPGD3='${INP_YPGD3-"INP_YPGD3"}'
export INP_YPGD4='${INP_YPGD4-"INP_YPGD4"}'
export LISTGET='${LISTGET-"LISTGET"}'
export CRT_YNEST='${CRT_YNEST-"CRT_YNEST"}'
export OUT_YPGD1_NEST='${OUT_YPGD1_NEST-"OUT_YPGD1_NEST"}'
export OUT_YPGD2_NEST='${OUT_YPGD2_NEST-"OUT_YPGD2_NEST"}'
export LISTE_PUT='${LISTE_PUT-"LISTE_PUT"}'
export INDIR_HATMFILE='${INDIR_HATMFILE-"${RMINDIR}"}'
export INP_HATMFILE='${INP_HATMFILE-"INP_HATMFILE"}'
export SUF='${SUF-"SUF"}'
export INP_HPGDFILE='${INP_HPGDFILE-"INP_HPGDFILE"}'
export INP_CFILE='${INP_CFILE-"INP_CFILE"}'
export OUT_CINIFILE='${OUT_CINIFILE-"OUT_CINIFILE"}'
export INP_YDOMAIN='${INP_YDOMAIN-"INP_YDOMAIN"}'
export INP_CINIFILE='${INP_CINIFILE-"INP_CINIFILE"}'
export OUT_CINIFILE_SPA='${OUT_CINIFILE_SPA-"OUT_CINIFILE_SPA"}'
export INP_CINIFILE1='${INP_CINIFILE1-"INP_CINIFILE1"}'
export INP_CINIFILE2='${INP_CINIFILE2-"INP_CINIFILE2"}'
export CRT_CEXP='${CRT_CEXP-"CRT_CEXP"}'
export CRT_CSEG='${CRT_CSEG-"CRT_CSEG"}'
export OUT_XBAK_TIME='${OUT_XBAK_TIME-"OUT_XBAK_TIME"}'
export INP_YINIFILE='${INP_YINIFILE-"INP_YINIFILE"}'
export CRT_YSUFFIX='${CRT_YSUFFIX-"CRT_YSUFFIX"}'
export OUT_DIAG='${OUT_DIAG-"OUT_DIAG"}'
export CRT_CVYSUFFIX='${CRT_CVYSUFFIX-"CRT_CVYSUFFIX"}'
export OUT_CVFILE='${OUT_CVFILE-"OUT_CVFILE"}'
export INP_FILE1='${INP_FILE1-"INP_FILE1"}'
export NOVISU='=${NOVISU=-"!"}'
export OUT_GMFILE='${OUT_GMFILE-"OUT_GMFILE"}'

export NBP=${NBP-"1"}
export TIME=${TIME-"3600"}
export MNH_EXP=${MNH_EXP-"MNH_EXP"}
export MPIRUN=${MPIRUN-"Mpirun -np ${NBP} "}
export MONORUN=${MONORUN-"Mpirun -np 1 "}
export CAT=${CAT-"cat"}
export SUBDIR=${SUBDIR-"${PWD}/${CONFEXP}"}
export EXECDIR=${EXECDIR-"/tmpdir/${USER}/${CONFEXP}"}
export LINKFILES=${LINKFILES-"ln -sf "}
export INDIR=${INDIR-"INDIR"}
export OUTDIR=${OUTDIR-"${INDIR}"}
case "${INHOST}" in 
    "" ) # default local transfert
    export GETFILES=${GETFILES-"ln -s "}
    export RMINDIR=${RMINDIR-"${INDIR}"}
    ;;
    *'@'*) # ssh transfert
    export GETFILES=${GETFILES-"scp"}
    export RMINDIR=${RMINDIR-"${INHOST}:${INDIR}"}
    ;;
    workdir) # get file form  $workdir
    export GETFILES=${GETFILES-"ln -s "}
    export INDIR="${WORKDIR}/${INDIR}"
    export RMINDIR="${INDIR}"
    ;;
esac
export OUTHOST=${OUTHOST-"${INHOST}"}
case "${OUTHOST}" in 
    "" ) # local transfert
    export PUTFILES=${PUTFILES-"mv "}  
    export RMMKDIR=${RMMKDIR-"mkdir -p "}
    export RMOUTDIR=${RMOUTDIR-"${OUTDIR}"}
    ;;
    *'@'*) # ssh transfert
    export PUTFILES=${PUTFILES-"scp"} 
    export RMMKDIR=${RMMKDIR-"ssh ${OUTHOST} mkdir -p "}
    export RMOUTDIR=${RMOUTDIR-"${OUTHOST}:${OUTDIR}"}
    ;;
    workdir) # put files in $workdir
    export PUTFILES=${PUTFILES-"cp "}
    export RMMKDIR=${RMMKDIR-"mkdir -p "}
    export OUTDIR="${WORKDIR}/${OUTDIR}"
    export RMOUTDIR="${OUTDIR}"
    ;;
esac
export RMSHELL=${RMSHELL-"ssh -n occigen "}
export QSUB=${QSUB-"/usr/bin/sbatch"}
export CORE=${CORE-24}
export NCPUS=${CORE} MPIPROCS=${CORE}
export NBNODES=$( echo " scale=0 ; 1 + ( ${NBP} - 1 ) / ${NCPUS} " | bc -l )
export JOBOUT=${JOBOUT-"Sortie_${NBP}P_${CORE}C_${NBNODES}N_${VER_MPI}.%j"}
export JOBNAME=${JOBNAME-"job_${CONFEXP}"}
export JOBMULTI="\
"
export JOBMONO="\
"
export JOBSTAT=${JOBSTAT-"squeue \${SLURM_JOBID} "}
export PREP_PGD_FILES=${PREP_PGD_FILES-"${HOME}/PREP_PGD_FILES_WWW"}
export OUT_CPGDFILE=${OUT_CPGDFILE-"OUT_CPGDFILE"}
export INP_CPGDFILE_FATHER=${INP_CPGDFILE_FATHER-"INP_CPGDFILE_FATHER"}
export INP_YPGD1=${INP_YPGD1-"INP_YPGD1"}
export INP_YPGD2=${INP_YPGD2-"INP_YPGD2"}
export INP_YPGD3=${INP_YPGD3-"INP_YPGD3"}
export INP_YPGD4=${INP_YPGD4-"INP_YPGD4"}
export LISTGET=${LISTGET-"LISTGET"}
export CRT_YNEST=${CRT_YNEST-"CRT_YNEST"}
export OUT_YPGD1_NEST=${OUT_YPGD1_NEST-"OUT_YPGD1_NEST"}
export OUT_YPGD2_NEST=${OUT_YPGD2_NEST-"OUT_YPGD2_NEST"}
export LISTE_PUT=${LISTE_PUT-"LISTE_PUT"}
export INDIR_HATMFILE=${INDIR_HATMFILE-"${RMINDIR}"}
export INP_HATMFILE=${INP_HATMFILE-"INP_HATMFILE"}
export SUF=${SUF-"SUF"}
export INP_HPGDFILE=${INP_HPGDFILE-"INP_HPGDFILE"}
export INP_CFILE=${INP_CFILE-"INP_CFILE"}
export OUT_CINIFILE=${OUT_CINIFILE-"OUT_CINIFILE"}
export INP_YDOMAIN=${INP_YDOMAIN-"INP_YDOMAIN"}
export INP_CINIFILE=${INP_CINIFILE-"INP_CINIFILE"}
export OUT_CINIFILE_SPA=${OUT_CINIFILE_SPA-"OUT_CINIFILE_SPA"}
export INP_CINIFILE1=${INP_CINIFILE1-"INP_CINIFILE1"}
export INP_CINIFILE2=${INP_CINIFILE2-"INP_CINIFILE2"}
export CRT_CEXP=${CRT_CEXP-"CRT_CEXP"}
export CRT_CSEG=${CRT_CSEG-"CRT_CSEG"}
export OUT_XBAK_TIME=${OUT_XBAK_TIME-"OUT_XBAK_TIME"}
export INP_YINIFILE=${INP_YINIFILE-"INP_YINIFILE"}
export CRT_YSUFFIX=${CRT_YSUFFIX-"CRT_YSUFFIX"}
export OUT_DIAG=${OUT_DIAG-"OUT_DIAG"}
export CRT_CVYSUFFIX=${CRT_CVYSUFFIX-"CRT_CVYSUFFIX"}
export OUT_CVFILE=${OUT_CVFILE-"OUT_CVFILE"}
export INP_FILE1=${INP_FILE1-"INP_FILE1"}
export NOVISU==${NOVISU=-"!"}
export OUT_GMFILE=${OUT_GMFILE-"OUT_GMFILE"}
