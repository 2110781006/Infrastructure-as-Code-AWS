#uses "CtrlHTTP"

void main()
{
  httpServer(false, 80, 443);  // start http Server
  
  httpConnect("work", "/virt");
}

anytype work(dyn_string names, dyn_string values, string user, string ip,
                 dyn_string headerNames, dyn_string headerValues, int connIdx)
{
  string html = "<html>";
  
  html+="<head><title>Willkommen auf dem Master System</title>";
  html+="<script>";
  html+="function autoRefresh() {";
  html+=    "window.location = window.location.href;";
  html+="}";
  html+="setInterval('autoRefresh()', 3000);";
  html+="</script>";
  html+="</head><body>";
         
  html+= "<b>Systemzeit:</b>"+(string)getCurrentTime();
  
  html+= "<br><b>Hostname:</b>"+getHostname();
  html+= "<br><b>Systemname:</b>"+getSystemName()+"<br><br>";
  
  dyn_int manNums;
  dyn_time times;
  dyn_string hostNames;
  
  dpGet("_DistConnections.Dist.ManNums", manNums,
        "_DistConnections.Dist.StartTimes", times,
        "_DistConnections.Dist.HostNames", hostNames);
  
  html +="</body></html>";
  DebugN(hostNames);
  return html;
}
