menu Channel {
  X Bot
  .500
  ..Set Channel Pref
  ...MassDeopPro:/msg X@channels.undernet.org set # massdeoppro $$?="Enter Max DeOps in 15sec Period?"
  ...NickFloodPro:/msg X@channels.undernet.org set # nickfloodpro $$?="Enter Max Nick Changes in 15sec Period?"
  ...FloodPro:/msg X@channels.undernet.org set # floodpro $$?="Enter Max Channel Actions in 15sec Period?"
  ...Description:/msg X@channels.undernet.org set # description $$?="Enter Official Channel Description?"
  ...URL:/msg X@channels.undernet.org set # url $$?="Enter Official Channel Homepage URL?"
  ...Default UserFlags
  ....AutoOp:/msg X@channels.undernet.org set # userflags 1
  ....Protect:/msg X@channels.undernet.org set # userflags 2
  ....Both:/msg X@channels.undernet.org set # userflags 3
  ...NoOp Mode
  ....ON:/msg X@channels.undernet.org set # noop on
  ....OFF:/msg X@channels.undernet.org set # noop off
  ...AlwaysOp X Mode
  ....ON:/msg X@channels.undernet.org set # alwaysop on
  ....OFF:/msg X@channels.undernet.org set # alwaysop off
  ...OpOnly Command
  ....ON:/msg X@channels.undernet.org set # oponly on
  ....OFF:/msg X@channels.undernet.org set # oponly off
  ...StrictOp Mode
  ....ON:/msg X@channels.undernet.org set # strictop on
  ....OFF:/msg X@channels.undernet.org set # strictop off
  .450
  ..AddChan:/msg X@channels.undernet.org addchan #
  ..Join:/msg X@channels.undernet.org join #
  ..Part:/msg X@channels.undernet.org part #
  ..RemChan:/msg  X@channels.undernet.org remchan #
  .400
  ..AddUser:/msg X@channels.undernet.org adduser # $$?="Entry Nick?" $?="Host Mask?" $?="Access Level?" $?="Password? [Optional]"
  ..ClearMode:/msg X@channels.undernet.org clearmode #
  ..ModInfo
  ...Flags
  ....AutoOp
  .....ON:/msg X@channels.undernet.org modinfo # autoop $$?="Entry Name?" on
  .....OFF:/msg X@channels.undernet.org modinfo # autoop $$?="Entry Name?" off
  ....Protect
  .....ON:/msg X@channels.undernet.org modinfo # protect $$?="Entry Name?" on
  .....OFF:/msg X@channels.undernet.org modinfo # protect $$?="Entry Name?" off
  ...Access
  ....499:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" 499
  ....450:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" 450
  ....400:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" 400
  ....100:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" 100
  ....75:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" 75
  ....50:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" 50
  ....0:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" 0
  ....Other:/msg X@channels.undernet.org modinfo # access $$?="Entry Name?" $?="Access Level?"
  ..RemUser:/msg X@channels.undernet.org remuser # $$?="Entry Name?"
  ..Status:/msg X@channels.undernet.org status #
  .100
  ..DeOp:/msg X@channels.undernet.org deop # $$?="Enter Nick?"
  ..Invite:/msg X@channels.undernet.org invite # $$?="Enter Nick?"
  ..Op:/msg X@channels.undernet.org op # $$?="Enter Nick?"
  ..Suspend:/msg X@channels.undernet.org suspend # $$?="Entry Name?" $?="Duration [s-m-h-d]"
  ..UnSuspend:/msg X@channels.undernet.org unsuspend # $$?="Entry Name?"
  .75
  ..Ban:/msg X@channels.undernet.org ban # $$?="Nick or HostMask?" $?="Duration" $?="Level (>=20 NoOp >=75 NoJoin)" $?="Reason? [Optional]"
  ..Unban:/msg X@channels.undernet.org unban # $$?="Nick or HostMask?"
  .50
  ..Kick:/msg X@channels.undernet.org kick # $$?="Nick or Host Pattern?" $?="Reason? [Optional]"
  ..Topic:/msg X@channels.undernet.org topic # $$?="New Topic?"
  .0
  ..Access
  ...Nick:/msg X@channels.undernet.org access # $$?="Nick?"
  ...List:/msg X@channels.undernet.org access # $$?="Options? See help for info."
  ..Banlist:/msg X@channels.undernet.org banlist #
  ..ChanInfo:/msg X@channels.undernet.org chaninfo #
  ..DeAuth:/msg X@channels.undernet.org deauth #
  ..Help:/msg X@channels.undernet.org help $$?="Topic?"
  ..LBanList:/msg X@channels.undernet.org lbanlist # $$?="Search Pattern?"
  ..Map:/msg X@channels.undernet.org map
  ..Motd:/msg X@channels.undernet.org motd
  ..NewPass:/msg X@channels.undernet.org newpass # $$?="New Password?"
  ..Pass:/msg X@channels.undernet.org pass # $$?="Password?"
  ..ShowCommands:/msg X@channels.undernet.org showcommands #
  ..ShowIgnore:/msg X@channels.undernet.org showignore
  ..Verify:/msg X@channels.undernet.org verify $$?="Nick?"
  .Help
  ..500
  ...Set:/msg X@channels.undernet.org help set
  ..450
  ...AddChan:/msg X@channels.undernet.org help addchan
  ...Join:/msg X@channels.undernet.org help join
  ...Part:/msg X@channels.undernet.org help part
  ...RemChan:/msg X@channels.undernet.org help remchan
  ..400
  ...AddUser:/msg X@channels.undernet.org help adduser
  ...ClearMode:/msg X@channels.undernet.org help clearmode
  ...ModInfo:/msg X@channels.undernet.org help modinfo
  ...RemUser:/msg X@channels.undernet.org help remuser
  ...Status:/msg X@channels.undernet.org help status
  ..100
  ...DeOp:/msg X@channels.undernet.org help deop
  ...Invite:/msg X@channels.undernet.org help invite
  ...Op:/msg X@channels.undernet.org help op
  ...Suspend:/msg X@channels.undernet.org help suspend
  ...UnSuspend:/msg X@channels.undernet.org help unsuspend
  ..75
  ...Ban:/msg X@channels.undernet.org help ban
  ...Unban:/msg X@channels.undernet.org help unban
  ..50
  ...Kick:/msg X@channels.undernet.org help kick
  ...Topic:/msg X@channels.undernet.org help topic
  ..0
  ...Access:/msg X@channels.undernet.org help access
  ...Banlist:/msg X@channels.undernet.org help banlist
  ...ChanInfo:/msg X@channels.undernet.org help chaninfo
  ...DeAuth:/msg X@channels.undernet.org help deauth
  ...Help:/msg X@channels.undernet.org help help
  ...LBanList:/msg X@channels.undernet.org help lbanlist
  ...Map:/msg X@channels.undernet.org help map
  ...Motd:/msg X@channels.undernet.org help motd
  ...NewPass:/msg X@channels.undernet.org help newpass
  ...Pass:/msg X@channels.undernet.org help pass
  ...ShowCommands:/msg X@channels.undernet.org help showcommands
  ...ShowIgnore:/msg X@channels.undernet.org help showignore
  ...Verify:/msg X@channels.undernet.org help verify
  W Bot
  .500
  ..Set Channel Pref
  ...MassDeopPro:/msg w@channels2.undernet.org set # massdeoppro $$?="Enter Max DeOps in 15sec Period?"
  ...NickFloodPro:/msg W@channels2.undernet.org set # nickfloodpro $$?="Enter Max Nick Changes in 15sec Period?"
  ...FloodPro:/msg W@channels2.undernet.org set # floodpro $$?="Enter Max Channel Actions in 15sec Period?"
  ...Description:/msg W@channels2.undernet.org set # description $$?="Enter Official Channel Description?"
  ...URL:/msg W@channels2.undernet.org set # url $$?="Enter Official Channel Homepage URL?"
  ...Default UserFlags
  ....AutoOp:/msg W@channels2.undernet.org set # userflags 1
  ....Protect:/msg W@channels2.undernet.org set # userflags 2
  ....Both:/msg W@channels2.undernet.org set # userflags 3
  ...NoOp Mode
  ....ON:/msg W@channels2.undernet.org set # noop on
  ....OFF:/msg W@channels2.undernet.org set # noop off
  ...AlwaysOp Z Mode
  ....ON:/msg W@channels2.undernet.org set # alwaysop on
  ....OFF:/msg W@channels2.undernet.org set # alwaysop off
  ...OpOnly Command
  ....ON:/msg W@channels2.undernet.org set # oponly on
  ....OFF:/msg W@channels2.undernet.org set # oponly off
  ...StrictOp Mode
  ....ON:/msg W@channels2.undernet.org set # strictop on
  ....OFF:/msg W@channels2.undernet.org set # strictop off
  .450
  ..AddChan:/msg W@channels2.undernet.org addchan #
  ..Join:/msg W@channels2.undernet.org join #
  ..Part:/msg W@channels2.undernet.org part #
  ..RemChan:/msg  W@channels2.undernet.org remchan #
  .400
  ..AddUser:/msg W@channels2.undernet.org adduser # $$?="Entry Nick?" $?="Host Mask?" $?="Access Level?" $?="Password? [Optional]"
  ..ClearMode:/msg W@channels2.undernet.org clearmode #
  ..ModInfo
  ...Flags
  ....AutoOp
  .....ON:/msg W@channels2.undernet.org modinfo # autoop $$?="Entry Name?" on
  .....OFF:/msg W@channels2.undernet.org modinfo # autoop $$?="Entry Name?" off
  ....Protect
  .....ON:/msg W@channels2.undernet.org modinfo # protect $$?="Entry Name?" on
  .....OFF:/msg W@channels2.undernet.org modinfo # protect $$?="Entry Name?" off
  ...Access
  ....499:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" 499
  ....450:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" 450
  ....400:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" 400
  ....100:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" 100
  ....75:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" 75
  ....50:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" 50
  ....0:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" 0
  ....Other:/msg W@channels2.undernet.org modinfo # access $$?="Entry Name?" $?="Access Level?"
  ..RemUser:/msg W@channels2.undernet.org remuser # $$?="Entry Name?"
  ..Status:/msg W@channels2.undernet.org status #
  .100
  ..DeOp:/msg W@channels2.undernet.org deop # $$?="Enter Nick?"
  ..Invite:/msg W@channels2.undernet.org invite # $$?="Enter Nick?"
  ..Op:/msg W@channels2.undernet.org op # $$?="Enter Nick?"
  ..Suspend:/msg W@channels2.undernet.org suspend # $$?="Entry Name?" $?="Duration [s-m-h-d]"
  ..UnSuspend:/msg W@channels2.undernet.org unsuspend # $$?="Entry Name?"
  .75
  ..Ban:/msg W@channels2.undernet.org ban # $$?="Nick or HostMask?" $?="Duration" $?="Level (>=20 NoOp >=75 NoJoin)" $?="Reason? [Optional]"
  ..Unban:/msg W@channels2.undernet.org unban # $$?="Nick or HostMask?"
  .50
  ..Kick:/msg W@channels2.undernet.org kick # $$?="Nick or Host Pattern?" $?="Reason? [Optional]"
  ..Topic:/msg W@channels2.undernet.org topic # $$?="New Topic?"
  .0
  ..Access
  ...Nick:/msg W@channels2.undernet.org access # $$?="Nick?"
  ...List:/msg W@channels2.undernet.org access # $$?="Options? See help for info."
  ..Banlist:/msg W@channels2.undernet.org banlist #
  ..ChanInfo:/msg W@channels2.undernet.org chaninfo #
  ..DeAuth:/msg W@channels2.undernet.org deauth #
  ..Help:/msg W@channels2.undernet.org help $$?="Topic?"
  ..LBanList:/msg W@channels2.undernet.org lbanlist # $$?="Search Pattern?"
  ..Map:/msg W@channels2.undernet.org map
  ..Motd:/msg W@channels2.undernet.org motd
  ..NewPass:/msg W@channels2.undernet.org newpass # $$?="New Password?"
  ..Pass:/msg W@channels2.undernet.org pass # $$?="Password?"
  ..ShowCommands:/msg W@channels2.undernet.org showcommands #
  ..ShowIgnore:/msg W@channels2.undernet.org showignore
  ..Verify:/msg W@channels2.undernet.org verify $$?="Nick?"
  .Help
  ..500
  ...Set:/msg W@channels2.undernet.org help set
  ..450
  ...AddChan:/msg W@channels2.undernet.org help addchan
  ...Join:/msg W@channels2.undernet.org help join
  ...Part:/msg W@channels2.undernet.org help part
  ...RemChan:/msg W@channels2.undernet.org help remchan
  ..400
  ...AddUser:/msg W@channels2.undernet.org help adduser
  ...ClearMode:/msg W@channels2.undernet.org help clearmode
  ...ModInfo:/msg W@channels2.undernet.org help modinfo
  ...RemUser:/msg W@channels2.undernet.org help remuser
  ...Status:/msg W@channels2.undernet.org help status
  ..100
  ...DeOp:/msg W@channels2.undernet.org help deop
  ...Invite:/msg W@channels2.undernet.org help invite
  ...Op:/msg W@channels2.undernet.org help op
  ...Suspend:/msg W@channels2.undernet.org help suspend
  ...UnSuspend:/msg W@channels2.undernet.org help unsuspend
  ..75
  ...Ban:/msg W@channels2.undernet.org help ban
  ...Unban:/msg W@channels2.undernet.org help unban
  ..50
  ...Kick:/msg W@channels2.undernet.org help kick
  ...Topic:/msg W@channels2.undernet.org help topic
  ..0
  ...Access:/msg W@channels2.undernet.org help access
  ...Banlist:/msg W@channels2.undernet.org help banlist
  ...ChanInfo:/msg W@channels2.undernet.org help chaninfo
  ...DeAuth:/msg W@channels2.undernet.org help deauth
  ...Help:/msg W@channels2.undernet.org help help
  ...LBanList:/msg W@channels2.undernet.org help lbanlist
  ...Map:/msg W@channels2.undernet.org help map
  ...Motd:/msg W@channels2.undernet.org help motd
  ...NewPass:/msg W@channels2.undernet.org help newpass
  ...Pass:/msg W@channels2.undernet.org help pass
  ...ShowCommands:/msg W@channels2.undernet.org help showcommands
  ...ShowIgnore:/msg W@channels2.undernet.org help showignore
  ...Verify:/msg W@channels2.undernet.org help verify
}
