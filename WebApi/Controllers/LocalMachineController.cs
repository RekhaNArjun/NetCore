using Microsoft.AspNetCore.Mvc;
using System;
using System.Net;
using System.Net.Sockets;

namespace DotnetCoreWebApp.Controllers
{
    [Route("api/[controller]")]
    public class LocalMachineController : Controller
    {
        [HttpGet]
        public MachineIp Get()
        {
            MachineIp mIp = new MachineIp();
            IPHostEntry host;
            Program.RequestNumber++;
            host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (IPAddress ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    mIp.ApiIp = ip.ToString();
                    mIp.ApiMachineName = Environment.MachineName;
                    mIp.ApiOS = Environment.OSVersion.VersionString;
                    mIp.RequestNumber = Program.RequestNumber;
                }
            }

            return mIp;
        }
    }
}