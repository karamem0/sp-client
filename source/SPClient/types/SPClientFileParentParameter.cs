/*
 * SPClientFileParentParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents the SPClientFile functions parameter.
    /// </summary>
    public class SPClientFileParentParameter {
        
        /// <summary>
        /// Gets the parent client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFileParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the parent client object which contains files.</param>
        public SPClientFileParentParameter(Microsoft.SharePoint.Client.Folder clientObject) {
            this.ClientObject = clientObject;
        }

    }

}
