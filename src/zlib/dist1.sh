DIST_ROOT=$1
LIB_NAME=zlib
DIST_DIR="${DIST_ROOT}/${LIB_NAME}"

copy_inc_and_libs ${LIB_NAME} ${DIST_DIR}

# create flat lib for ios
if [ -f "install_ios_arm/${LIB_NAME}/lib/libz.a" ] ; then
  lipo -create install_ios_arm/${LIB_NAME}/lib/libz.a install_ios_arm64/${LIB_NAME}/lib/libz.a install_ios_x64/${LIB_NAME}/lib/libz.a -output ${DIST_DIR}/prebuilt/ios/libz.a
else
  lipo -create install_ios_arm64/${LIB_NAME}/lib/libz.a install_ios_x64/${LIB_NAME}/lib/libz.a -output ${DIST_DIR}/prebuilt/ios/libz.a
fi

# check the flat lib
lipo -info ${DIST_DIR}/prebuilt/ios/libz.a

# create fat lib for mac
lipo -create install_osx_arm64/${LIB_NAME}/lib/libz.a install_osx_x64/${LIB_NAME}/lib/libz.a -output ${DIST_DIR}/prebuilt/mac/libz.a

# check the fat lib
lipo -info ${DIST_DIR}/prebuilt/ios/libz.a
