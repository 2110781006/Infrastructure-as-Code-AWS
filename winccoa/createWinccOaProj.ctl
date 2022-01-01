#uses "CtrlPv2Admin"

main(...)
{
  va_list args;

  va_start(args);
  int winccoaSysNum = va_arg(args);
  string winccoaSysName = va_arg(args);

  paCreateProj("proj", "/opt/winccoa/", makeDynString(), winccoaSysNum, winccoaSysName, 0);

  paCfgInsertValue("/opt/winccoa/proj/config/config", "general", "distributed", 1);
  paCfgInsertValue("/opt/winccoa/proj/config/config", "general", "mxProxy", "none");

  if ( winccoaSysName == "master" )//add dist section
  {
    paCfgInsertValue("/opt/winccoa/proj/config/config", "dist", "distPeer", "NOQUOTE:\"myValue\" 2" );
    paCfgInsertValue("/opt/winccoa/proj/config/config", "dist", "distPeer", "NOQUOTE:\"myValue\" 3" );
  }
}