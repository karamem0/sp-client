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
    /// Represents a parameter that stores a client object that can be converted to a list item.
    /// </summary>
    public class SPClientListItemConvertParameter {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemConvertParameter"/> class.
        /// </summary>
        /// <param name="folder">the folder which converts to a list item.</param>
        public SPClientListItemConvertParameter(Microsoft.SharePoint.Client.Folder folder) {
            this.ClientObject = folder;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemConvertParameter"/> class.
        /// </summary>
        /// <param name="file">the file which converts to a list item.</param>
        public SPClientListItemConvertParameter(Microsoft.SharePoint.Client.File file) {
            this.ClientObject = file;
        }

    }

}
