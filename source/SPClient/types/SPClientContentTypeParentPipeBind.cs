/*
 * SPClientContentTypeParentPipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that is the parent of content types.
    /// </summary>
    public class SPClientContentTypeParentPipeBind {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientContentTypeParentPipeBind"/> class.
        /// </summary>
        /// <param name="web">the site which contains content types.</param>
        public SPClientContentTypeParentPipeBind(Microsoft.SharePoint.Client.Web web) {
            this.ClientObject = web;
        }
        
        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientContentTypeParentPipeBind"/> class.
        /// </summary>
        /// <param name="list">the list which contains content types.</param>
        public SPClientContentTypeParentPipeBind(Microsoft.SharePoint.Client.List list) {
            this.ClientObject = list;
        }

    }

}
