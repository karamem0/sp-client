/*
 * SPClientFolderConvertPipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that can be converted to a folder.
    /// </summary>
    public class SPClientFolderConvertPipeBind {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFolderConvertPipeBind"/> class.
        /// </summary>
        /// <param name="listItem">the list item which converts to a folder.</param>
        public SPClientFolderConvertPipeBind(Microsoft.SharePoint.Client.ListItem listItem) {
            this.ClientObject = listItem;
        }

    }

}
