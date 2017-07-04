/*
 * SPClientListParentParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents the SPClientList functions parameter.
    /// </summary>
    public class SPClientListParentParameter {
        
        /// <summary>
        /// Gets the parent client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientListParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the parent client object which contains lists.</param>
        public SPClientListParentParameter(Microsoft.SharePoint.Client.Web clientObject) {
            this.ClientObject = clientObject;
        }

    }

}
