//See $LK,"Install Documentation",A="FI:::/doc/install.dd"$.
//Study my account examples: $LK,"Cfg Strs",A="FL:::/demo/acctexample/tos/tos_cfg.hc,1"$, $LK,"Update Funs",A="FL:::/demo/acctexample/tos/tos_distro.hc,1"$

#include "BootDVD"
#include "DskISORedSea"

#help_index "Install"

#define KERNEL_BIN_C	"Kernel.BIN.C"
#define BOOT_DIR	"/0000boot"
#define BOOT_DIR_KERNEL_BIN_C	BOOT_DIR "/0000" KERNEL_BIN_C

U0 MakeAll()
{
  if (Cmp("/compiler/compiler","Compiler",,':'))
    throw;
  if (Cmp("/kernel/kernel","Kernel",,':'))
    throw;
}

public U0 BootDVDIns(U8 drv_let=0)
{//See $LK,"::/misc/do_distro.hc"$.
  try {
    if (!Drv(drv_let))
      throw;
    MakeAll;
    Move("/kernel/Kernel.BIN.Z",BOOT_DIR_KERNEL_BIN_C);
  } catch {
    PutExcept;
    Beep;
  }
}
