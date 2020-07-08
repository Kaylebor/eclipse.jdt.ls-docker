#!/bin/bash

launcher_file_name=$(find ./plugins -name "org.eclipse.equinox.launcher_*.jar" | sort | head -n 1)
java_version=$(java -version 2>&1 | grep version | awk '{print $3}' | sed 's|"||g' | cut -d'_' -f1 | cut -s -d'.' -f 1,2)

java_args="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.level=ALL -noverify -Xmx1G \
    -jar $launcher_file_name \
    -configuration ./config_linux \
    -data $ECLIPSE_WORKSPACE"

[[ $java_version -gt 1.8 ]] && java_args+=" --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED"

java $(sed 's|\n||g' <<< $java_args | tr -s ' ')