/*
 * SPClientWebParentParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents the SPClientWeb functions parameter.
    /// </summary>
    public class SPClientWebParentParameter {
        
        /// <summary>
        /// Gets the parent client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientWebParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the parent client object which contains views.</param>
        public SPClientWebParentParameter(Microsoft.SharePoint.Client.Web clientObject) {
            this.ClientObject = clientObject;
        }

    }

}
