/*
 * SPClientFieldParentPipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that is the parent of columns.
    /// </summary>
    public class SPClientFieldParentPipeBind {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldParentPipeBind"/> class.
        /// </summary>
        /// <param name="web">the site which contains columns.</param>
        public SPClientFieldParentPipeBind(Microsoft.SharePoint.Client.Web web) {
            this.ClientObject = web;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldParentPipeBind"/> class.
        /// </summary>
        /// <param name="list">the list which contains columns.</param>
        public SPClientFieldParentPipeBind(Microsoft.SharePoint.Client.List list) {
            this.ClientObject = list;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldParentPipeBind"/> class.
        /// </summary>
        /// <param name="contentType">the content type which contains columns.</param>
        public SPClientFieldParentPipeBind(Microsoft.SharePoint.Client.ContentType contentType) {
            this.ClientObject = contentType;
        }

    }

}
