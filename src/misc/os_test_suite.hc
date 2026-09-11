I64 ts_i;
F64 ts_t0;

U0 TS(U8 *desc)
{//We must set these because an app can call $LK,"ProgressBarsRst",A="MN:ProgressBarsRst"$.
  U8 *st=MStrPrint("%d. %s",ts_i,desc);
  if (*desc)
    progress3_max=1;
  else
    progress3_max=0;
  StrPrint(progress3_desc,"%*hc%s",
    (PROGRESS_DESC_LEN-StrLen(st))>>1,CH_SPACE,st);
  Free(st);
  progress4=ts_i++;
  progress4_max=171;
  progress4_t0=ts_t0;
  *progress4_desc=0;
  RegExe("TempleOS/OSTestSuite");
}

U0 TSFile(U8 *name,I64 mS=750)
{
  CTask *task=User("#include \"%s\";Sleep(%d);\n",name,mS);
  DeathWait(&task,TRUE);
}

U0 TSFileChar(U8 *name,I64 mS=750,I64 ch=CH_SPACE,Bool wait=TRUE)
{
  CTask *task=User;
  if (wait)
    XTalkWait(task,"#include \"%s\";\n",name);
  else
    XTalk(task,"#include \"%s\";\n",name);
  Sleep(mS);
  if (ch)
    PostMsgWait(task,MSG_KEY_DOWN_UP,ch,0);
  DeathWait(&task,TRUE);
}

/*
U0 DoMouseDemo()
{
  XTalkWait(task,"#include \"::/demo/graphics/MouseDemo\";\n");
}
U0 DoPullDownMenu()
{
  XTalkWait(task,"#include \"::/demo/PullDownMenu\";\n");
}
U0 DoTicTacToe()
{
  XTalkWait(task,"#include \"::/demo/games/TicTacToe\";\n");
}
U0 DoLife()
{
  XTalkWait(task,"#include \"::/demo/graphics/Life\";\n");
}
U0 DoZing()
{
  XTalkWait(task,"#include \"::/demo/games/Zing\";\n");
}
U0 DoSlider()
{
  XTalkWait(task,"#include \"::/demo/graphics/Slider\";\n");
}
U0 DoScrollBars()
{
  XTalkWait(task,"#include \"::/demo/graphics/ScrollBars\";\n");
}
U0 DoWhap()
{
  XTalkWait(task,"#include \"::/demo/games/Whap\";\n");
}
U0 DoDataBase()
{
  XTalkWait(task,"#include \"::/demo/dsk/DataBase\";\n");
}
U0 DoDskRaw()
{
  XTalkWait(task,"#include \"::/demo/dsk/DskRaw\";\n");
}
U0 DoTimeClock()
{
  XTalkWait(task,"#include \"::/apps/TimeClock\";\n");
}
U0 DoLectures()
{
  XTalkWait(task,"#include \"::/demo/Lectures\";\n");
}
U0 DoInFile()
{
  XTalkWait(task,"#include \"::/demo/InFile\";\n");
}
U0 DoSpy()
{
  XTalkWait(task,"#include \"::/demo/Spy\";\n");
}
U0 DoUnusedDefine()
{
  XTalkWait(task,"#include \"::/demo/doldoc/UnusedDefine\";\n");
}
U0 DoOnceDemo()
{
  XTalkWait(task,"#include \"::/demo/OnceDemo\";\n");
}
*/
$PL,1000$
U0 DoRandDemo()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/RandDemo\";\n");
  XTalkWait(task," ");
  XTalkWait(task," ");
  Sleep(750);
  DeathWait(&task,TRUE);
}

U0 DoLowPassFilter()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/LowPassFilter\";\n");
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoMathAudioDemo()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/MathAudioDemo\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoMsgLoop()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/MsgLoop\";\n");
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoASCIIOrgan()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/snd/ASCIIOrgan\";\n");
  Sleep(100);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'A',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'B',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'C',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoDoodle()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Doodle\";\n");
  PostMsgWait(task,MSG_MS_L_DOWN,10,10);
  PostMsgWait(task,MSG_MS_L_UP,100,200);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoSpeedLine()
{
  I64 i=PURPLE+1; //+1 because TRANSPARENT
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Speedline\";\n");
  PostMsgWait(task,MSG_MS_L_DOWN,10,10);
  PostMsgWait(task,MSG_MS_L_UP,100,200);
  PostMsg(task,MSG_MS_R_DOWN_UP,0,0);
  BirthWait(&task->popup_task);
  while (i--)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_ESC,0);
  TaskWait(task);
  PostMsgWait(task,MSG_MS_L_DOWN,50,10);
  PostMsgWait(task,MSG_MS_L_UP,150,200);
  Sleep(1000);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoKeyBitMap()
{
  I64 i_sc=Char2ScanCode('i');
  CTask *task=User("#include \"::/demo/KeyBitMap\";\n");
  Sleep(50);
  LBts(kbd.down_bitmap,i_sc);
  Sleep(500);
  LBtr(kbd.down_bitmap,i_sc);
  Sleep(50);
  DeathWait(&task,TRUE);
}

