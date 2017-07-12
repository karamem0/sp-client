/*
 * SPClientWebTemplateIdentityParameter.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a value that identifies site template.
    /// </summary>
    public class SPClientWebTemplateIdentityParameter {

        /// <summary>
        /// Indicates the value.
        /// </summary>
        private object value;

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientWebTemplateIdentityParameter"/> class.
        /// </summary>
        /// <param name="siteTemplateName">the site template name.</param>
        public SPClientWebTemplateIdentityParameter(string siteTemplateName) {
            this.value = siteTemplateName;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientWebTemplateIdentityParameter"/> class.
        /// </summary>
        /// <param name="siteTemplate">the site template.</param>
        public SPClientWebTemplateIdentityParameter(Microsoft.SharePoint.Client.WebTemplate siteTemplate) {
            this.value = siteTemplate;
        }

        /// <summary>
        /// Returns the value that identifies a web template.
        /// </summary>
        /// <param name="clientContext">the client context.</param>
        public string GetValue(Microsoft.SharePoint.Client.ClientContext clientContext) {
            var value = this.value as Microsoft.SharePoint.Client.WebTemplate;
            if (value != null) {
                return value.Name;
            } else {
                return this.value.ToString();
            }
        }

    }

}
