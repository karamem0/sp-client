using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace SPClient.Helpers {

    public static class RetrievalExpressionBuilder {

        public static IEnumerable<Expression> CreateExpression(ClientObject clientObject, string inputString) {
            var objectType = clientObject.GetType();
            var funcType = typeof(Func<,>).MakeGenericType(objectType, typeof(object));
            var expressionType = typeof(Expression<>).MakeGenericType(funcType);
            if (string.IsNullOrEmpty(inputString) != true) {
                if (objectType.IsSubclassOf(typeof(ClientObjectCollection)) == true) {
                    if (inputString.StartsWith("Include(", StringComparison.InvariantCultureIgnoreCase) != true ||
                        inputString.EndsWith(")", StringComparison.InvariantCultureIgnoreCase) != true) {
                        inputString = "Include(" + inputString + ")";
                    }
                    var parameterExpression = Expression.Parameter(objectType, objectType.Name);
                    var propertyExpression = CreateIncludeExpression(parameterExpression, inputString);
                    var lambdaExpression = Expression.Lambda(funcType, propertyExpression, parameterExpression);
                    yield return lambdaExpression;
                } else {
                    if (inputString.StartsWith("Include(", StringComparison.InvariantCultureIgnoreCase) == true &&
                        inputString.EndsWith(")", StringComparison.InvariantCultureIgnoreCase) == true) {
                        inputString = inputString.Substring(8, inputString.Length - 9);
                    }
                    foreach (var splitString in SplitString(inputString, ',')) {
                        var parameterExpression = Expression.Parameter(objectType, objectType.Name);
                        var propertyExpression = CreateMemberAccessExpression(parameterExpression, splitString);
                        var convertExpression = Expression.Convert(propertyExpression, typeof(object));
                        var lambdaExpression = Expression.Lambda(funcType, convertExpression, parameterExpression);
                        yield return lambdaExpression;
                    }
                }
            }
        }

        private static Expression CreateIncludeExpression(Expression baseExpression, string inputString) {
            if (inputString.StartsWith("Include(") != true) {
                throw new ArgumentException(string.Format(Properties.Resources.StringNotStartWithInclude, nameof(inputString)));
            }
            if (inputString.EndsWith(")") != true) {
                throw new ArgumentException(string.Format(Properties.Resources.StringNotEndWithInclude, nameof(inputString)));
            }
            inputString = inputString.Substring(8, inputString.Length - 9);
            var extensionType = typeof(ClientObjectQueryableExtension);
            var objectType = baseExpression.Type.BaseType.GenericTypeArguments[0];
            var funcType = typeof(Func<,>).MakeGenericType(objectType, typeof(object));
            var expressionType = typeof(Expression<>).MakeGenericType(funcType);
            var lambdaExpressions = new List<Expression>();
            var splitStrings = SplitString(inputString, ',').ToArray();
            if (splitStrings.Length != 1 || splitStrings[0] != "*") {
                lambdaExpressions.AddRange(splitStrings.Select(splitString => {
                    var parameterExpression = Expression.Parameter(objectType, objectType.Name);
                    var propertyExpression = CreateMemberAccessExpression(parameterExpression, splitString);
                    var convertExpression = Expression.Convert(propertyExpression, typeof(object));
                    var lambdaExpression = Expression.Lambda(funcType, convertExpression, parameterExpression);
                    return lambdaExpression;
                }));
            }
            if (splitStrings.Contains("*") == true) {
                return Expression.Call(
                    extensionType.GetMethod("IncludeWithDefaultProperties").MakeGenericMethod(objectType),
                    new Expression[] { baseExpression, Expression.NewArrayInit(expressionType, lambdaExpressions) });
            } else {
                return Expression.Call(
                    extensionType.GetMethod("Include").MakeGenericMethod(objectType),
                    new Expression[] { baseExpression, Expression.NewArrayInit(expressionType, lambdaExpressions) });
            }
        }

        private static Expression CreateMemberAccessExpression(Expression baseExpression, string inputString) {
            var expression = baseExpression;
            if (inputString != "*") {
                var type = baseExpression.Type;
                foreach (var splitString in SplitString(inputString, '.')) {
                    if (type.IsSubclassOf(typeof(ClientObjectCollection)) == true) {
                        return CreateIncludeExpression(expression, splitString);
                    } else {
                        var property = type.GetProperty(splitString);
                        if (property == null) {
                            throw new ArgumentException(string.Format(Properties.Resources.TypeHasNoMember, type, splitString));
                        }
                        expression = Expression.Property(expression, property);
                        type = property.PropertyType;
                    }
                }
            }
            return expression;
        }

        private static IEnumerable<string> SplitString(string inputString, char separatorChar) {
            var buffer = string.Empty;
            var depth = 0;
            for (var index = 0; index < inputString.Length; index++) {
                var c = inputString[index];
                if (c == separatorChar) {
                    if (depth == 0) {
                        yield return buffer.Trim();
                        buffer = string.Empty;
                        continue;
                    }
                }
                if (c == '(') {
                    depth++;
                }
                if (c == ')') {
                    depth--;
                }
                buffer += c;
            }
            if (depth != 0) {
                throw new ArgumentException(Properties.Resources.BracesIsNotClosed);
            }
            yield return buffer.Trim();
        }

    }

}
