using DotNetCoreWebAppMVC.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Diagnostics;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Sockets;

namespace DotNetCoreWebAppMVC.Controllers
{
    public class HomeController : Controller
    {
        private IConfiguration _configuration;

        public HomeController(IConfiguration configuration)
        {
            _configuration = configuration;
            //test
        }

        public IActionResult Index()
        {
            Program.RequestNumber++;
            string url = Environment.GetEnvironmentVariable("ApiUrl");

            if (string.IsNullOrEmpty(url))
            {
                url = _configuration.GetSection("ApiUrl").Value;
            }

            using (HttpClient client = new HttpClient())
            {
                ResultIp result = new ResultIp();
                try
                {
                    client.BaseAddress = new Uri(url);
                    MediaTypeWithQualityHeaderValue contentType = new MediaTypeWithQualityHeaderValue("application/json");
                    client.DefaultRequestHeaders.Accept.Add(contentType);
                    HttpResponseMessage response = client.GetAsync("/api/LocalMachine").Result;
                    string stringData = response.Content.ReadAsStringAsync().Result;
                    WebApiResult data = JsonConvert.DeserializeObject<WebApiResult>(stringData);
                    result.ApiIp = data.ApiIp;
                    result.ApiMachineName = data.ApiMachineName;
                    result.ApiOS = data.ApiOS;
                    result.ApiRequestNumber = data.RequestNumber;
                }
                catch
                {
                    result.ApiIp = "0.0.0.0";
                    result.ApiMachineName = "machine name";
                    result.ApiOS = "api os - " + url;
                    result.ApiRequestNumber = 0;
                }

                IPHostEntry host;

                host = Dns.GetHostEntry(Dns.GetHostName());
                foreach (IPAddress ip in host.AddressList)
                {
                    if (ip.AddressFamily == AddressFamily.InterNetwork)
                    {
                        result.AppIp = ip.ToString();
                        result.AppMachineName = Environment.MachineName;
                        result.AppOS = Environment.OSVersion.VersionString;
                        result.AppRequestNumber = Program.RequestNumber;
                    }
                }

                return View(result);
            }
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}