//The CFG defines are $LK,"~/tos/tos_cfg.hc",A="FI:::/demo/acctexample/tos/tos_cfg.hc"$.

#help_index "Misc/tos/Distro"

#define MAKE_LITE	1
#define MAKE_DBG	0
#define MAKE_STAFF	1

public U8 TOSGetDrv()
{//Pmt for drv let.
  I64 res;
  "Drive (%s):",TOS_HDS;
  res=Let2Let(GetChar);
  '\n';
  return res;
}

public U0 TOSBootHDIns(U8 drv_let=0)
{//Make Compiler and Kernel. Reinstall Kernel.
  drv_let=Let2Let(drv_let);
  In(TOS_CFG);
  BootHDIns(drv_let);
  if (StrOcc(TOS_MASTER_BOOT_DRVS,drv_let))
    BootMHDIns(drv_let);
}

public U0 TOSCopyDrv(U8 src,U8 dst)
{//Fmt dst and copy entire drv.
  U8 buf_s[STR_LEN],buf_d[STR_LEN];
  src=Let2Let(src);
  dst=Let2Let(dst);

  if (dst=='D')
    Fmt(dst,,FALSE,FSt_FAT32);
  else
    Fmt(dst,,FALSE,FSt_REDSEA);

  StrPrint(buf_s,"%c:/",src);
  StrPrint(buf_d,"%c:/",dst);
  CopyTree(buf_s,buf_d);

  DocClear;
  Drv(dst);
  TOSBootHDIns(dst);
}

public U0 TOSPmtAndCopyDrv()
{//Pmt for drv lets. Then, Fmt dst and copy entire drv.
   I64 src,dst;
  "$$RED$$\nCopy Src Drive:\n$$FG$$";
  src=TOSGetDrv;
  "$$RED$$\nCopy Dst Drive:\n$$FG$$";
  dst=TOSGetDrv;
  TOSCopyDrv(src,dst);
}

U0 DistroPrep()
{
  AOnceFlush; //Don't want in Registry
  OnceFlush;

  Del("/home/Demo*");
  DelTree("/home/*Tmp.DD.Z");

  DelTree("/Tmp");
  DirMk("/Tmp");
  DirMk("/Tmp/ScrnShots");

  Touch("/personal_menu.dd.Z","+T");
  Touch("/home/personal_menu.dd.Z","+T");

  DelTree("/demo/acctexample");
  CopyTree("/home","/demo/acctexample");
  DelTree("/demo/acctexample/TAD");
  DelTree("/demo/acctexample/Sup1");
  DelTree("/demo/acctexample/Sup2");
  DelTree("/demo/acctexample/Sup3");
  Del("/demo/acctexample/Test*");
  if (FileFind("~/Sup1/Sup1Utils/SortHeaders.HC.Z"))
    ExeFile("~/Sup1/Sup1Utils/SortHeaders.HC.Z");

  CursorRem("/*");
  DelTree("/demo/*.BI*");
  S2T("/*","+r+S");
  DocOpt("/*","+R");
  Move(ACD_DEF_FILENAME,ACD_DEF_FILENAME_Z);
}

U0 DbgDistroFilePrep()
{
  CBlkDev *bd;
  if (!Let2Drv('A',FALSE)) {
    In(CFG_DBG_DISTRO "\n");
    Mount;
  }
  bd=Let2BlkDev('A');
  Fmt('A',,FALSE,FSt_REDSEA);

  DirMk("A:/compiler");
  Copy("C:/compiler/Compiler.BIN.Z",	"A:/compiler");
  Copy("C:/compiler/op_codes.dd.Z",	"A:/compiler");
  Copy("C:/compiler/compiler_a.hh.Z",	"A:/compiler");
  Copy("C:/compiler/compiler_b.hh.Z",	"A:/compiler");

  DirMk("A:/kernel");
  Copy("C:/kernel/*.HH*",		"A:/kernel");
  CopyTree("C:/kernel/blkdev",		"A:/kernel/blkdev");

  Copy("C:/home/Sup1/Sup1Distro/Dbgstart_os.hc.Z","A:/start_os.hc.Z");

  DirMk("A:/adam");
  Copy("C:/home/Sup1/Sup1Distro/Dbgmake_adam.hc.Z","A:/adam/make_adam.hc.Z");
  Copy("C:/home/Sup1/Sup1Distro/Dbgmount.hc.Z","A:/adam");
  Copy("C:/adam/a_exts.hc.Z",	"A:/adam");
  Copy("C:/adam/a_math.hc.Z",	"A:/adam");
  Copy("C:/adam/training.hc.Z","A:/adam");
  Copy("C:/adam/a_mem.hc.Z",	"A:/adam");
  Copy("C:/adam/task_rep.hc.Z",	"A:/adam");

  FileWrite("C:" CFG_DBG_DISTRO_FILE,
	bd->RAM_dsk,(bd->max_blk+1)<<BLK_SIZE_BITS);
}


