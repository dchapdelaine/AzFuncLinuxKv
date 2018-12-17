using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace Company.Function
{
    public static class ReturnSecret
    {
        // Following the documentation here (https://docs.microsoft.com/en-us/azure/app-service/app-service-key-vault-references)
        // the Secret environment variable actually refers to a secret in KeyVault.
        private static string secret = System.Environment.GetEnvironmentVariable("Secret");

        [FunctionName("ReturnSecret")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            return (ActionResult)new OkObjectResult($"My secret is, {secret}");
        }
    }
}
