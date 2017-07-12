/*
 * SPClientListItemParentParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that is the parent of list items.
    /// </summary>
    public class SPClientListItemParentParameter {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the list which contains list items.</param>
        public SPClientListItemParentParameter(Microsoft.SharePoint.Client.List list) {
            this.ClientObject = list;
        }

    }

}
