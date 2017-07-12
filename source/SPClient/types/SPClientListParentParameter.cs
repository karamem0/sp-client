/*
 * SPClientListParentParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that is the parent of lists.
    /// </summary>
    public class SPClientListParentParameter {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListParentParameter"/> class.
        /// </summary>
        /// <param name="web">the site which contains lists.</param>
        public SPClientListParentParameter(Microsoft.SharePoint.Client.Web web) {
            this.ClientObject = web;
        }

    }

}
