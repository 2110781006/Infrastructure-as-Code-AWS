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
  html+="<style>";
  html+="table, th, td {";
  html+="  border: 1px solid black;";
  html+="  border-collapse: collapse;";
  html+="}";
  html+="</style>";
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

  html+= "<br><b>Verbundene Systeme:</b>";

  html+="<table><tr><th>Systemnummer</th><th>Startzeit</th><th>Host</th><th>Systemname</th></tr>";

  for ( int i = 1; i <= dynlen(manNums); i++ )
  {
    html+="<tr><td>"+manNums[i]+"</td><td>"+((string)times[i])+"</td><td>"+hostNames[i]+"</td><td>"+getSystemName(manNums[i])+"</td></tr>";
  }

  html+="</table>"+manNums+":"+getSystemNames();
  
  html +="</body></html>";

  return html;
}