U0 StdDistroPrep()
{
  Drv('C');
  DistroPrep;
  In(STD_DISTRO_DVD_CFG);
  BootDVDIns('C');
  Fmt('B',,FALSE,FSt_REDSEA);
  DelTree(TOS_DISTRO_DIR);
  CopyTree("C:/",TOS_DISTRO_DIR "/");
  DelTree(TOS_DISTRO_DIR "/home");
  DirMk(TOS_DISTRO_DIR "/home");
  Del(TOS_DISTRO_DIR "/" KERNEL_BIN_C);
  Del(TOS_DISTRO_DIR BOOT_DIR "/OldMBR.BIN.C");
  Del(TOS_DISTRO_DIR BOOT_DIR "/BootMHD2.BIN.C");
}
U0 MakeStdDistro()
{
  StdDistroPrep;
  RedSeaISO(TOS_ISO_NAME,TOS_DISTRO_DIR,TOS_DISTRO_DIR BOOT_DIR_KERNEL_BIN_C);
  DefinePrint("DD_TEMPLEOSCD_SIZE",
	"Download $TX,"TempleOS V5.03",D="DD_OS_NAME_VERSION"$ - Standard Distro (%0.1fMB)",
	0.1*(10*Size(TOS_ISO_NAME,"+s")/1024/1024));
  Drv('C');
}

U0 LiteDistroPrep()
{
  Drv('C');
  DistroPrep;
  In(STD_DISTRO_DVD_CFG);
  BootDVDIns('C');
  Fmt('B',,FALSE,FSt_REDSEA);
  DelTree(TOS_DISTRO_DIR);
  CopyTree("C:/",TOS_DISTRO_DIR "/");
  DelTree(TOS_DISTRO_DIR "/home");
  DirMk(TOS_DISTRO_DIR "/home");
  DelTree(TOS_DISTRO_DIR "/apps");
  DelTree(TOS_DISTRO_DIR "/demo");
  Copy(TOS_DISTRO_DIR "/demo/games/talons.hc.Z",TOS_DISTRO_DIR "/home");
  Del(TOS_DISTRO_DIR "/" KERNEL_BIN_C);
  Del(TOS_DISTRO_DIR BOOT_DIR "/OldMBR.BIN.C");
  Del(TOS_DISTRO_DIR BOOT_DIR "/BootMHD2.BIN.C");
  Del(TOS_DISTRO_DIR "/adam/autocomplete/ac_defs.data.Z");
  Del(TOS_DISTRO_DIR "/adam/autocomplete/ac_words.data.Z");
  Del(TOS_DISTRO_DIR "/misc/bible.txt.Z");
}
U0 MakeLiteDistro()
{
  LiteDistroPrep;
  RedSeaISO(TOS_ISO_NAME,TOS_DISTRO_DIR,TOS_DISTRO_DIR BOOT_DIR_KERNEL_BIN_C);
  DefinePrint("DD_TEMPLEOSCD_SIZE",
	"Download $TX,"TempleOS V5.03",D="DD_OS_NAME_VERSION"$ - Standard Distro (%0.1fMB)",
	0.1*(10*Size(TOS_ISO_NAME,"+s")/1024/1024));
  Drv('C');
}

