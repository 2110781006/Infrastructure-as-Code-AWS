#uses "CtrlPv2Admin"

main()
{
  paCreateProj("proj", "/opt/winccoa/", makeDynString(), getenv("winccoaSysNum"), getenv("winccoaSysName"), 0);

  paCfgInsertValue("/opt/winccoa/proj/config/config", "general", "distributed", 1);
  paCfgInsertValue("/opt/winccoa/proj/config/config", "general", "mxProxy", "none");

  if ( getenv("winccoaSysName") == "master" )//add dist section
  {
    paCfgInsertValue("/opt/winccoa/proj/config/config", "dist", "distPeer", "test");
  }
}