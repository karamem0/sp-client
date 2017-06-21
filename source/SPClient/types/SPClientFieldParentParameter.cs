﻿namespace SPClient {

    /// <summary>
    /// Represents the SPClientField functions parameter.
    /// </summary>
    public class SPClientFieldParentParameter {
        
        /// <summary>
        /// Gets the parent client object.
        /// </summary>
        public Microsoft.SharePoint.Client.ClientObject ClientObject { get; private set; }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the parent client object which contains content types.</param>
        public SPClientFieldParentParameter(Microsoft.SharePoint.Client.Web clientObject) {
            this.ClientObject = clientObject;
        }
        
        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldParentParameter"/> class.
        /// </summary>
        /// <param name="clientObject">the parent client object which contains content types.</param>
        public SPClientFieldParentParameter(Microsoft.SharePoint.Client.List clientObject) {
            this.ClientObject = clientObject;
        }

    }

}