U0 DbgDistroPrep()
{
  Drv('C');
  DistroPrep;
  DbgDistroFilePrep;
  In(TOS_DVD_DBG_CFG);
  BootDVDIns('C');
  Fmt('B',,FALSE,FSt_REDSEA);
  DelTree(TOS_DISTRO_DIR);
  CopyTree("C:/",TOS_DISTRO_DIR "/");
  DelTree(TOS_DISTRO_DIR "/home");
  DirMk(TOS_DISTRO_DIR "/home");
  Del(TOS_DISTRO_DIR "/" KERNEL_BIN_C);
  Del(TOS_DISTRO_DIR BOOT_DIR "/OldMBR.BIN.C");
  Del(TOS_DISTRO_DIR BOOT_DIR "/BootMHD2.BIN.C");
}
U0 MakeDbgDistro()
{
  DbgDistroPrep;
  RedSeaISO(TOS_ISO_NAME,TOS_DISTRO_DIR,TOS_DISTRO_DIR BOOT_DIR_KERNEL_BIN_C);
  DefinePrint("DD_TEMPLEOS_DBG_SIZE",
	"Download $TX,"TempleOS V5.03",D="DD_OS_NAME_VERSION"$ - Debug Distro (%0.1fMB)",
	0.1*(10*Size(TOS_ISO_NAME,"+s")/1024/1024));
  Drv('C');
}

U0 StaffDistroPrep()
{
  Drv('C');
  DistroPrep;
  In(TOS_DVD_CFG);
  BootDVDIns('C');
  Fmt('B',,FALSE,FSt_REDSEA);
  DelTree(TOS_DISTRO_DIR);
  CopyTree("C:/",TOS_DISTRO_DIR "/");
  DelTree(TOS_DISTRO_DIR "/home/Sup1");
  DelTree(TOS_DISTRO_DIR "/home/Sup2");
  DelTree(TOS_DISTRO_DIR "/home/Sup3");
  Del(TOS_DISTRO_DIR "/" KERNEL_BIN_C);
}
U0 MakeStaffDistro()
{
  StaffDistroPrep;
  RedSeaISO(TOS_ISO_NAME,TOS_DISTRO_DIR,TOS_DISTRO_DIR BOOT_DIR_KERNEL_BIN_C);
  DefinePrint("DD_TEMPLEOS_STAFF_SIZE",
	"Download $TX,"TempleOS V5.03",D="DD_OS_NAME_VERSION"$ - T.S. Company Internal Distro (%0.1fMB)",
	0.1*(10*Size(TOS_ISO_NAME,"+s")/1024/1024));
  Drv('C');
}

I64 UpdateLineCnts()
{
  I64 res;

  DocClear;
  Drv('C');
  DistroPrep;

  Cd("C:/");
  DelTree("B:/tos/tos");
  CopyTree("C:/home","B:/tos/tos");
  DelTree("C:/home");

  DocMax;
  DocClear;
  res=LineRep("C:/*","-r")+LineRep("C:/adam/*")+
	LineRep("C:/compiler/*","-S+$$")+LineRep("C:/kernel/*");
  CopyTree("B:/tos/tos","C:/home");
  DelTree("B:/tos/tos");

  DocTreeFWrite("C:/adam/a_define.hc.Z","LineRep",
	"DefinePrint(\"DD_TEMPLEOS_LOC\",\"%,d\");\n",res);
  DefinePrint("DD_TEMPLEOS_LOC","%,d",res);

  "Total LOC:%12,d\n\n",res;
  return res;
}

U0 UpdateISODocDefines()
{
  try {
    DefinePrint("DD_TEMPLEOSCD_SIZE",
	  "Download $TX,"TempleOS V5.03",D="DD_OS_NAME_VERSION"$ - Standard Distro (%0.1fMB)",
	  0.1*(10*Size("D:/Downloads/TOS_Distro.ISO","+s")/1024/1024));
    DefinePrint("DD_TEMPLEOSCD_K_SIZE",
	  "%dKB",Size("D:/Downloads/TOS_Distro.ISO","+s")/1024);
  } catch
    Fs->catch_except=TRUE;
}
UpdateISODocDefines;


I64 tos_progress;
F64 tos_progress_t0;

