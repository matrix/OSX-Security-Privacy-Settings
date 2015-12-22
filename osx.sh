#!/bin/bash
# Author: Gabriele Gristina <gm4tr1x@users.noreply.github.com>
# Revision: 1.0

function agent {
	if [ $# -ne 2 ]; then
		exit 1
	fi

	if [ "$2" == "enable" ]; then
		#echo "Enabling ${1}"
		launchctl load -w /System/Library/LaunchAgents/${1}.plist
	else
		#echo "Disabling ${1}"
		launchctl unload -w /System/Library/LaunchAgents/${1}.plist
	fi
}

function daemon {
	if [ $# -ne 2 ]; then
		exit 1
	fi

	if [ "$2" == "enable" ]; then
		#echo "Enabling ${1}"
		sudo launchctl load -w /System/Library/LaunchDaemons/${1}.plist
	else
		#echo "Disabling ${1}"
		sudo launchctl unload -w /System/Library/LaunchDaemons/${1}.plist
	fi
}

action="disable"
if [ $# -eq 1 ]; then
	if [ "$1" == "enable" ]; then
		action="enable"
	fi
fi

#agent com.apple.pbs ${action}
#agent com.apple.security.cloudkeychainproxy ${action}
#agent com.apple.syncdefaultsd ${action}
agent com.apple.AOSHeartbeat ${action}
agent com.apple.AOSPushRelay ${action}
agent com.apple.AddressBook.SourceSync ${action}
agent com.apple.AirPlayUIAgent ${action}
agent com.apple.CalendarAgent ${action}
agent com.apple.CallHistoryPluginHelper ${action}
agent com.apple.CallHistorySyncHelper ${action}
agent com.apple.CoreLocationAgent ${action}
agent com.apple.EscrowSecurityAlert ${action}
agent com.apple.IMLoggingAgent ${action}
agent com.apple.SafariCloudHistoryPushAgent ${action}
agent com.apple.SafariNotificationAgent ${action}
agent com.apple.SocialPushAgent ${action}
agent com.apple.bird ${action}
agent com.apple.cloudd ${action}
agent com.apple.cloudfamilyrestrictionsd-mac ${action}
agent com.apple.cloudpaird ${action}
agent com.apple.cloudphotosd ${action}
agent com.apple.coreservices.appleid.authentication ${action}
agent com.apple.findmymacmessenger ${action}
agent com.apple.gamed ${action}
agent com.apple.helpd ${action}
agent com.apple.icloud.fmfd ${action}
agent com.apple.idsremoteurlconnectionagent ${action}
agent com.apple.imagent ${action}
agent com.apple.locationmenu ${action}
agent com.apple.notificationcenterui ${action}
agent com.apple.rtcreportingd ${action}
agent com.apple.safaridavclient ${action}
agent com.apple.telephonyutilities.callservicesd ${action}

if [ "${action}" == "enable" ]; then
	defaults write com.apple.CrashReporter DialogType crashreport
else
	defaults write com.apple.CrashReporter DialogType none
fi

if [ "${action}" == "enable" ]; then
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool true
else
	defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
fi

# disable daemon

#daemon com.apple.AirPlayXPCHelper ${action}
#daemon com.apple.airplaydiagnostics.server.mac ${action}
daemon com.apple.AssetCacheLocatorService ${action}
daemon com.apple.CrashReporterSupportHelper ${action}
daemon com.apple.GameController.gamecontrollerd ${action}
daemon com.apple.SubmitDiagInfo ${action}
daemon com.apple.TMCacheDelete ${action}
daemon com.apple.apsd ${action}
daemon com.apple.awacsd ${action}
daemon com.apple.awdd ${action}
daemon com.apple.blued ${action}
daemon com.apple.bluetoothReporter ${action}
daemon com.apple.bluetoothaudiod ${action}
daemon com.apple.icloud.findmydeviced ${action}
daemon com.apple.ifdreader ${action}
daemon com.apple.locationd ${action}
daemon com.apple.lockd ${action}
daemon com.apple.mDNSResponder ${action}
daemon com.apple.mDNSResponderHelper ${action}
daemon com.apple.netbiosd ${action}
daemon com.apple.spindump ${action}
daemon com.apple.usbmuxd ${action}
daemon org.ntp.ntpd ${action}

if [ "${action}" == "enable" ]; then
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool true
else
	sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
fi
