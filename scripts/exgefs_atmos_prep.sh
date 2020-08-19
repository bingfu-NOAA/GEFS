#! /bin/bash

echo "$(date -u) begin $(basename $BASH_SOURCE)"

set -xa
if [[ ${STRICT:-NO} == "YES" ]]; then
	# Turn on strict bash error checking
	set -eu
fi

export HOMEgfs=${HOMEgfs:-${HOMEgefs}}
export HOMEufs=${HOMEufs:-${HOMEgfs}}
export USHgfs=$HOMEgfs/ush
export FIXgfs=$HOMEgfs/fix
export FIXfv3=${FIXfv3:-$FIXgfs/fix_fv3_gmted2010}

mem=$(echo $RUNMEM|cut -c3-5)
sfc_mem=${sfc_mem:-"c00"}

cd $DATA

# Run scripts
#############################################################
$USHgefs/gefs_atmos_prep.sh $mem
export err=$?
if [[ $err != 0 ]]; then
	echo "FATAL ERROR in $(basename $BASH_SOURCE): atmos_prep failed for $RUNMEM!"
	exit $err
fi

# Run surface if this is the designated member for that
if [[ $mem == $sfc_mem ]]; then
	$USHgefs/gefs_atmos_prep_sfc.sh $mem
	if [[ $err != 0 ]]; then
		echo "FATAL ERROR in $(basename $BASH_SOURCE): atmos_prep failed processing surface (on $RUNMEM)!"
		exit $err
	fi
fi
#############################################################

echo "$(date -u) end $(basename $BASH_SOURCE)"

exit $err