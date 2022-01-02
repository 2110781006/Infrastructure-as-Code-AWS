#uses "CtrlPv2Admin"

main(...)
{
  va_list args;

  int len = va_start(args);
  int winccoaSysNum;
  string winccoaSysName;
  string sub1Ip;
  string sub2Ip;

  for ( int i = 1; i <= len; i++ )
  {
    if (i == len-3)
      winccoaSysNum = va_arg(args);
    else if (i == len-2)
      winccoaSysName = va_arg(args);
    else if (i == len-1)
      sub1Ip = va_arg(args);
    else if (i == len)
      sub2Ip = va_arg(args);
    else
      va_arg(args);  
  }

  paCreateProj("proj", "/opt/winccoa/", makeDynString(), winccoaSysNum, winccoaSysName, 0, "");

  paCfgInsertValue("/opt/winccoa/proj/config/config", "general", "distributed", 1);
  paCfgInsertValue("/opt/winccoa/proj/config/config", "general", "mxProxy", "none");

  if ( winccoaSysName == "master" )//add dist section
  {
    paCfgInsertValue("/opt/winccoa/proj/config/config", "dist", "distPeer", "NOQUOTE:\""+sub1Ip+"\" 2" );
    paCfgInsertValue("/opt/winccoa/proj/config/config", "dist", "distPeer", "NOQUOTE:\""+sub2Ip+"\" 3" );
  }
}