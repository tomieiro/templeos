//See $LK,"::/demo/games/stadium/stadium_gen.hc"$.

U0 Main()
{
  "Capture scrn...\n";
  PressAKey;
  GRScrnCaptureWrite("~/DemoScrnShot");
  "View captured scrn...\n";
  PressAKey;
  GRScrnCaptureRead("~/DemoScrnShot");
  PressAKey;
  DCFill;
}

Main;
