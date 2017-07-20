/*
 * SPClientFieldIdentityPipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a value that identifies field.
    /// </summary>
    public class SPClientFieldIdentityPipeBind {

        /// <summary>
        /// Indicates the value.
        /// </summary>
        private object value;

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldIdentityPipeBind"/> class.
        /// </summary>
        /// <param name="fieldId">the column GUID.</param>
        public SPClientFieldIdentityPipeBind(System.Guid fieldId) {
            this.value = fieldId;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldIdentityPipeBind"/> class.
        /// </summary>
        /// <param name="fieldInternalName">the column internal name.</param>
        public SPClientFieldIdentityPipeBind(string fieldInternalName) {
            this.value = fieldInternalName;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldIdentityPipeBind"/> class.
        /// </summary>
        /// <param name="field">the column.</param>
        public SPClientFieldIdentityPipeBind(Microsoft.SharePoint.Client.Field field) {
            this.value = field;
        }

        /// <summary>
        /// Returns the value that identifies a field.
        /// </summary>
        /// <param name="clientContext">the client context.</param>
        public string GetValue(Microsoft.SharePoint.Client.ClientContext clientContext) {
            var value = this.value as Microsoft.SharePoint.Client.Field;
            if (value != null) {
                clientContext.Load(value);
                clientContext.ExecuteQuery();
                return value.InternalName;
            } else {
                return this.value.ToString();
            }
        }

    }

}
