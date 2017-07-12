/*
 * SPClientViewParentParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that is the parent of views.
    /// </summary>
    public class SPClientViewParentParameter {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientViewParentParameter"/> class.
        /// </summary>
        /// <param name="list">the list which contains views.</param>
        public SPClientViewParentParameter(Microsoft.SharePoint.Client.List list) {
            this.ClientObject = list;
        }

    }

}
