using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Security;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SPClient.Tests {

    public static class ClientContextLocator {

        private static readonly object lockObject = new object();

        private static ClientContext clientContext = null;

        public static ClientContext GetInstance() {
            var lockTaken = false;
            Monitor.Enter(lockObject, ref lockTaken);
            try {
                if (clientContext == null) {
                    var loginUrl = ConfigurationManager.AppSettings["LoginUrl"];
                    var loginUserName = ConfigurationManager.AppSettings["LoginUserName"];
                    var loginPassword = ConfigurationManager.AppSettings["LoginPassword"];
                    var loginCredential = new NetworkCredential(loginUserName, loginPassword);
                    clientContext = new ClientContext(loginUrl);
                    clientContext.Credentials = new SharePointOnlineCredentials(
                        loginCredential.UserName,
                        loginCredential.SecurePassword);
                }
                return clientContext;
            } finally {
                if (lockTaken == true) {
                    Monitor.Exit(lockObject);
                }
            }
        }

    }

}
