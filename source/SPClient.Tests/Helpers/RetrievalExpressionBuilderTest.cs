using Microsoft.SharePoint.Client;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SPClient.Tests;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SPClient.Helpers.Tests {

    [TestClass()]
    public class RetrievalExpressionBuilderTest {

        [TestMethod()]
        [Description("Create client object retrieval expressions without retrieval string.")]
        public void CreateTest1() {
            var clientContext = ClientContextLocator.GetInstance();
            var args = new {
                ClientObject = clientContext.Web,
                InputString = (string)null,
            };
            var expected = new Expression[] { };
            var actual = RetrievalExpressionBuilder.CreateExpression(
                args.ClientObject,
                args.InputString).ToArray();
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected.Length, actual.Length);
        }

        [TestMethod()]
        [Description("Create client object retrieval expressions with retrieval string that contains specified properties.")]
        public void CreateTest2() {
            var clientContext = ClientContextLocator.GetInstance();
            var args = new {
                ClientObject = clientContext.Web,
                InputString = "Id, RootFolder.ServerRelativeUrl",
            };
            var expected = new Expression[] {
                (Expression<Func<Web, object>>)(Web => (object)Web.Id),
                (Expression<Func<Web, object>>)(Web => (object)Web.RootFolder.ServerRelativeUrl)
            };
            var actual = RetrievalExpressionBuilder.CreateExpression(
                args.ClientObject,
                args.InputString).ToArray();
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected.Length, actual.Length);
            Assert.AreEqual(expected[0].ToString(), actual[0].ToString());
            Assert.AreEqual(expected[1].ToString(), actual[1].ToString());
        }

        [TestMethod()]
        [Description("Create client object retrieval expressions with retrieval string that contains all properties.")]
        public void CreateTest3() {
            var clientContext = ClientContextLocator.GetInstance();
            var args = new {
                ClientObject = clientContext.Web,
                InputString = "*, RootFolder.ServerRelativeUrl",
            };
            var expected = new Expression[] {
                (Expression<Func<Web, object>>)(Web => (object)Web),
                (Expression<Func<Web, object>>)(Web => (object)Web.RootFolder.ServerRelativeUrl)
            };
            var actual = RetrievalExpressionBuilder.CreateExpression(
                args.ClientObject,
                args.InputString).ToArray();
            Assert.AreEqual(expected.Length, actual.Length);
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected[0].ToString(), actual[0].ToString());
            Assert.AreEqual(expected[1].ToString(), actual[1].ToString());
        }

        [TestMethod()]
        [Description("Create client object collection retrieval expressions without retrieval string.")]
        public void CreateTest4() {
            var clientContext = ClientContextLocator.GetInstance();
            var args = new {
                ClientObject = clientContext.Web.Lists,
                InputString = (string)null,
            };
            var expected = new Expression[] { };
            var actual = RetrievalExpressionBuilder.CreateExpression(
                args.ClientObject,
                args.InputString).ToArray();
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected.Length, actual.Length);
        }

        [TestMethod()]
        [Description("Create client object retrieval expressions with retrieval string that contains specified properties.")]
        public void CreateTest5() {
            var clientContext = ClientContextLocator.GetInstance();
            var args = new {
                ClientObject = clientContext.Web.Lists,
                InputString = "Include(Id, RootFolder.ServerRelativeUrl)",
            };
            var expected = new Expression[] {
                (Expression<Func<ListCollection, object>>)(ListCollection => ListCollection.Include(
                    List => (object)List.Id,
                    List => (object)List.RootFolder.ServerRelativeUrl)),
            };
            var actual = RetrievalExpressionBuilder.CreateExpression(
                args.ClientObject,
                args.InputString).ToArray();
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected.Length, actual.Length);
            Assert.AreEqual(expected[0].ToString(), actual[0].ToString());
        }

        [TestMethod()]
        [Description("Create client object retrieval expressions with retrieval string that contains all properties.")]
        public void CreateTest6() {
            var clientContext = ClientContextLocator.GetInstance();
            var args = new {
                ClientObject = clientContext.Web.Lists,
                InputString = "Include(*, RootFolder.ServerRelativeUrl)",
            };
            var expected = new Expression[] {
                (Expression<Func<ListCollection, object>>)(ListCollection => ListCollection.IncludeWithDefaultProperties(
                    List => (object)List,
                    List => (object)List.RootFolder.ServerRelativeUrl)),
            };
            var actual = RetrievalExpressionBuilder.CreateExpression(
                args.ClientObject,
                args.InputString).ToArray();
            Assert.AreEqual(expected.Length, actual.Length);
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected[0].ToString(), actual[0].ToString());
        }

    }

}
