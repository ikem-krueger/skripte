#!/bin/bash

show_help() {
    echo "Usage: m3u2mux radio.m3u tvhd.m3u tvsd.m3u"
}

main() {
    echo "# AVM Fritz!Box"
    echo "# Created from m3u2conf"
    echo "# freq sr fec mod"

    LINES=$(grep "^rtsp://" "$M3U"|cut -d'&' -f2,5,6|sort -u)

    for LINE in $LINES;
    do
        # make variables out of "freq=586&mtype=256qam&sr=6900"
        declare $(echo $LINE|sed 's/&/ /g'|tr '[:lower:]' '[:upper:]')

        # convert MTYPE from "256QAM" to "QAM/256"
        MTYPE=$(echo $MTYPE|sed -r 's/^([0-9]+)(.*)/\2\/\1/')

        echo "[CHANNEL]"
        echo -e "\tDELIVERY_SYSTEM = DVBC/ANNEX_A"
        echo -e "\tFREQUENCY = ${FREQ}000000"
        echo -e "\tSYMBOL_RATE = ${SR}000"
        echo -e "\tINNER_FEC = NONE"
        echo -e "\tMODULATION = $MTYPE"
        echo -e "\tINVERSION = AUTO"
        echo ""
    done
}

if [ $# -eq 0 ]
then
    show_help

    exit 1
fi

M3U="$1"

case "$M3U" in
    *.m3u)
        main > de-AVM;;
    *)
        show_help;;
esac
