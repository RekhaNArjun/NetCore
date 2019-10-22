using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DotNetCoreWebAppMVC.Models
{
    public class ResultIp
    {
        public string ApiIp { get; set; }
        public string ApiMachineName { get; set; }
        public string ApiOS { get; set; }
        public int ApiRequestNumber { get; set; }
        public string AppIp { get; set; }
        public string AppMachineName { get; set; }
        public string AppOS { get; set; }
        public int AppRequestNumber { get; set; }
    }
}