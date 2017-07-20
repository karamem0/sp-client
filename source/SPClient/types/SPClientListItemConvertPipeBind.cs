/*
 * SPClientListItemConvertPipeBind.cs
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
    public class SPClientListItemConvertPipeBind {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemConvertPipeBind"/> class.
        /// </summary>
        /// <param name="folder">the folder which converts to a list item.</param>
        public SPClientListItemConvertPipeBind(Microsoft.SharePoint.Client.Folder folder) {
            this.ClientObject = folder;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListItemConvertPipeBind"/> class.
        /// </summary>
        /// <param name="file">the file which converts to a list item.</param>
        public SPClientListItemConvertPipeBind(Microsoft.SharePoint.Client.File file) {
            this.ClientObject = file;
        }

    }

}