U0 TOSProgress(U8 *st)
{
  U8 buf[STR_LEN];
  progress4=tos_progress;
  progress3_max=1;
  *progress4_desc=0;
  progress4_max=9+MAKE_LITE+MAKE_DBG+MAKE_STAFF;
  progress4_t0=tos_progress_t0;
  StrPrint(buf,"%d. %s",++progress4,st);
  "$$PURPLE$$$$TX+CX,\"%s\"$$$$FG$$\n",buf;
  StrCpy(progress3_desc,buf);
  tos_progress=progress4;
}

U0 TOSRegen2()
{
  I64 slash_home=0;
  SettingsPush; //See $LK,"SettingsPush",A="MN:SettingsPush"$
  tos_progress=-1;
  tos_progress_t0=tS;
  RegExe("TempleOS/TOSRegen");

  TOSProgress("DskChk All");
  AutoComplete;
  WinBorder;
  WinMax;
  DskChkAll;

  TOSProgress("Update Line Cnts");
  UpdateLineCnts;

  TOSProgress("Copy C to D");
  TOSCopyDrv('C','D');

  TOSProgress("Make Standard Distro ISO");
  MakeStdDistro;
  DocClear;
  Move(TOS_ISO_NAME,"D:/Downloads/TOS_Distro.ISO");

  TOSProgress("Make Supplemental1 ISO");
  RedSeaISO("D:/Downloads/TOS_Supplemental1","C:/home/Sup1");

  TOSProgress("Make Supplemental2 ISO");
  RedSeaISO("D:/Downloads/TOS_Supplemental2","C:/home/Sup2");

  TOSProgress("Make Supplemental3 ISO");
  RedSeaISO("D:/Downloads/TOS_Supplemental3","C:/home/Sup3");

#if MAKE_LITE
  TOSProgress("Make Lite Distro ISO");
  MakeLiteDistro;
  DocClear;
  Move(TOS_ISO_NAME,"D:/Downloads/TOS_Lite.ISO");
#endif
#if MAKE_DBG
  TOSProgress("Make Dbg Distro ISO");
  MakeDbgDistro;
  DocClear;
  Move(TOS_ISO_NAME,"D:/Downloads/TOS_Dbg.ISO");
#endif
#if MAKE_STAFF
  TOSProgress("Make Staff Distro ISO");
  MakeStaffDistro;
  DocClear;
  Move(TOS_ISO_NAME,"D:/Downloads/TOS_Staff.ISO");
#endif

  UpdateISODocDefines;
  Cd("C:/");
  DocClear;

  TOSProgress("Check for Long Lines");
  if (LongLines)
    throw;

  DocClear;
  TOSProgress("Check for Broken DolDoc Links");
  if (LinkChk)
    throw;

  TOSProgress("Find /home");
  slash_home=F2("/home","-i+la");

  TOSProgress("DskChk All");
  Drv('C');
  DskChkAll;

  TOSProgress("Done");
  SettingsPop;
  "F2(\"/Home\") Cnt\t:%d\n",slash_home;
  "Elapsed Time\t:%5.3fs\n",tS-progress4_t0;
  ProgressBarsRst("TempleOS/TOSRegen");
}

public U0 TOSPreRegen()
{//Copy bins from D:/home/Sup1 to C:/home/Sup1
  Copy("D:/home/" INS_REG_PERSONAL_INITIALS "/*",
	"C:/home/" INS_REG_PERSONAL_INITIALS);
  DelTree("C:/home/Sup1/Sup1Bin");
  CopyTree("D:/home/Sup1/Sup1Bin","C:/home/Sup1/Sup1Bin");
  Copy("D:/home/Sup1/Sup1CodeScraps/Comm/TOSSocket*",
	"C:/home/Sup1/Sup1CodeScraps/Comm");
  DelTree("C:/Downloads/linux");
  CopyTree("D:/Downloads/linux","C:/Downloads/linux");
}

public U0 TOSRegen()
{//Generate distro ISO's
  TOSBootHDIns('C');
  Once("TOSRegen2;");
  BootRAM("C:/kernel/" KERNEL_BIN_C); //Boot to load $LK,"TOS_CFG",A="PF:::/demo/acctexample/tos/tos_cfg.hc,TOS_CFG"$.
}
