#!/bin/ksh
#

# EXPORT list here
set -x

#export IOBUF_PARAMS=cfi*:size=64M:count=4:verbose
#export FORT_BUFFERED=TRUE
#export MKL_CBWR=AVX
ulimit -s unlimited
ulimit -a

#export total_tasks=1
#export OMP_NUM_THREADS=1
#export taskspernode=1

#export gefsmpexec_mpmd="aprun -b -j1 -n${total_tasks} -N${taskspernode} -d${OMP_NUM_THREADS} -cc depth cfp mpmd_cmdfile" #mpirun -n $total_tasks cfp mpmd_cmdfile"

# CALL executable job script here
$SOURCEDIR/jobs/JGEFS_ATMOS_AVG_GEMPAK_VGF

