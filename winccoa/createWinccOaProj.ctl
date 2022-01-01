#uses "CtrlPv2Admin"

main()
{
  paCreateProj("proj", "/opt/winccoa/", makeDynString(), getenv("winccoaSysNum"), getenv("winccoaSysName"), 0);
}