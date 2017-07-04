/*
 * SPClientListItemConvertParameter.cs
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
    public class SPClientListItemConvertParameter {
        
        /// <summary>
        /// Gets the parent client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemConvertParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the client object which converts to a list item.</param>
        public SPClientListItemConvertParameter(Microsoft.SharePoint.Client.Folder clientObject) {
            this.ClientObject = clientObject;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemConvertParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the client object which converts to a list item.</param>
        public SPClientListItemConvertParameter(Microsoft.SharePoint.Client.File clientObject) {
            this.ClientObject = clientObject;
        }

    }

}
