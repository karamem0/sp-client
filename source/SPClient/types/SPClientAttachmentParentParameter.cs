/*
 * SPClientAttachmentParentParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents the SPClientAttachment functions parameter.
    /// </summary>
    public class SPClientAttachmentParentParameter {
        
        /// <summary>
        /// Gets the parent client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientContentTypeParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the parent client object which contains attachments.</param>
        public SPClientAttachmentParentParameter(Microsoft.SharePoint.Client.ListItem clientObject) {
            this.ClientObject = clientObject;
        }

    }

}
