/*
 * SPClientFileConvertPipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that can be converted to a file.
    /// </summary>
    public class SPClientFileConvertPipeBind {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFileConvertPipeBind"/> class.
        /// </summary>
        /// <param name="listItem">the list item which converts to a file.</param>
        public SPClientFileConvertPipeBind(Microsoft.SharePoint.Client.ListItem listItem) {
            this.ClientObject = listItem;
        }

    }

}
