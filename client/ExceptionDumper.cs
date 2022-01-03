using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace client
{
    /// <summary>
    ///   Description of ExceptionDumper.
    /// </summary>
    public static class ExceptionDumper
    {
        public static string DumpException(Exception exception,
                                           string fileName = "LastError.log")
        {
            var exceptionString = processException(exception);


            if (false == File.Exists(fileName))
            {
                File.Create(fileName).Close();
            }

            using (var streamWriter = new StreamWriter(new FileStream(fileName,
                                                                      FileMode.Append,
                                                                      FileAccess.Write,
                                                                      FileShare.Write),
                                                       Encoding.UTF8))
            {
                streamWriter.WriteLine("Last exception time: " + DateTime.Now);
                streamWriter.WriteLine(exceptionString);
                streamWriter.Flush();
            }

            return exceptionString;
        }

        private static string processException(Exception exception)
        {
            var result = getExceptionInfo(exception);

            if (null != exception.InnerException)
            {
                result += processException(exception.InnerException);
            }

            return result;
        }

        private static string getExceptionInfo(Exception exception)
        {
            return string.Format("Message: {0}" + Environment.NewLine +
                                 "Source: {1}" + Environment.NewLine +
                                 "Target: {2}" + Environment.NewLine,
                                 exception.Message,
                                 exception.Source,
                                 exception.TargetSite);
        }
    }
}