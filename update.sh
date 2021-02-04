#! /bin/bash

git reset --hard
git branch -D $1

if [ "$1" == "stock-clang" ];then
    NameKernel="Stock CFW Clang"
    JsonLocation="$(pwd)/begonia-stock-clang.json"
    
fi

if [ "$1" == "stock-dtc" ];then
    NameKernel="Stock CFW DTC"
    JsonLocation="$(pwd)/begonia-stock-dtc.json"
fi

if [ "$1" == "stock-gcc" ];then
    NameKernel="Stock CFW GCC"
    JsonLocation="$(pwd)/begonia-stock-dtc.json"
fi

if [ "$1" == "stock-memeui-clang" ];then
    NameKernel="Stock RiP-CFW Clang"
    JsonLocation="$(pwd)/begonia-memeui-stock-clang.json"
    
fi

if [ "$1" == "stock-memeui-dtc" ];then
    NameKernel="Stock RiP-CFW DTC"
    JsonLocation="$(pwd)/begonia-memeui-stock-dtc.json"
fi

if [ "$1" == "stock-memeui-gcc" ];then
    NameKernel="Stock RiP-CFW GCC"
    JsonLocation="$(pwd)/begonia-memeui-stock-dtc.json"
fi

if [ -z "$NameKernel" ] && [ -z "$NameKernel" ];then
    echo 'oops . . .'
else
    echo "$KernelFiles" 
    SHA1CHECK=$(sha1sum "${KernelFiles}" | cut -d' ' -f1)
    git checkout -b $1
    sed -i "s/"'name": .*'"/"'name": "'"${NameKernel}"'",'"/g" "$JsonLocation"
    if [[ "$1" == *"stock"*  ]];then
        sed -i "s/"'link": "link-kernel.*'"/"'link": "https:\/\/osdn.dl.osdn.net\/storage\/g\/z\/zy\/zyc-kernels\/Begonia\/AOSP-CFW\/Stock\/'"${GetCBD}\/${ZipName}"'",'"/g" "$JsonLocation"
    fi
    sed -i "s/"'date": .*'"/"'date": "'"${GetCBD}"'",'"/g" "$JsonLocation"
    sed -i "s/"'version": .*'"/"'version": "'"${KVer}-${HeadCommitId}"'",'"/g" "$JsonLocation"
    sed -i "s/"'sha1": .*'"/"'sha1": "'"${SHA1CHECK}"'"'"/g" "$JsonLocation"
    git add . && git commit -s -m 'update' && git push -f origin $1
    git checkout master
fi
