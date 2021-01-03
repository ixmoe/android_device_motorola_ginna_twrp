#!/system/bin/sh

# Load Device-Specific Modules (Based on Device Variant)
load()
{
    is_fastboot_twrp=$(getprop ro.boot.fastboot)
    if [ ! -z "$is_fastboot_twrp" ]; then
        # insmod /vendor/lib/modules/aw8624.ko
        insmod /vendor/lib/modules/chipone_tddi_mmi.ko
        insmod /vendor/lib/modules/exfat.ko
        insmod /vendor/lib/modules/fpc1020_mmi.ko
        insmod /vendor/lib/modules/mmi_annotate.ko
        insmod /vendor/lib/modules/mmi_info.ko
        insmod /vendor/lib/modules/mmi_sys_temp.ko
        insmod /vendor/lib/modules/moto_f_usbnet.ko
        insmod /vendor/lib/modules/sensors_class.ko
        insmod /vendor/lib/modules/snd_smartpa_aw882xx.ko
        insmod /vendor/lib/modules/utags.ko
    else
        mkdir /v
        suffix=$(getprop ro.boot.slot_suffix)
        if [ -z "$suffix" ]; then
            suf=$(getprop ro.boot.slot)
            suffix="_$suf"
        fi
        venpath="/dev/block/mapper/vendor$suffix"
        mount -t ext4 -o ro "$venpath" /v
        mkdir -p /vendor/lib/modules
        # cp /v/lib/modules/aw8624.ko /vendor/lib/modules/aw8624.ko
        cp /v/lib/modules/chipone_tddi_mmi.ko /vendor/lib/modules/chipone_tddi_mmi.ko
        cp /v/lib/modules/exfat.ko /vendor/lib/modules/exfat.ko
        cp /v/lib/modules/fpc1020_mmi.ko /vendor/lib/modules/fpc1020_mmi.ko
        cp /v/lib/modules/mmi_annotate.ko /vendor/lib/modules/mmi_annotate.ko
        cp /v/lib/modules/mmi_info.ko /vendor/lib/modules/mmi_info.ko
        cp /v/lib/modules/mmi_sys_temp.ko /vendor/lib/modules/mmi_sys_temp.ko
        cp /v/lib/modules/moto_f_usbnet.ko /vendor/lib/modules/moto_f_usbnet.ko
        cp /v/lib/modules/sensors_class.ko /vendor/lib/modules/sensors_class.ko
        cp /v/lib/modules/snd_smartpa_aw882xx.ko /vendor/lib/modules/snd_smartpa_aw882xx.ko
        cp /v/lib/modules/utags.ko /vendor/lib/modules/utags.ko

        # insmod /vendor/lib/modules/aw8624.ko
        insmod /vendor/lib/modules/chipone_tddi_mmi.ko
        insmod /vendor/lib/modules/exfat.ko
        insmod /vendor/lib/modules/fpc1020_mmi.ko
        insmod /vendor/lib/modules/mmi_annotate.ko
        insmod /vendor/lib/modules/mmi_info.ko
        insmod /vendor/lib/modules/mmi_sys_temp.ko
        insmod /vendor/lib/modules/moto_f_usbnet.ko
        insmod /vendor/lib/modules/sensors_class.ko
        insmod /vendor/lib/modules/snd_smartpa_aw882xx.ko
        insmod /vendor/lib/modules/utags.ko
        umount /v
        rmdir /v
    fi
}

load
wait 1

setprop modules.loaded 1

touch_path_chipone=/sys/chipone-tddi
touch_path_fts=/sys/devices/platform/soc/7af7000.spi/spi_master/spi7/spi7.0
firmware_file_fts=focaltech-hlt-ft8006s_aa-0b-0000-ginna.bin

wait_for_poweron()
{
	local wait_nomore
	local readiness
	local count
	wait_nomore=60
	count=0
	readiness=$(cat $touch_path_fts/poweron)
	while true; do
		if [ "$readiness" == "1" ]; then
			break;
		fi
		count=$((count+1))
		[ $count -eq $wait_nomore ] && break
		sleep 1
	done
	if [ $count -eq $wait_nomore ]; then
		return 1
	fi
	return 0
}

if [ ! -d $touch_path_chipone ];
then
    wait_for_poweron

    echo 1 > $touch_path_fts/forcereflash
    echo $firmware_file_fts > $touch_path_fts/doreflash
fi

exit 0