U0 DoDigits()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/Digits\";\n");
  Sleep(100);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(100);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(250);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'1',0);
  Sleep(250);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoSymmetry()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Symmetry\";\n");
  PostMsgWait(task,MSG_MS_R_DOWN,100,100);
  PostMsgWait(task,MSG_MS_R_UP,200,200);
  Sleep(100);
  PostMsgWait(task,MSG_MS_L_DOWN,10,10);
  PostMsgWait(task,MSG_MS_L_UP,100,200);
  Sleep(250);
  PostMsgWait(task,MSG_MS_L_DOWN,100,200);
  PostMsgWait(task,MSG_MS_L_UP,400,400);
  Sleep(250);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoBSpline()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/BSpline\";\n");
  PostMsgWait(task,MSG_MS_L_DOWN_UP,50,50);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,300,100);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,150,300);
  PostMsgWait(task,MSG_MS_R_DOWN_UP,0,0);
  Sleep(1500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoScrnCapture()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/ScrnCapture\";\n");
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
  Del("~/DemoScrnShot.GR*");
}

U0 DoStadium()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/stadium/Stadium\";\n");
  Sleep(50);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,100,10);
  Sleep(300);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,320,20);
  Sleep(300);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,520,10);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoPalette()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Palette\";\n");
  Sleep(400);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(400);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoElephantWalk()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/ElephantWalk\";\n");
  for (i=0;i<15;i++) {
    PostMsgWait(task,MSG_KEY_DOWN,0,SC_CURSOR_RIGHT);
    Sleep(50);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoHalogen()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/Halogen\";\n");
  PostMsgWait(task,MSG_KEY_DOWN,0,SC_CURSOR_UP);
  Sleep(1000);
  PostMsgWait(task,MSG_KEY_UP,0,SC_CURSOR_UP);
  PostMsgWait(task,MSG_KEY_DOWN,0,SC_CURSOR_RIGHT);
  Sleep(333);
  PostMsgWait(task,MSG_KEY_UP,0,SC_CURSOR_RIGHT);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoTheDead()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/TheDead\";\n");
  for (i=0;i<15;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    Sleep(50);
  }
  for (i=0;i<15;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    Sleep(50);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoBomberGolf()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/BomberGolf\";\n");
  for (i=0;i<7;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(100);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  for (i=0;i<7;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    Sleep(200);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoZoneOut()
{
  I64 i;
  CTask *task=User("#include \"::/demo/games/ZoneOut\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  for (i=0;i<15;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    Sleep(100);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoVaroom()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/Varoom\";\n");
  for (i=0;i<10;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    Sleep(50);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    Sleep(50);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    Sleep(50);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoFlatTops()
{
  CTask *task=User("#include \"::/demo/games/FlatTops\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task->popup_task);
  PostMsgWait(task,MSG_MS_R_DOWN_UP,RandI16%400+200,RandI16%300+150);
  Sleep(1500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoWenceslas()
{
  I64 i;
  CTask *task=User("#include \"::/demo/games/Wenceslas\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(100);
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(100);
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(100);
  for (i=0;i<25;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(25);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoTreeCheckers()
{
  I64 task_num;
  CTask *task=User("#include \"::/demo/games/TreeCheckers\";\n");

  task_num=BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  Sleep(500);

  PostMsgWait(task,MSG_KEY_DOWN_UP,'\n',0);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoMorseCode()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/snd/MorseCode\";\n");
  Sleep(50);

  PostMsg(task,MSG_KEY_DOWN,CH_SPACE,0);
  Sleep(200);
  PostMsg(task,MSG_KEY_UP,CH_SPACE,0);
  Sleep(350);

  PostMsg(task,MSG_KEY_DOWN,CH_SPACE,0);
  Sleep(50);
  PostMsg(task,MSG_KEY_UP,CH_SPACE,0);
  Sleep(350);

  PostMsg(task,MSG_KEY_DOWN,CH_SPACE,0);
  Sleep(50);
  PostMsg(task,MSG_KEY_UP,CH_SPACE,0);
  Sleep(25);
  PostMsg(task,MSG_KEY_DOWN,CH_SPACE,0);
  Sleep(200);
  PostMsg(task,MSG_KEY_UP,CH_SPACE,0);
  Sleep(25);
  PostMsg(task,MSG_KEY_DOWN,CH_SPACE,0);
  Sleep(50);
  PostMsg(task,MSG_KEY_UP,CH_SPACE,0);
  Sleep(500);

  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoPixCollision()
{
  I64 w,h;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Collision\";\n");
  w=task->pix_width>>1 +task->pix_left+task->scroll_x;
  h=task->pix_height>>1+task->pix_top +task->scroll_y;
  MsSet(w-35,h-35);
  InSetMs(10,w+35,w+35);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoBlackDiamond()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/BlackDiamond\";\n");
  for (i=0;i<15;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(75);
  }
  for (i=0;i<12;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    Sleep(75);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoCtrlR1()
{
  I64 i,task_num;
  CTask *task=User;
  XTalkWait(task,"//");
  PostMsg(task,MSG_KEY_DOWN_UP,CH_CTRLR,0);
  task_num=BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  for (i=0;i<1;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  //Color
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<2;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<2;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  //Width
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<4;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<4;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  //Line
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<7;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task->popup_task);
  PostMsgWait(task,MSG_MS_L_DOWN,150,150);
  PostMsgWait(task,MSG_MS_L_UP,150,95);
  Sleep(250);
  PostMsgWait(task,MSG_MS_L_DOWN,150,150);
  PostMsgWait(task,MSG_MS_L_UP,190,190);
  Sleep(250);
  PostMsgWait(task,MSG_MS_L_DOWN,150,150);
  PostMsgWait(task,MSG_MS_L_UP,110,190);
  Sleep(250);
  PostMsg(task,MSG_MS_R_DOWN_UP,100,100);

  //Color
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<2;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<3;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  //Circle
  task_num=BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  for (i=0;i<10;i++)
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task->popup_task);
  PostMsgWait(task,MSG_MS_L_DOWN,150,150);
  PostMsgWait(task,MSG_MS_L_UP,190,190);
  Sleep(250);
  PostMsg(task,MSG_MS_R_DOWN_UP,100,100);

  //Exit
  BirthWait(&task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN+SCF_CTRL);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
  PostMsg(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task->popup_task);
  Sleep(1000);
  XTalk(task,"\n");
  DeathWait(&task,TRUE);
}

U0 DoF2Macro()
{
  I64 i;
  U8 *ptr="\"Boo!\\n\";\n";
  CTask *task=User;
  DeathWait(&sys_macro_task);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_F2);
  BirthWait(&sys_macro_task);
  TaskWait(sys_macro_task);

  PostMsgWait(sys_macro_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT|SCF_CTRL);
  PostMsgWait(sys_macro_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(sys_macro_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
  PostMsgWait(sys_macro_task,MSG_KEY_DOWN_UP,CH_SPACE,0); //Press RECORD
  while (!Bt(&sys_semas[SEMA_RECORD_MACRO],0))
    Yield;

  while (*ptr)
    PostMsgWait(task,MSG_KEY_DOWN,*ptr++,0);

  PostMsgWait(sys_macro_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(sys_macro_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(sys_macro_task,MSG_KEY_DOWN_UP,CH_SPACE,0); //Press STOP

  for (i=0;i<10;i++)
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_F2|SCF_SHIFT);

  PostMsg(sys_macro_task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&sys_macro_task);

  Sleep(1000);
  XTalk(task,"\n");
  DeathWait(&task,TRUE);
}

U0 DoLightTable()
{
  CTask *task=User("#include \"::/demo/graphics/LightTable\";\n\n");
  TaskWait(task);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'2',0);
  PostMsgWait(task,MSG_MS_L_DOWN,   100		,200);
  PostMsgWait(task,MSG_MS_L_UP,     640-100	,200);

  PostMsgWait(task,MSG_KEY_DOWN_UP,'3',0);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,100		,200);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,100		,200);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,100		,200);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,120		,180);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,160		,120);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,320		,10);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,640-160	,120);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,640-120	,180);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,640-100	,200);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,640-100	,200);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,640-100	,200);
  PostMsgWait(task,MSG_MS_R_DOWN_UP,0,0);

  PostMsgWait(task,MSG_KEY_DOWN_UP,'4',0);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,320,190);

  PostMsgWait(task,MSG_KEY_DOWN_UP,'5',0);
  PostMsgWait(task,MSG_MS_L_DOWN,460,280);
  PostMsgWait(task,MSG_MS_L_UP	,500,220);

  Sleep(1500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoPredatorPrey()
{
  CTask *task=User("#include \"::/demo/graphics/PredatorPrey\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(1500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoCharDemo()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/CharDemo\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
  Sleep(750);
  PostMsg(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoLattice()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Lattice\";\n");
  for (i=0;i<20;i++)
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
  for (i=0;i<6;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,'+',0);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
  }
  for (i=0;i<6;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
  }
  for (i=0;i<16;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
  }
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoCartesian()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Cartesian\";\n");
  XTalkWait(task,"0.2*x`1.5\n");
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoMPAdd()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/multicore/MPAdd\";\n");
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoFlapBat()
{
  I64 i;
  CTask *task=User("#include \"::/demo/games/FlapBat\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  for (i=0;i<4;i++) {
    PostMsgWait(task,MSG_KEY_DOWN,CH_SPACE,0);
    Sleep(100);
    PostMsgWait(task,MSG_KEY_UP,CH_SPACE,0);
    Sleep(100);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoBattleLines()
{
  CTask *task=User("#include \"::/demo/games/BattleLines\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task->popup_task);
  MsSet(430,300,,TRUE);
  InSetMs(10,530,400);
  MsSet(,,,FALSE);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoBigGuns()
{
  I64 i,task_num;
  CTask *task=User("#include \"::/demo/games/BigGuns\";\n");
  task_num=BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  BirthWait(&task->popup_task,task_num);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  for (i=0;i<5;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    Sleep(200);
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoDunGen()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/DunGen\";\n");
  for (i=0;i<10;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(100);
  }
  for (i=0;i<12;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    Sleep(100);
  }
  for (i=0;i<6;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(100);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoTitanium()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/apps/titanium/Run\";\n");
  Sleep(200);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  for (i=0;i<3;i++) {
    PostMsgWait(task,MSG_KEY_DOWN,CH_SPACE,0);
    LBts(kbd.down_bitmap,SC_CURSOR_RIGHT);
    Sleep(200);
    PostMsgWait(task,MSG_KEY_UP,CH_SPACE,0);
    LBtr(kbd.down_bitmap,SC_CURSOR_RIGHT);
    Sleep(200);
    PostMsgWait(task,MSG_KEY_DOWN,CH_SPACE,0);
    LBts(kbd.down_bitmap,SC_CURSOR_LEFT);
    Sleep(200);
    PostMsgWait(task,MSG_KEY_UP,CH_SPACE,0);
    LBtr(kbd.down_bitmap,SC_CURSOR_LEFT);
    Sleep(200);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoToTheFront()
{
  I64 task_num;
  CTask *task=User("#include \"::/apps/tothefront/Run\";\n");
  task_num=BirthWait(&task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,'\n',0);
  task_num=BirthWait(&task->popup_task,task_num);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  task_num=BirthWait(&task->popup_task,task_num);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  BirthWait(&task->popup_task,task_num);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN,CH_SPACE,0);
  DeathWait(&task->popup_task);
  Sleep(5000);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoPsalmody()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/apps/psalmody/Run\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,'z',0);
  PostMsgWait(task,MSG_KEY_DOWN,'h',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_UP,'h',0);
  PostMsgWait(task,MSG_KEY_DOWN,'g',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_UP,'g',0);
  PostMsgWait(task,MSG_KEY_DOWN,'h',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_UP,'h',0);
  PostMsgWait(task,MSG_KEY_DOWN,'j',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_UP,'j',0);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT+SCF_CTRL);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'x',0);
  Sleep(1250);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoJukeBox()
{
  CTask *task=User("#include \"::/apps/psalmody/Load\";"
	"JukeBox(\"::/apps/psalmody/Examples\");\n");
  BirthWait(&task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(1500);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task->popup_task);
  DeathWait(&task,TRUE);
}

U0 DoSpan()
{
  CTask *task=User("#include \"::/apps/span/Run\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(1500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoStrut()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/apps/strut/Run\";\n");

  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);

  MsSet(200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  Refresh(2);

  MsSet(GR_WIDTH-200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);

  MsSet(GR_WIDTH/2,400,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);

  PostMsgWait(task,MSG_KEY_DOWN_UP,'s',0);

  MsSet(200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(GR_WIDTH-200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  MsSet(200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(GR_WIDTH/2,400,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  MsSet(GR_WIDTH-200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(GR_WIDTH/2,400,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  MsSet(GR_WIDTH/2,GR_HEIGHT/2,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(GR_WIDTH-200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  MsSet(GR_WIDTH/2,GR_HEIGHT/2,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(GR_WIDTH/2,400,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  MsSet(GR_WIDTH/2,GR_HEIGHT/2,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  PostMsgWait(task,MSG_KEY_DOWN_UP,'t',0);

  MsSet(GR_WIDTH/2,400,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(GR_WIDTH-200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  MsSet(GR_WIDTH/2,400,,TRUE);
  PostMsgWait(task,MSG_MS_L_DOWN,0,0);
  MsSet(200,200,,TRUE);
  PostMsgWait(task,MSG_MS_L_UP,0,0);

  MsSet(,,,FALSE);

  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  LBts(kbd.down_bitmap,Char2ScanCode('1'));
  Sleep(600);
  LBtr(kbd.down_bitmap,Char2ScanCode('1'));
  PostMsgWait(task,MSG_KEY_DOWN_UP,'Z',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'Z',0);
  Sleep(200);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'Z',0);
  Sleep(200);

  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoRawHide()
{
  CTask *task=User("#include \"::/demo/games/RawHide\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(2500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoPoleZeros()
{
  CTask *task=User("#include \"::/demo/graphics/PoleZeros\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoWhap()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/Whap\";\n");
  MsSet(300,200);
  Sleep(500);
  InSetMs(3,350,300);
  Sleep(500);
  InSetMs(3,450,200);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoGrid()
{
  CTask *task=User("#include \"::/demo/graphics/Grid\";\n");
  MsSet(200,200);
  Sleep(150);
  InSetMs(2,400,400);
  InSetMs(2,200,400);
  InSetMs(2,200,200);
  MsSet(,,,TRUE);
  Sleep(50);
  MsSet(,,,FALSE);
  DocBottom(DocPut(task));
  DeathWait(&task,TRUE);
}

U0 DoPick()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Pick\";\n");
  MsSet(200,200);
  Sleep(500);
  MsSet(,,,TRUE);
  InSetMs(4,400,400);
  MsSet(,,,FALSE);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoPick3D()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/graphics/Pick3D\";\n");
  MsSet(200,200);
  Sleep(500);
  MsSet(,,,TRUE);
  InSetMs(4,400,400);
  MsSet(,,,FALSE);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoGrModels()
{
  CTask *task=User;
  I64 i,j,task_num=-1;
  XTalkWait(task,"#include \"::/apps/grmodels/Run\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  PostMsg(task,MSG_KEY_DOWN_UP,CH_ESC,0);
  for (i=0;i<4;i++) {
    task_num=BirthWait(&task->popup_task,task_num);
    TaskWait(task->popup_task);
    for (j=0;j<=i;j++)
      PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  }
  Sleep(1000);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'n',0);
  DeathWait(&task,TRUE);
}

U0 DoKeepAway()
{
  CTask *task=User("#include \"::/apps/keepaway/Run\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  MsSet(100,100);
  Sleep(1500);
  PostMsgWait(task,MSG_MS_R_DOWN_UP,ms.pos.x,ms.pos.y);
  Sleep(1000);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoRocket()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/Rocket\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
  Bts(kbd.down_bitmap,SC_CURSOR_UP);
  Sleep(1000);
  Btr(kbd.down_bitmap,SC_CURSOR_UP);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
  Bts(kbd.down_bitmap,SC_CURSOR_RIGHT);
  Sleep(1000);
  Btr(kbd.down_bitmap,SC_CURSOR_RIGHT);
  Sleep(1000);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoRocketScience()
{
  CTask *task=User("#include \"::/demo/games/RocketScience\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(2000);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoMassSpring()
{
  CTask *task=User("#include \"::/demo/games/MassSpring\";\n");
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task->popup_task);
  PostMsgWait(task,MSG_MS_L_DOWN_UP,50,50);  //#1
  PostMsgWait(task,MSG_MS_L_DOWN_UP,50,200); //#2
  PostMsgWait(task,MSG_MS_L_DOWN_UP,210,50); //#3
  PostMsgWait(task,MSG_MS_L_DOWN_UP,310,200);//#4
  Sleep(500);
  PostMsgWait(task,MSG_MS_R_DOWN,50,50); //1-2
  PostMsgWait(task,MSG_MS_R_UP,50,200);
  Sleep(500);
  PostMsgWait(task,MSG_MS_R_DOWN,210,50);//3-4
  PostMsgWait(task,MSG_MS_R_UP,310,200);
  Sleep(500);
  PostMsgWait(task,MSG_MS_R_DOWN,50,200);//2-4
  PostMsgWait(task,MSG_MS_R_UP,310,200);
  Sleep(500);
  PostMsgWait(task,MSG_MS_R_DOWN,50,50); //1-3
  PostMsgWait(task,MSG_MS_R_UP,210,50);
  Sleep(1500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoSquirt()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/Squirt\";\n");
  for (i=0;i<5;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    Sleep(100);
  }
  for (i=0;i<5;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_LEFT);
    Sleep(100);
  }
  for (i=0;i<5;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    Sleep(100);
  }
  for (i=0;i<5;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(100);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoXCaliber()
{
  I64 i;
  CTask *task=User;
  XTalk(task,"#include \"::/apps/x-caliber/Run\";\n");

  Sleep(100);
  if(TaskValidate(task->popup_task)) {
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,0,SCF_CTRL|SC_CURSOR_DOWN);
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    DeathWait(&task->popup_task);
  }

  for (i=0;i<5;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SCF_SHIFT|SC_CURSOR_UP);
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SCF_SHIFT|SC_CURSOR_RIGHT);
  }
  for (i=0;i<10;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    PostMsgWait(task,MSG_KEY_DOWN,0,SC_CURSOR_RIGHT,0);
    Sleep(100);
    PostMsgWait(task,MSG_KEY_UP,0,SC_CURSOR_RIGHT,0);
    Sleep(50);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoFPS()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/CastleFrankenstein\";\n");
  for (i=0;i<15;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    Sleep(50);
  }
  for (i=0;i<8;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(50);
  }
  for (i=0;i<9;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    Sleep(50);
  }
  for (i=0;i<6;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
    Sleep(50);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoTalons()
{
  I64 i;
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/games/Talons\";\n");
  Sleep(500);
  for (i=0;i<10;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_UP);
    Sleep(50);
  }
  for (i=0;i<10;i++) {
    PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
    Sleep(50);
  }
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoPhoneNumWords()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/PhoneNumWords\";\n");
  XTalkWait(task,"702-254-4223\n\n");
  Sleep(750);
  DeathWait(&task,TRUE);
}

U0 DoSuggestedSpelling()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/SuggestSpelling\";\n");
  XTalkWait(task,"effecient\n\n");
  Sleep(750);
  DeathWait(&task,TRUE);
}

U0 DoFPrintF()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/dsk/FPrintF\";\n");
  XTalkWait(task,"~/DemoFPrintF.DD.Z");
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_ESC,0);
  XTalkWait(task,"Type(\"~/DemoFPrintF.DD.Z\");\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_CTRLO,0);
  XTalkWait(task,"Del(\"~/DemoFPrintF.DD*\");\n");
  Sleep(500);
  DeathWait(&task,TRUE);
}

U0 DoLastClass()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/LastClass\";\n");
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  DeathWait(&task,TRUE);
}

U0 DoMiniCompiler()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/lectures/MiniCompiler\";\n");
  XTalkWait(task,"1+2*(3+4)\n");
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoWebLog()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/weblogdemo/WebLogRep\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,'\n',0);
  PostMsgWait(task,MSG_KEY_DOWN_UP,'\n',0);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_ESC,0);
  Sleep(750);
  DeathWait(&task,TRUE);
}

U0 DoRevFile()
{
  CTask *task;
  Del("~/DemoPoemFwd.DD*");
  task=User("#include \"::/demo/revfiledemo/Rev\";"
	"Type(\"~/DemoPoemFwd.DD.Z\");Sleep(750);\n");
  DeathWait(&task,TRUE);
}

U0 DoSortFile()
{
  CTask *task=User("#include \"::/demo/sortfiledemo/F64FileGen\";"
	"#include \"::/demo/sortfiledemo/F64FileSort\";Sleep(750);\n");
  DeathWait(&task,TRUE);
}

U0 DoToHtmlToTXT()
{
  CTask *task=User("#include \"::/demo/tohtmltotxtdemo/HtmlGen\";"
	"#include \"::/demo/tohtmltotxtdemo/TXTGen\";"
	"Type(\"~/DemoOutPage.TXT\");Sleep(750);\n");
  DeathWait(&task,TRUE);
}

U0 DoLogic()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/apps/logic/Run\";\n");
  XTalkWait(task,"NAND\nNOR\n\n0x100\n0xF0\n0xCC\n0xAA\n\n0x12\n\n");
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoPrompt()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/Prompt\";\n");
  XTalkWait(task,"1+2*3<<4\n");
  XTalkWait(task,"1.0+2*3`2\n");
  XTalkWait(task,"Terry Davis\n");
  XTalkWait(task,"*-1\n");
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoNumBible()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/doldoc/NumBible\";\n");
  Del("~/DemoNumBible.DD*");
  DeathWait(&task,TRUE);
}

U0 DoForm()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/doldoc/Form\";\n");
  Sleep(250);
  XTalk(task,"54321");
  Sleep(250);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  Sleep(250);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SCF_CTRL|SC_CURSOR_LEFT);
  XTalk(task,"77777");
  Sleep(250);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN);
  Sleep(250);
  XTalk(task,"MyName");
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_ESC,0);
  Sleep(750);
  DeathWait(&task,TRUE);
}

