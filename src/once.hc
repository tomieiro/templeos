//Place this file in /Home and change
//anything you want.

//This file is executed by the
//first terminal window upon start-up.
//See $LK,"Once",A="FF:~/home_sys.hc,Once"$ and $LK,"Home Files",A="FF:::/doc/guide_lines.dd,/Home Files"$.

//Delete the rest from this file.

U0 Tmp()
{
  OnceExe;
  switch (sys_boot_src.u16[0]) {
    case BOOT_SRC_ROM:
      "Continue booting hard drive ";
      if (YorN) {
	DocBottom;
	ExeFile("C:/home/Once");
      }
      break;
    case BOOT_SRC_DVD:
      "\nIf you answer 'No' you can play with\n"
	    "the live CD without installing.\n\n"
	    "Install onto hard drive ";
      if (YorN) {
	DocBottom;
	RunFile("::/misc/OSInstall",,TRUE);
      }
      if (FileFind("::/misc/tour")) {
	"\nTake Tour";
	if (YorN) {
	  DocBottom;
	  Cd("::/misc/tour");
	  InFile("Tour");
	}
      }
      break;
    case BOOT_SRC_RAM:
    case BOOT_SRC_HARDDRV:
      "$$PURPLE$$$$TX+CX,\"Tip of the Day\"$$$$FG$$\n";
      TipOfDay;
      Type("::/doc/customize.dd");
      if (FileFind("::/misc/tour")) {
	"\nTake Tour";
	if (YorN) {
	  DocBottom;
	  Cd("::/misc/tour");
	  InFile("Tour");
	}
      }
      break;
  }
}

Tmp;
