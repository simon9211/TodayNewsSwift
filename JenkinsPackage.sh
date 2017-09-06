#!/bin/sh
set -e
cd $(dirname $0)
echo | pwd

SCHEME_NAME=TodayNewsSwift
WORKSPACE_PATH=TodayNewsSwift.xcworkspace
PROFILE_NAME=` `

TIME_SCAMP=`date "+%Y%m%d%H"`
ArchivePath=JenkinsPackage/ArchivePath/${SCHEME_NAME}.xcarchive
PacketName=JenkinsPackage/IpaPath/${SCHEME_NAME}_${TIME_STAMP}.ipa

pod install --verbose --no-repo-update

##clean
xctool -workspace ${WORKSPACE_PATH} -scheme ${SCHEME_NAME} clean

##archive
xctool -workspace ${WORKSPACE_PATH} -scheme ${SCHEME_NAME} archive -archivePath ${ArchivePath} 

##export 
#xcodebuild -exportArchive -exportFormat IPA -archivePath ${ArchivePath} -exportPath ${PacketName} -exportProvisioningProfile "${PROFILE_NAME}"