U0 DoClickCallBack()
{
  I64 i;
  CTask *task=User("#include \"::/demo/doldoc/ClickCallBack\";\n");
  for (i=0;i<3;i++) {
    BirthWait(&task->popup_task);
    TaskWait(task->popup_task);
    PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
    Sleep(250);
  }
  Sleep(500);
  DeathWait(&task,TRUE);
}

U0 DoMenuBttn()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/doldoc/MenuBttn\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(500);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN,0);
  Sleep(500);
  PostMsg(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  BirthWait(&task->popup_task);
  TaskWait(task->popup_task);
  Sleep(500);
  PostMsgWait(sys_focus_task,MSG_KEY_DOWN_UP,0,SC_CURSOR_RIGHT);
  Sleep(500);
  PostMsgWait(task->popup_task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task->popup_task);
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoMenuSprite()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/doldoc/MenuSprite\";\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN,0);
  Sleep(50);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN,0);
  Sleep(50);
  PostMsgWait(task,MSG_KEY_DOWN_UP,0,SC_CURSOR_DOWN,0);
  Sleep(50);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(300);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoExceptions()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/Exceptions\";\n");
  XTalkWait(task,"yy");
  Sleep(750);
  DeathWait(&task,TRUE);
}

U0 DoDemoDoc()
{
  CTask *task=User;
  XTalkWait(task,"Ed(\"::/demo/doldoc/demo_doc.dd\");\n");
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_CTRLG,0);
  XTalkWait(task,"100");
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_ESC,0);
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SHIFT_ESC,0);
  DeathWait(&task,TRUE);
}

