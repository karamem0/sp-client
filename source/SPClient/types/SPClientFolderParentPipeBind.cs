/*
 * SPClientFolderParentPipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that is the parent of subfolders.
    /// </summary>
    public class SPClientFolderParentPipeBind {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFolderParentPipeBind"/> class.
        /// </summary>
        /// <param name="folder">the folder which contains subfolders.</param>
        public SPClientFolderParentPipeBind(Microsoft.SharePoint.Client.Folder folder) {
            this.ClientObject = folder;
        }

    }

}
