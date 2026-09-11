Cd(__DIR__);;

//If these are not present in /Home, it uses the version in the root dir.  You
//can make your own, modified, version of these files in your /Home directory.
#include "~/HomeLocalize"
#include "/adam/opt/boot/MakeBoot"
#include "/adam/opt/utils/MakeUtils"
#include "~/HomeWrappers"
MapFileLoad("::/kernel/kernel");
MapFileLoad("::/compiler/compiler");

#include "::/apps/psalmody/Load"
#include "~/tos/MakeTOS"
#include "~/HomeKeyPlugIns"
#include "~/HomeSys"
Cd("..");;
