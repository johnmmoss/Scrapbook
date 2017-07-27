
gci E:\agent\_work |  % {

    $lastWriteTime = gci $_ -Recurse | sort LastWriteTime -Descending | select LastWriteTime -First 1

    write-host "$($_.FullName) $($lastWriteTime.LastWriteTime)"
}

gci $_ -Recurse | sort LastWriteTime -Descending | select LastWriteTime -First 1
