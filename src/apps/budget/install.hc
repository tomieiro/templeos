Cd(__DIR__);;
if (!FileFind("~/budget",,FUF_JUST_DIRS)) {
  DirMk("~/budget");
  Copy("accts.dd.Z","~/budget");
}
