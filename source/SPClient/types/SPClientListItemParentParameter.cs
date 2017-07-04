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
    /// Represents the SPClientListItem functions parameter.
    /// </summary>
    public class SPClientListItemParentParameter {
        
        /// <summary>
        /// Gets the parent client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the parent client object which contains list items.</param>
        public SPClientListItemParentParameter(Microsoft.SharePoint.Client.List clientObject) {
            this.ClientObject = clientObject;
        }

    }

}