U0 DoFileRead()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/doldoc/FileRead\";\n");
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  Sleep(750);
  PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  DeathWait(&task,TRUE);
}

U0 DoDefine()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/Define\";\n");
  XTalkWait(task,"YS\n");
  Sleep(750);
  DeathWait(&task,TRUE);
}

U0 DoAsmAndC1()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/asm/AsmAndC1\";\n2\n");
  DeathWait(&task,TRUE);
}

U0 DoAsmAndC2()
{
  CTask *task=User;
  XTalkWait(task,"#include \"::/demo/asm/AsmAndC2\";\n2\n");
  DeathWait(&task,TRUE);
}

U0 OSTestSuite()
{
  CTask *task;
  ts_t0=tS;
  ts_i=0;

  TS("BlackDiamond");	DoBlackDiamond;
  TS("Talons");		DoTalons;
  TS("FlatTops");	DoFlatTops;
  TS("DunGen");		DoDunGen;
  TS("FPS");		DoFPS;
  TS("ZoneOut");	DoZoneOut;
  TS("Varoom");		DoVaroom;
  TS("Rocket");		DoRocket;
  TS("RocketScience");	DoRocketScience;
  TS("BattleLines");	DoBattleLines;
  TS("BigGuns");	DoBigGuns;
  TS("FlapBat");	DoFlapBat;
  TS("Titanium");	DoTitanium;
  TS("ToTheFront");	DoToTheFront;
  TS("Psalmody");	DoPsalmody;
  TS("JukeBox");	DoJukeBox;
  TS("Span");		if (!sys_heap_init_flag) DoSpan; //Has FloodFill
  TS("Strut");		DoStrut;
  TS("RawHide");	DoRawHide;
  TS("KeepAway");	DoKeepAway;
  TS("XCaliber");	DoXCaliber;
  TS("Wenceslas");	DoWenceslas;
  TS("BomberGolf");	DoBomberGolf;
  TS("TheDead");	DoTheDead;
  TS("TreeCheckers");	DoTreeCheckers;
  TS("RadixDort");	TSFile("::/demo/RadixSort");
  TS("MPAdd");		DoMPAdd;
  TS("Primes");		TSFile("::/demo/multicore/Primes");
  TS("Palindrome");	if (FileFind(BIBLE_FILENAME))
				TSFile("::/demo/multicore/Palindrome");
  TS("MPRadix");	if (mp_cnt>1) TSFile("::/demo/multicore/MPRadix");
  TS("LoadTest");	if (mp_cnt>1 && DrvIsWritable(':'))
				TSFileChar("::/demo/multicore/LoadTest");
  TS("MPPrint");	if (mp_cnt>1) TSFile("::/demo/multicore/MPPrint");
  TS("Lock");		if (mp_cnt>1) TSFile("::/demo/multicore/Lock");
  TS("Interrupts");	if (mp_cnt>1) TSFile("::/demo/multicore/Interrupts");
  TS("SpritePlot");	TSFileChar("::/demo/graphics/SpritePlot");
  TS("Elephants");	TSFileChar("::/demo/graphics/Elephant",,CH_SHIFT_ESC);
  TS("SpritePlot3D");	TSFileChar("::/demo/graphics/SpritePlot3D");
  TS("SpritePut");	TSFile("::/demo/graphics/SpritePut");
  TS("SpritePutExt");	TSFile("::/demo/graphics/SpritePutExt");
  TS("SpriteText");	TSFile("::/demo/graphics/SpriteText");
  TS("SpriteRaw");	TSFile("::/demo/graphics/SpriteRaw");
  TS("EdSprite");	TSFile("::/demo/graphics/EdSprite");
  TS("Balloon");	TSFile("::/demo/graphics/Balloon",0);
  TS("Carry");		TSFile("::/demo/Carry");
  TS("Directives");	TSFile("::/demo/Directives");
  TS("RandDemo");	DoRandDemo;
  TS("Extents");	TSFileChar("::/demo/graphics/Extents");
  TS("NetOfDots");	TSFileChar("::/demo/graphics/NetOfDots");
  TS("SunMoon");	TSFileChar("::/demo/graphics/SunMoon");
  TS("LowPassFilter");	DoLowPassFilter;
  TS("MathAudioDemo");	DoMathAudioDemo;
  TS("Lines");		TSFileChar("::/demo/graphics/Lines");
  TS("Bounce");	TSFileChar("::/demo/graphics/Bounce",,CH_SHIFT_ESC,FALSE);
  TS("MsgLoop");	DoMsgLoop;
  TS("ASCIIOrgan");	DoASCIIOrgan;
  TS("MorseCode");	DoMorseCode;
  TS("PixCollision");	DoPixCollision;
  TS("Doodle");		DoDoodle;
  TS("MassSpring");	DoMassSpring;
  TS("SpeedLine");	DoSpeedLine;
  TS("KeyBitMap");	DoKeyBitMap;
  TS("BSpline");	DoBSpline;
  TS("GrModels");	DoGrModels;
  TS("Blot");		TSFileChar("::/demo/graphics/Blot",1800);
  TS("ScrnCapture");	if (DrvIsWritable('~')) DoScrnCapture;
  TS("Grid");		DoGrid;
  TS("Pick");		DoPick;
  TS("Pick3D");		DoPick3D;
  TS("Whap");		DoWhap;
  TS("Palette");	DoPalette;
  TS("Print");		TSFile("::/demo/Print");
  TS("Shading");	TSFileChar("::/demo/graphics/Shading",1500);
  TS("RotateTank");	TSFileChar("::/demo/graphics/RotateTank",1500);
  TS("3DPoly");		TSFileChar("::/demo/graphics/3DPoly",1500);
  TS("Box");		TSFileChar("::/demo/graphics/Box",1500);
  TS("Symmetry");	DoSymmetry;
  TS("Shadow");		TSFileChar("::/demo/graphics/Shadow",1500);
  TS("Transform");	TSFileChar("::/demo/graphics/Transform",,CH_SHIFT_ESC);
  TS("LightTable");	DoLightTable;
  TS("PredatorPrey");	DoPredatorPrey;
  TS("PoleZeros");	DoPoleZeros;
  TS("Digits");		DoDigits;
  TS("Stadium");	DoStadium;
  TS("ElephantWalk");	DoElephantWalk;
  TS("Halogen");	DoHalogen;
  TS("Maze");		TSFileChar("::/demo/games/Maze",,CH_SHIFT_ESC);
  TS("FontEd");		TSFileChar("::/demo/graphics/FontEd",,CH_SHIFT_ESC);
  TS("Lattice");	DoLattice;
  TS("CtrlR1");		DoCtrlR1;
  TS("F2Macro");	DoF2Macro;
  TS("SubIntAccess");	TSFile("::/demo/SubIntAccess");
  TS("DemoDoc");	DoDemoDoc;
  TS("TreeDemo");	TSFile("::/demo/doldoc/TreeDemo");
  TS("TextDemo");	TSFile("::/demo/doldoc/TextDemo");
  TS("CursorMove");	TSFile("::/demo/doldoc/CursorMove");
  TS("MiniCompiler");	DoMiniCompiler;
  TS("MiniGrLib");	TSFile("::/demo/lectures/MiniGrLib",0);
  TS("TimeIns");	TSFileChar("::/demo/TimeIns");
  TS("PhoneNumWords");	DoPhoneNumWords;
  TS("UnusedSpaceRep");	TSFile("::/demo/dsk/UnusedSpaceRep");
  TS("BlkDevRep");	TSFile("::/demo/dsk/BlkDevRep");
  TS("LastClass");	DoLastClass;
  TS("FPrintF");	if (DrvIsWritable('~')) DoFPrintF;
  TS("SerializeTree");	TSFile("::/demo/dsk/SerializeTree");
  TS("Exceptions");	DoExceptions;
  TS("ScrnDCodes");	TSFileChar("::/demo/ScrnCodes");
  TS("ExtChars");	TSFile("::/demo/ExtChars");
  TS("PanText");	TSFile("::/demo/graphics/PanText",0);
  TS("CharAnimation");	TSFile("::/demo/graphics/CharAnimation");
  TS("CharDemo");	DoCharDemo;
  TS("DateTime");	TSFile("::/demo/DateTime");
  TS("SubSwitch");	TSFile("::/demo/SubSwitch");
  TS("NullCase");	TSFile("::/demo/NullCase");
  TS("Magicpairs");	TSFile("::/demo/MagicPairs");
  TS("Hanoi");		TSFileChar("::/demo/graphics/Hanoi",3000);
  TS("Squirt");		DoSquirt;
  TS("CommonAncestor");
	TSFileChar("::/demo/graphics/CommonAncestor",1500,CH_SHIFT_ESC);
  TS("Cartesian");	DoCartesian;
  TS("RainDrops");	TSFileChar("::/demo/games/RainDrops",,CH_SHIFT_ESC);
  TS("Collision");	TSFileChar("::/demo/games/Collision",1500);
  TS("Logic");		DoLogic;
  TS("CompileDemo");	TSFile("::/demo/CompileDemo");
  TS("Prompt");		DoPrompt;
  TS("WebLog");		if (DrvIsWritable('~')) DoWebLog;
  TS("RevFile");	if (DrvIsWritable('~')) DoRevFile;
  TS("SortFile");	if (DrvIsWritable('~')) DoSortFile;
  TS("ToHtmlToTXT");	if (DrvIsWritable('~')) DoToHtmlToTXT;
  TS("RegistryDemo");	if (DrvIsWritable('~'))
				TSFile("::/demo/RegistryDemo");
  TS("Define");		DoDefine;
  TS("GlblVars");	TSFile("::/demo/GlblVars");
  TS("FileRead");	DoFileRead;
  TS("ParenWarn");	TSFile("::/demo/ParenWarn");
  TS("DefineStr");	TSFile("::/demo/doldoc/DefineStr");
  TS("Data");		TSFile("::/demo/doldoc/Data");
  TS("CallBack");	TSFile("::/demo/doldoc/CallBack");
  TS("ClassMeta");	TSFile("::/demo/ClassMeta");
  TS("NumBible");	if (DrvIsWritable('~')) DoNumBible;
  TS("Form");		DoForm;
  TS("ClickCallBack");	DoClickCallBack;
  TS("MenuBttn");	DoMenuBttn;
  TS("MenuSprite");DoMenuSprite;
  TS("SuggestedSpelling"); DoSuggestedSpelling;
  TS("WordSearch");	TSFileChar("::/demo/WordSearch");
  TS("StkGrow");	TSFile("::/demo/StkGrow");
  TS("MemDemo");	TSFile("::/demo/MemDemo");
  TS("WaterFowl");	TSFileChar("::/demo/snd/WaterFowl");
  TS("AsmHelloWorld");	TSFile("::/demo/asm/AsmHelloWorld");
  TS("AsmAndC1");	DoAsmAndC1;
  TS("AsmAndC2");	DoAsmAndC2;
  TS("AsmAndC3");	TSFile("::/demo/asm/AsmAndC3");
  TS("MulByHand");	TSFile("::/demo/asm/MulByHand");
  TS("DivByHand");	TSFile("::/demo/asm/DivByHand");
  TS("BuzzFizz");	TSFile("::/demo/asm/BuzzFizz");
  TS("PutDec");		TSFile("::/demo/asm/PutDec");

  task=User;
  TS("Prof");		XTalkWait(task,"DocMax;Prof;HeapLog(ON);\n");
  TS("PCIRep");		XTalkWait(task,"PCIRep;Sleep(750);\n");
  TS("MemBIOSRep");	XTalkWait(task,"MemBIOSRep;Sleep(750);\n");
  TS("MemPageRep");	XTalkWait(task,"MemPageRep;Sleep(750);\n");
  TS("MemRep");		XTalkWait(task,"MemRep;Sleep(750);\n");
  TS("ZipRep");		XTalkWait(task,"ZipRep;Sleep(750);\n");
  TS("ProfRep");	XTalkWait(task,"ProfRep;Sleep(750);\n");
  TS("HeapLogSizeRep");	XTalkWait(task,"HeapLogSizeRep;Sleep(750);\n");
  TS("CPURep");		if (mp_cnt>1)
				XTalkWait(task,"CPURep(TRUE);Sleep(750);\n");
  TS("DskChk");		if (DrvIsWritable(':'))
				XTalkWait(task,"DskChk;Sleep(750);\n");
  TS("DrvView");	if (DrvIsWritable(':')) {
    XTalkWait(task,"DrvView;\n");
    Sleep(750);
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  }
  TS("DskView");	if (DrvIsWritable(':')) {
    XTalkWait(task,"DskView;\n");
    Sleep(250); //Short because ATARep takes time.
    PostMsgWait(task,MSG_KEY_DOWN_UP,CH_SPACE,0);
  }
  TS("ATARep");		XTalkWait(task,"ATARep;\npSleep(750);\n");
  TS("HashDepthRep");	XTalkWait(task,
	"HashDepthRep(adam_task->hash_table);Sleep(750);\n");
  TS("Who");		XTalkWait(task,"Who;Sleep(750);\n");
  TS("DrvRep");		XTalkWait(task,"DrvRep;Sleep(750);\n");
  TS("TaskRep");	XTalkWait(task,"TaskRep;Sleep(750);\n");
  DeathWait(&task,TRUE);

  ProgressBarsRst("TempleOS/OSTestSuite");
  "Elapsed Time:%5.3f\n",tS-ts_t0;
}

OSTestSuite;
