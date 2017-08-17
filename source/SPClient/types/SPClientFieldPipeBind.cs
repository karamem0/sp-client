/*
 * SPClientFieldPipeBind.cs
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
    /// Represents a parameter that stores a column.
    /// </summary>
    public class SPClientFieldPipeBind {

        /// <summary>
        /// Indicates the column GUID.
        /// </summary>
        private Guid fieldId;

        /// <summary>
        /// Indicates the column title or internal name.
        /// </summary>
        private string fieldName;

        /// <summary>
        /// Indicates the column.
        /// </summary>
        private Field field;

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldPipeBind"/> class.
        /// </summary>
        /// <param name="fieldId">the column GUID.</param>
        public SPClientFieldPipeBind(Guid fieldId) {
            if (fieldId == Guid.Empty) {
                throw new ArgumentNullException("fieldId");
            }
            this.fieldId = fieldId;
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldPipeBind"/> class.
        /// </summary>
        /// <param name="fieldName">the column title or internal name.</param>
        public SPClientFieldPipeBind(string fieldName) {
            if (fieldName == null) {
                throw new ArgumentNullException("fieldName");
            }
            var fieldId = Guid.Empty;
            if (Guid.TryParse(fieldName, out fieldId) == true) {
                this.fieldId = fieldId;
            } else {
                this.fieldName = fieldName;
            }
        }

        /// <summary>
        /// Initializes the new instance of <see cref="SPClient.SPClientFieldPipeBind"/> class.
        /// </summary>
        /// <param name="field">the column.</param>
        public SPClientFieldPipeBind(Field field) {
            if (field == null) {
                throw new ArgumentNullException("field");
            }
            this.field = field;
        }

        /// <summary>
        /// Returns the column.
        /// </summary>
        /// <param name="list">the parent list.</param>
        public Field GetField(List list) {
            if (this.field == null && this.fieldId != Guid.Empty) {
                this.field = list.Fields.GetById(this.fieldId);
                list.Context.Load(this.field);
                list.Context.ExecuteQuery();
            }
            if (this.field == null && this.fieldName != null) {
                this.field = list.Fields.GetByInternalNameOrTitle(this.fieldName);
                list.Context.Load(this.field);
                list.Context.ExecuteQuery();
            }
            return this.field;
        }

    }

}
