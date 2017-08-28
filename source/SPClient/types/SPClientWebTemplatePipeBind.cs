/*
 * SPClientWebTemplatePipeBind.cs
 *
 * Copyright (c) 2017 karamem0
 *
 * This software is released under the MIT License.
 * https://github.com/karamem0/SPClient/blob/master/LICENSE
 */

using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SPClient {

    /// <summary>
    /// Represents a parameter that stores a site template.
    /// </summary>
    public class SPClientWebTemplatePipeBind {

        /// <summary>
        /// Indicates the site template name.
        /// </summary>
        private string webTemplateName;

        /// <summary>
        /// Indicates the site template.
        /// </summary>
        private WebTemplate webTemplate;

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientWebTemplatePipeBind"/> class.
        /// </summary>
        /// <param name="webTemplateName">the site template name.</param>
        public SPClientWebTemplatePipeBind(string webTemplateName) {
            if (webTemplateName == null) {
                throw new ArgumentNullException("webTemplateName");
            }
            this.webTemplateName = webTemplateName;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientWebTemplatePipeBind"/> class.
        /// </summary>
        /// <param name="webTemplate">the site template.</param>
        public SPClientWebTemplatePipeBind(WebTemplate webTemplate) {
            if (webTemplate == null) {
                throw new ArgumentNullException("webTemplate");
            }
            this.webTemplate = webTemplate;
        }

        /// <summary>
        /// Returns the site template.
        /// </summary>
        /// <param name="web">the parent site.</param>
        /// <param name="lcid">the locale id.</param>
        public WebTemplate GetWebTemplate(Web web, uint lcid) {
            if (this.webTemplate == null && this.webTemplateName != null) {
                var webTemplates = web.GetAvailableWebTemplates(lcid, true);
                web.Context.Load(webTemplates);
                web.Context.ExecuteQuery();
                this.webTemplate = webTemplates.Single(item => item.Name == this.webTemplateName);
            }
            return this.webTemplate;
        }

    }

}
