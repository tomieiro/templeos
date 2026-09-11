/*See $LK,"TextBase Layer",A="HI:TextBase Layer"$ for the format
of the U32 you pass to TextChar()

See $LK,"::/doc/char_overview.dd"$, $LK,"::/demo/ext_chars.hc"$,
and $LK,"::/demo/graphics/font_ed.hc"$.

Hold <ALT> and press a 3 digit decimal number
or press <CTRL-ALT-a> to enter extended characters.
*/

U0 DrawIt(CTask *task,CDC *)
{
  I64 i;
  for (i=0;i<256;i++)
    TextChar(task,,(i&15)*2,(i/16)*2,i+BLACK<<12+WHITE<<8);
}

U0 ScrnCodes()
{
  SettingsPush; //See $LK,"SettingsPush",A="MN:SettingsPush"$
  DocClear;
  Fs->draw_it=&DrawIt;
  GetChar(,FALSE);
  SettingsPop;
}

ScrnCodes;
