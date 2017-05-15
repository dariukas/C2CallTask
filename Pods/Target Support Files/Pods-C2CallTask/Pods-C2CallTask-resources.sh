#!/bin/sh
set -e

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

case "${TARGETED_DEVICE_FAMILY}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}"
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\""
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\""
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH"
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "C2Call-SDK/Pod/Assets/AdWhirlWebBrowser.xib"
  install_resource "C2Call-SDK/Pod/Assets/area_codes.xml"
  install_resource "C2Call-SDK/Pod/Assets/BusyTone.wav"
  install_resource "C2Call-SDK/Pod/Assets/callme.wav"
  install_resource "C2Call-SDK/Pod/Assets/country_code.xml"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-0.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-1.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-2.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-3.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-4.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-5.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-6.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-7.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-8.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-9.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-hash.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-star.wav"
  install_resource "C2Call-SDK/Pod/Assets/EAGLViewController.xib"
  install_resource "C2Call-SDK/Pod/Assets/error.wav"
  install_resource "C2Call-SDK/Pod/Assets/get_msg.wav"
  install_resource "C2Call-SDK/Pod/Assets/GroupActiveMemberCell.xib"
  install_resource "C2Call-SDK/Pod/Assets/GroupActiveMemberController.xib"
  install_resource "C2Call-SDK/Pod/Assets/holdtheline.wav"
  install_resource "C2Call-SDK/Pod/Assets/Message Tone.aiff"
  install_resource "C2Call-SDK/Pod/Assets/Message Tone.wav"
  install_resource "C2Call-SDK/Pod/Assets/message.wav"
  install_resource "C2Call-SDK/Pod/Assets/messagebeep.wav"
  install_resource "C2Call-SDK/Pod/Assets/myshader.fsh"
  install_resource "C2Call-SDK/Pod/Assets/myshader.vsh"
  install_resource "C2Call-SDK/Pod/Assets/np-1.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-20.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-211.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-212.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-213.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-216.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-218.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-220.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-221.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-222.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-223.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-224.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-225.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-226.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-227.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-228.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-229.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-230.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-231.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-232.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-233.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-234.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-235.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-236.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-237.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-238.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-239.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-240.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-241.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-242.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-243.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-244.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-245.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-246.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-247.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-248.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-249.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-250.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-251.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-252.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-253.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-254.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-255.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-256.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-257.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-258.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-260.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-261.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-262.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-263.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-264.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-265.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-266.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-267.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-268.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-269.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-27.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-290.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-291.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-297.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-298.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-299.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-30.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-31.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-32.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-33.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-34.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-350.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-351.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-352.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-353.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-354.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-355.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-356.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-357.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-358.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-359.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-36.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-370.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-371.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-372.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-373.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-374.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-375.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-376.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-377.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-378.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-379.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-380.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-381.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-382.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-385.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-386.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-387.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-388.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-389.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-39.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-40.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-41.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-420.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-421.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-423.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-43.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-44.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-45.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-46.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-47.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-48.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-49.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-500.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-501.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-502.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-503.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-504.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-505.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-506.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-507.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-508.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-509.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-51.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-52.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-53.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-54.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-55.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-56.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-57.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-58.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-590.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-591.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-592.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-593.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-594.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-595.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-596.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-597.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-598.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-599.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-60.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-61.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-62.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-63.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-64.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-65.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-66.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-670.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-672.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-673.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-674.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-675.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-676.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-677.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-678.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-679.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-680.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-681.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-682.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-683.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-685.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-686.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-687.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-688.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-689.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-690.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-691.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-692.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-699.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-7.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-800.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-808.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-81.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-82.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-84.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-850.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-852.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-853.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-855.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-856.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-86.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-870.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-878.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-880.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-881.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-882.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-883.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-886.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-888.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-90.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-91.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-92.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-93.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-94.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-95.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-960.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-961.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-962.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-963.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-964.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-965.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-966.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-967.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-968.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-970.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-971.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-972.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-973.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-974.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-975.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-976.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-977.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-979.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-98.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-991.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-992.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-993.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-994.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-995.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-996.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-998.xml"
  install_resource "C2Call-SDK/Pod/Assets/offerwall.wav"
  install_resource "C2Call-SDK/Pod/Assets/ringout.wav"
  install_resource "C2Call-SDK/Pod/Assets/ringtone-bg.aif"
  install_resource "C2Call-SDK/Pod/Assets/ringtone.wav"
  install_resource "C2Call-SDK/Pod/Assets/SCStoryboard.storyboard"
  install_resource "C2Call-SDK/Pod/Assets/SearchTableCell.xib"
  install_resource "C2Call-SDK/Pod/Assets/send_msg.wav"
  install_resource "C2Call-SDK/Pod/Assets/US-AreaCodes.xml"
  install_resource "C2Call-SDK/Pod/Assets/C2CallDataModel.xcdatamodeld"
  install_resource "C2Call-SDK/Pod/Assets/SocialCommunication.xcassets"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "C2Call-SDK/Pod/Assets/AdWhirlWebBrowser.xib"
  install_resource "C2Call-SDK/Pod/Assets/area_codes.xml"
  install_resource "C2Call-SDK/Pod/Assets/BusyTone.wav"
  install_resource "C2Call-SDK/Pod/Assets/callme.wav"
  install_resource "C2Call-SDK/Pod/Assets/country_code.xml"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-0.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-1.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-2.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-3.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-4.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-5.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-6.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-7.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-8.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-9.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-hash.wav"
  install_resource "C2Call-SDK/Pod/Assets/Dtmf-star.wav"
  install_resource "C2Call-SDK/Pod/Assets/EAGLViewController.xib"
  install_resource "C2Call-SDK/Pod/Assets/error.wav"
  install_resource "C2Call-SDK/Pod/Assets/get_msg.wav"
  install_resource "C2Call-SDK/Pod/Assets/GroupActiveMemberCell.xib"
  install_resource "C2Call-SDK/Pod/Assets/GroupActiveMemberController.xib"
  install_resource "C2Call-SDK/Pod/Assets/holdtheline.wav"
  install_resource "C2Call-SDK/Pod/Assets/Message Tone.aiff"
  install_resource "C2Call-SDK/Pod/Assets/Message Tone.wav"
  install_resource "C2Call-SDK/Pod/Assets/message.wav"
  install_resource "C2Call-SDK/Pod/Assets/messagebeep.wav"
  install_resource "C2Call-SDK/Pod/Assets/myshader.fsh"
  install_resource "C2Call-SDK/Pod/Assets/myshader.vsh"
  install_resource "C2Call-SDK/Pod/Assets/np-1.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-20.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-211.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-212.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-213.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-216.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-218.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-220.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-221.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-222.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-223.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-224.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-225.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-226.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-227.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-228.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-229.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-230.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-231.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-232.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-233.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-234.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-235.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-236.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-237.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-238.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-239.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-240.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-241.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-242.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-243.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-244.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-245.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-246.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-247.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-248.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-249.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-250.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-251.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-252.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-253.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-254.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-255.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-256.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-257.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-258.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-260.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-261.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-262.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-263.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-264.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-265.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-266.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-267.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-268.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-269.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-27.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-290.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-291.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-297.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-298.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-299.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-30.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-31.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-32.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-33.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-34.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-350.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-351.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-352.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-353.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-354.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-355.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-356.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-357.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-358.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-359.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-36.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-370.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-371.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-372.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-373.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-374.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-375.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-376.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-377.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-378.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-379.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-380.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-381.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-382.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-385.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-386.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-387.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-388.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-389.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-39.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-40.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-41.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-420.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-421.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-423.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-43.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-44.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-45.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-46.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-47.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-48.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-49.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-500.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-501.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-502.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-503.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-504.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-505.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-506.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-507.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-508.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-509.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-51.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-52.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-53.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-54.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-55.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-56.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-57.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-58.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-590.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-591.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-592.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-593.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-594.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-595.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-596.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-597.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-598.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-599.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-60.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-61.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-62.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-63.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-64.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-65.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-66.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-670.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-672.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-673.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-674.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-675.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-676.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-677.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-678.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-679.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-680.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-681.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-682.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-683.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-685.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-686.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-687.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-688.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-689.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-690.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-691.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-692.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-699.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-7.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-800.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-808.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-81.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-82.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-84.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-850.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-852.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-853.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-855.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-856.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-86.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-870.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-878.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-880.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-881.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-882.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-883.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-886.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-888.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-90.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-91.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-92.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-93.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-94.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-95.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-960.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-961.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-962.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-963.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-964.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-965.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-966.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-967.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-968.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-970.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-971.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-972.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-973.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-974.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-975.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-976.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-977.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-979.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-98.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-991.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-992.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-993.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-994.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-995.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-996.xml"
  install_resource "C2Call-SDK/Pod/Assets/np-998.xml"
  install_resource "C2Call-SDK/Pod/Assets/offerwall.wav"
  install_resource "C2Call-SDK/Pod/Assets/ringout.wav"
  install_resource "C2Call-SDK/Pod/Assets/ringtone-bg.aif"
  install_resource "C2Call-SDK/Pod/Assets/ringtone.wav"
  install_resource "C2Call-SDK/Pod/Assets/SCStoryboard.storyboard"
  install_resource "C2Call-SDK/Pod/Assets/SearchTableCell.xib"
  install_resource "C2Call-SDK/Pod/Assets/send_msg.wav"
  install_resource "C2Call-SDK/Pod/Assets/US-AreaCodes.xml"
  install_resource "C2Call-SDK/Pod/Assets/C2CallDataModel.xcdatamodeld"
  install_resource "C2Call-SDK/Pod/Assets/SocialCommunication.xcassets"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi