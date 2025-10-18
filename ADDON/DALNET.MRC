on 1:load: { 
  set %cs msg chanserv 
  set %ns msg nickserv  
  set %ms msg memoserv 
  set %fgsd  9,2FluxGear by ^ZiggY^ 9,2Dalnet services 
  intro
}
alias intro {
  echo -a %fgsd 
}
menu menubar {
  -
  DALnet Services
  .Chanserv
  ..Info:/ $+ %cs info $$?="Enter a channel:"
  ..Register:/ $+ %cs register $$?="Enter a channel:" $$?="Enter a password:" $$?="Enter a description"
  ..Drop:/ $+%cs drop $$?="Enter a channel:"
  ..Identify:/ $+ %cs identify $$?="Enter a channel:" $$?="Enter a password"
  ..Find Access Level:/ $+%cs access $$?="Enter a channel:" $$?="Enter a nick"
  ..Find Reason for Opping:/ $+ %cs why $$?="Enter a channel:" $$?="Enter a nick"
  ..Invite Yourself:/ $+ %cs invite $$?="Enter a channel:"
  ..Mass Kick:/ $+ %cs mkick $$?="Enter a channel:"
  ..Get Help:/ $+ %cs help $?="Enter command, leave blank for general help:"
  ..Settings
  ...Set Yourself as Founder:/ $+ %cs set $$?="Enter a channel:" founder
  ...Change Password:/ $+ %cs set $$?="Enter a channel:" passwd $$?="Enter a password"
  ...Change Description:/ $+ %cs set $$?="Enter a channel:" desc $$?="Enter a description"
  ...Change URL:/ $+ %cs set $$?="Enter a channel:" url $?="Enter channel homepage/your email addy, or leave blank to clear"
  ...Mode Lock:/ $+ %cs set $$?="Enter a channel:" mlock $$?="Enter new modes. Unable to set +ovblk or -ovb. Use * to clear"
  ...Sticky Topics
  ....On:/ $+ %cs set $$?="Enter a channel" keeptopic on
  ....Off:/ $+ %cs set $$?="Enter a channel" keeptopic off
  ...Topic Lock
  ....On:/ $+ %cs set $$?="Enter a channel" topiclock on
  ....Off:/ $+ %cs set $$?="Enter a channel" topiclock off
  ...Op Guard
  ....On:/ $+ %cs set $$?="Enter a channel:" keeptopic on
  ....Off:/ $+ %cs set $$?="Enter a channel:" keeptopic off
  ...Don't Deop Non-Ops
  ....On:/ $+ %cs set $$?="Enter a channel:" leaveops on
  ....Off:/ $+ %cs set $$?="Enter a channel:" leaveops off
  ..Only allow AOPs/SOPs/Founder
  ....On:/ $+ %cs set $$?="Enter a channel:" restrict on
  ....Off:/ $+ %cs set $$?="Enter a channel:" restrict off
  ...Don't Require Founder Identification
  ....On:/ $+ %cs set $$?="Enter a channel:" unsecure on
  ....Off:/ $+ %cs set $$?="Enter a channel:" unsecure off
  ...Make Ops Identify Before Being Opped
  ....On:/ $+ %cs set $$?="Enter a channel:" ident on
  ....Off:/ $+ %cs set $$?="Enter a channel:" ident off
  ...Disable Info and Invite
  ....On:/ $+ %cs set $$?="Enter a channel:" private on
  ....Off:/ $+ %cs set $$?="Enter a channel:" private off
  ...Change Memo Level
  ....AOP:/ $+ %cs set $$?="Enter a channel:" memo aop
  ....SOP:/ $+ %cs set $$?="Enter a channel:" memo sop
  ....Founder:/ $+ %cs set $$?="Enter a channel" memo founder
  ....Off:/ $+ %cs set $$?="Enter a channel" memo none
  ..Out of Order
  ...List:/echo 4 CS List is currently down
  ..List Mantenince
  ...AOP List Mantenince
  ....Add an AOP:/ $+ %cs aop $$?="Enter a channel:" add $$?="Enter a nick or addy:"
  ....Remove an AOP:/ $+ %cs aop $$?="Enter a channel:" del $$?="Enter a nick or addy:"
  ....List AOPs:/ $+ %cs aop $$?="Enter a channel:" list
  ....Clear AOP List:/ $+ %cs aop $$?="Enter a channel:" wipe
  ....Remove Unregistered AOPs:/ $+ %cs aop $$?="Enter a channel:" clean
  ...SOP List Mantenince
  ....Add a SOP:/ $+ %cs sop $$?="Enter a channel:" add $$?="Enter a nick or addy:"
  ....Remove a SOP:/ $+ %cs sop $$?="Enter a channel:" del $$?="Enter a nick or addy:"
  ....List SOPs:/ $+ %cs sop $$?="Enter a channel:" list
  ....Clear SOP List:/ $+ %cs sop $$?="Enter a channel:" wipe
  ....Remove Unregistered SOPs:/ $+ %cs sop $$?="Enter a channel:" clean
  ...AKICK List Mantenince
  ....Add an AKICK:/ $+ %cs akick $$?="Enter a channel:" add $$?="Enter a nick or addy:"
  ....Remove an AKICK:/ $+ %cs akick $$?="Enter a channel:" del $$?="Enter a nick or addy:"
  ....List AKICKs:/ $+ %cs akick $$?="Enter a channel:" list
  ....Clear AKICK List:/ $+ %cs akick $$?="Enter a channel:" wipe
  ...Non-List Op Mantenince
  ....Op:/ $+ %cs op $$?="Enter a channel:" $$?="Enter a nick:"
  ....Deop:/ $+ %cs deop $$?="Enter a channel:" $$?="Enter a nick:"
  ....Mass Deop:/ $+ %cs mdeop $$?="Enter a channel:"
  ...Count AOPs/SOPs/AKICKs:/ $+ %cs count $$?="Enter a channel:"
  .Nickserv
  ..Register:/ $+ %ns register $$?="Enter a password:"
  ..Drop:/ $+ %ns drop $$?="Enter a nick:"
  ..Identify:/ $+ %ns identify $$?="Enter a password:" 
  ..Kill:/ $+ %ns recover $$?="Enter a nick:" $?="Enter a password if the nick's addy isn't in your access list:"
  ..Kill Enforcer:/ $+ %ns release $$?="Enter a nick:" $?="Enter a password if the nick's addy isn't in your access list:"
  ..Kill Ghost:/ $+ %ns ghost $$?="Enter a nick:" $?="Enter a password if the nick's addy isn't in your access list:"
  ..Get Access Level:/ $+ %ns acc $$?="Enter a nick:"
  ..Get ID Number:/ $+ %ns id $$?="Enter a nick:"
  ..Info:/ $+ %ns info $$?="Enter a nick:"
  ..Get Help:/ $+ %ns help $?="Enter command, leave blank for general help:"
  ..Access List Mantenince
  ...Add an Addy:/ $+ %ns access add $$?="Enter an addy:"
  ...Remove an Addy:/ $+ %ns access del $$?="Enter an addy:"
  ...List Access Masks:/ $+ %ns access list
  ...Clear Access List:/ $+ %ns access wipe
  ..Settings
  ...Kill
  ....On:/ $+ %ns set kill on
  ....Off:/ $+ %ns set kill off
  ...Disable Memos
  ....On:/ $+ %ns set nomemo on
  ....Off:/ $+ %ns set nomemo off
  ...Prevent Being Added to AOP/SOP Lists
  ....On:/ $+ %ns set noop on
  ....Off:/ $+ %ns set noop off
  ...Require identification
  ....On:/ $+ %ns set secure on
  ....Off:/ $+ %ns set secure off
  ...URL:/ $+ %ns set url $?="Enter home page/email addy. To clear, leave blank:"
  ...Change Password:/ $+ %ns set passwd $$?="Enter a password"
  .Memoserv
  ..Send a Memo:/ $+ %ms send $$?="Enter a nick(s), channel, or memo number:" $$?="Enter your memo"
  ..Send a Memo to SOPs/Founder:/ $+ %ms send $$?="Enter a channel:" $$?="Enter your memo"
  ..List Memos:/ $+ %ms list
  ..Read a Memo:/ $+ %ms read $$?="Enter a memo number(s):"
  ..Delete a Memo:/ $+ %ms del $$?="Enter a memo number. To delete ad purge all memos, type all:"
  ..Undelete a Memo:/ $+ %ms undel $$?="Enter a memo number:"
  ..Purge Deleted Memos:/ $+ %ms purge
  ..Forward Memos:/ $+ %ms forward $?="Enter a nick. To stop forwarding, type -. To show forwarding nick, leave blank:"
  ..Get Help:/ $+ %ms help $?="Enter command, leave blank for general help:"
}
alias sping {
  set %sping.time $ctime
  raw -q TIME $server
}
