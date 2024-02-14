adb shell uiautomator dump
wait
adb pull /sdcard/window_dump.xml .
wait
cat window_dump.xml