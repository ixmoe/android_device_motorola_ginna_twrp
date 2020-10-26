#!/system/bin/sh

module_path=/sbin/modules

touch_path=/sys/chipone-tddi
firmware_path=/vendor/firmware
firmware_file=chipone-tianma-ICNL9911S-0125-0000-ginna.bin

wait_for_poweron()
{
	local wait_nomore
	local readiness
	local count
	wait_nomore=60
	count=0
	while true; do
		readiness=$(cat $touch_path/poweron)
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

# Load all needed modules
insmod $module_path/sensors_class.ko
insmod $module_path/fpc1020_mmi.ko
insmod $module_path/goodix_fod_mmi.ko
insmod $module_path/utags.ko
insmod $module_path/exfat.ko
insmod $module_path/mmi_annotate.ko
insmod $module_path/mmi_info.ko
insmod $module_path/mmi_sys_temp.ko
insmod $module_path/moto_f_usbnet.ko
insmod $module_path/snd_smartpa_aw882xx.ko

wait_for_poweron

echo 1 > $touch_path/forcereflash
echo $firmware_path/$firmware_file > $touch_path/doreflash
sleep 5
echo 1 > $touch_path/reset

return 0

