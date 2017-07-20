/*
 * SPClientAttachmentParentPipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a client object that is the parent of attachments.
    /// </summary>
    public class SPClientAttachmentParentPipeBind {
        
        /// <summary>
        /// Gets the client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientContentTypeParentPipeBind"/> class.
        /// </summary>
        /// <param name="listItem">the list item which contains attachments.</param>
        public SPClientAttachmentParentPipeBind(Microsoft.SharePoint.Client.ListItem listItem) {
            this.ClientObject = listItem;
        }

    }

}
